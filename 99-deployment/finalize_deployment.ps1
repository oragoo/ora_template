[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string[]]$Schemas,

    [string]$SqlPlusCommand = 'sqlplus',

    [switch]$ValidateOnly
)

$ErrorActionPreference = 'Stop'

$targetSchemas = @($Schemas | ForEach-Object {
    $schemaName = $_.Trim().ToUpperInvariant()
    if ($schemaName -notmatch '^[A-Z][A-Z0-9_$#]{0,127}$') {
        throw 'Lista ciljnih shema mora sadrzati neprazne Oracle nazive bez navodnika.'
    }
    $schemaName
} | Select-Object -Unique)

$connectionSettings = @('FLYWAY_URL', 'FLYWAY_USER', 'FLYWAY_PASSWORD')
foreach ($settingName in $connectionSettings) {
    $settingValue = [Environment]::GetEnvironmentVariable($settingName)
    if ([string]::IsNullOrWhiteSpace($settingValue)) {
        throw "Nedostaje $settingName za zavrsnu provjeru."
    }
    if ($settingValue -match '["\r\n]') {
        throw "$settingName sadrzi znakove koje ovaj SQL*Plus nacin povezivanja ne podrzava."
    }
}

$jdbcPrefix = 'jdbc:oracle:thin:@'
if (-not $env:FLYWAY_URL.StartsWith($jdbcPrefix, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Zavrsna provjera zahtijeva Oracle thin JDBC URL oblika jdbc:oracle:thin:@<connect_identifier>.'
}
$connectIdentifier = $env:FLYWAY_URL.Substring($jdbcPrefix.Length)
if ([string]::IsNullOrWhiteSpace($connectIdentifier)) {
    throw 'Oracle JDBC URL ne sadrzi connect identifier.'
}

$sqlPlus = Get-Command -Name $SqlPlusCommand -CommandType Application -ErrorAction Stop |
    Select-Object -First 1
$sqlScripts = [ordered]@{
    RECOMPILE = Join-Path $PSScriptRoot 'sql/recompile_schema.sql'
    CHECK = Join-Path $PSScriptRoot 'sql/check_invalids.sql'
}
foreach ($scriptPath in $sqlScripts.Values) {
    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) {
        throw "Nedostaje deployment skripta: $scriptPath"
    }
}

if ($ValidateOnly) {
    Write-Host 'SQL*Plus, konfiguracija i zavrsne deployment skripte su prisutni.'
    return
}

$failedChecks = [System.Collections.Generic.List[string]]::new()

# Prvo rekompajlirati sve sheme, zatim provjeriti sve sheme.
foreach ($phase in $sqlScripts.Keys) {
    foreach ($schemaName in $targetSchemas) {
        Write-Host "${phase}: $schemaName"
        $scriptPath = $sqlScripts[$phase]
        $sqlInput = @(
            'whenever sqlerror exit failure rollback'
            'whenever oserror exit failure rollback'
            'set echo off'
            'set verify off'
            'set define off'
            ('connect "' + $env:FLYWAY_USER + '"/"' + $env:FLYWAY_PASSWORD + '"@"' + $connectIdentifier + '"')
            'set echo off'
            'set verify off'
            'set define on'
            ('@"' + $scriptPath + '" ' + $schemaName)
            # Ako SQL*Plus ne uspije ucitati skriptu, rezultat mora biti neuspjesan.
            'exit failure rollback'
        ) -join [Environment]::NewLine

        try {
            # Konekcija se salje kroz stdin; tajne ne ulaze u argumente procesa ili fajlove.
            $clientOutput = @($sqlInput | & $sqlPlus.Source -L -S /nolog 2>&1)
            $clientExitCode = $LASTEXITCODE
            $outputText = ($clientOutput | ForEach-Object { [string]$_ }) -join [Environment]::NewLine
            $safeOutput = $outputText.Replace($env:FLYWAY_PASSWORD, '***').Replace($connectIdentifier, '***')
            if ($safeOutput) {
                Write-Host $safeOutput
            }

            $expectedResult = "OK: ${phase}: $schemaName"
            if ($clientExitCode -ne 0 -or
                $outputText -match '(?m)^\s*(SP2|CPY)-\d+:' -or
                -not $outputText.Contains($expectedResult)) {
                $failedChecks.Add("${phase}: $schemaName")
            }
        }
        catch {
            $failedChecks.Add("${phase}: $schemaName")
            Write-Host "SQL*Plus poziv nije uspio: ${phase}: $schemaName"
        }
    }
}

if ($failedChecks.Count -gt 0) {
    throw ('Zavrsna provjera nije uspjela: ' + ($failedChecks -join ', '))
}

Write-Host ('Sve ciljne sheme su validne: ' + ($targetSchemas -join ', '))
