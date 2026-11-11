[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ProjectName,

    [string]$ProjectSlug,
    [string]$RepositoryName,
    [string]$DbSchema,
    [string]$DocIdPrefix,
    [string]$AppFolder
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($ProjectSlug)) {
    $ProjectSlug = $ProjectName.Trim().ToLowerInvariant() -replace '[^a-z0-9]+', '-'
    $ProjectSlug = $ProjectSlug.Trim('-')
}

if ($ProjectSlug -notmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
    throw 'ProjectSlug mora sadrzati mala slova, brojeve i pojedinacne crtice.'
}

if ([string]::IsNullOrWhiteSpace($RepositoryName)) {
    $RepositoryName = 'ora_' + ($ProjectSlug -replace '-', '_')
}
if ([string]::IsNullOrWhiteSpace($DbSchema)) {
    $DbSchema = ($ProjectSlug -replace '-', '_').ToUpperInvariant()
}
if ([string]::IsNullOrWhiteSpace($DocIdPrefix)) {
    $DocIdPrefix = $DbSchema
}
if ([string]::IsNullOrWhiteSpace($AppFolder)) {
    $AppFolder = $ProjectSlug
}

$open = '{{'
$close = '}}'
$replacements = [ordered]@{
    ($open + 'PROJECT_NAME' + $close) = $ProjectName
    ($open + 'PROJECT_SLUG' + $close) = $ProjectSlug
    ($open + 'REPOSITORY_NAME' + $close) = $RepositoryName
    ($open + 'DB_SCHEMA' + $close) = $DbSchema.ToUpperInvariant()
    ($open + 'DOC_ID_PREFIX' + $close) = $DocIdPrefix.ToUpperInvariant()
    ($open + 'APP_FOLDER' + $close) = $AppFolder
}

$textExtensions = @(
    '.md', '.txt', '.yml', '.yaml', '.json', '.xml', '.sql', '.ps1', '.sh',
    '.js', '.jsx', '.ts', '.tsx', '.css', '.scss', '.html', '.properties',
    '.toml', '.ini', '.env', '.example', '.gitignore', '.editorconfig',
    '.code-workspace'
)

$files = Get-ChildItem -LiteralPath $repoRoot -File -Recurse -Force |
    Where-Object {
        $_.FullName -notlike "*$([IO.Path]::DirectorySeparatorChar).git$([IO.Path]::DirectorySeparatorChar)*" -and
        ($textExtensions -contains $_.Extension -or $_.Name -in @('.gitignore', '.editorconfig'))
    }

$utf8NoBom = [Text.UTF8Encoding]::new($false)
foreach ($file in $files) {
    $content = [IO.File]::ReadAllText($file.FullName)
    $updated = $content
    foreach ($entry in $replacements.GetEnumerator()) {
        $updated = $updated.Replace([string]$entry.Key, [string]$entry.Value)
    }
    if ($updated -ne $content) {
        [IO.File]::WriteAllText($file.FullName, $updated, $utf8NoBom)
    }
}

$workspaceFile = Join-Path $repoRoot 'ora_template.code-workspace'
if (Test-Path -LiteralPath $workspaceFile) {
    $newWorkspaceFile = Join-Path $repoRoot ($RepositoryName + '.code-workspace')
    Move-Item -LiteralPath $workspaceFile -Destination $newWorkspaceFile
}

$remaining = Get-ChildItem -LiteralPath $repoRoot -File -Recurse -Force |
    Where-Object {
        $_.FullName -ne $PSCommandPath -and
        $_.FullName -notlike "*$([IO.Path]::DirectorySeparatorChar).git$([IO.Path]::DirectorySeparatorChar)*"
    } |
    Select-String -Pattern '\{\{[A-Z0-9_]+\}\}' -ErrorAction SilentlyContinue

if ($remaining) {
    Write-Warning 'Pronadjeni su moguci preostali placeholderi. Pregledaj izlaz:'
    $remaining | ForEach-Object { Write-Warning ("{0}:{1}" -f $_.Path, $_.LineNumber) }
}

Write-Host "Template je inicijalizovan za projekat '$ProjectName' ($RepositoryName)."
Write-Host 'Dopuni projektni kontekst, pregledaj git diff i napravi pocetni commit.'

