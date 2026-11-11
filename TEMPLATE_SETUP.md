# Kreiranje novog projekta iz template repozitorijuma

## Preporuceni postupak

```powershell
git clone E:\Projects\ORAGOO\ora_template E:\Projects\ORAGOO\ora_novi_projekat
Set-Location E:\Projects\ORAGOO\ora_novi_projekat
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\initialize-template.ps1 -ProjectName "Novi projekat" -ProjectSlug "novi-projekat" -RepositoryName "ora_novi_projekat" -DbSchema "NOVI_PROJEKAT"
git remote remove origin
git add .
git commit -m "Initialize project from ora_template"
```

Nakon toga dodati novi remote kada bude kreiran:

```powershell
git remote add origin <URL_NOVOG_REPOZITORIJUMA>
```

## Parametri

- `ProjectName` - citljiv naziv projekta.
- `ProjectSlug` - kratak identifikator malim slovima; ako se izostavi, izvodi se iz naziva.
- `RepositoryName` - naziv repozitorijuma; podrazumijevano `ora_<slug>`.
- `DbSchema` - Oracle shema; podrazumijevano slug velikim slovima sa `_`.
- `DocIdPrefix` - prefiks ID-jeva dokumentacije; podrazumijevano isti kao shema.
- `AppFolder` - identifikator aplikacijskog foldera; podrazumijevano isti kao slug.

## Rucna provjera nakon inicijalizacije

1. Provjeriti da nema preostalih placeholdera: `rg "\{\{[A-Z0-9_]+\}\}"`.
2. Dopuniti `README.md`, `AGENTS.md` i `00-ai/_index.md` stvarnim kontekstom.
3. Ukloniti standarde koji sigurno nisu relevantni ili ih ostaviti kao uslovne.
4. Dodati `.gitignore` za stvarno odabrani stack.
5. Definisati build, lint i test komande tek nakon postavljanja alata.

