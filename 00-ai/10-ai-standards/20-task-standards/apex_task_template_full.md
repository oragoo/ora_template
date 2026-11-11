---
project: "{{PROJECT_SLUG}}"
id: APEX_TASK_TEMPLATE_FULL
type: standards
tags: [standards, apex, frontend, task, template, full]
last_review: 2026-10-05
---

# APEX Task Template Full

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; source exporti se smjestaju u
`@02-apex/applications/`. Konkretna APEX aplikacija postoji tek kada je njen export dodat u `@02-apex/applications/`.

Koristi ovaj template za novu stranicu, novu kompleksniju funkcionalnost, wizard tok, ili vecu izmjenu koja ukljucuje vise regiona, procesa i validacija.

```md
# Task: <jasan naziv zadatka>

## Tip
Nova stranica / Kompleksna funkcionalnost / Refactor  (obrisi nepotrebno)

## APEX Lokacija
- Aplikacija: <potvrdjeni naziv i stvarni App ID>
- Stranica: Page <broj ako postoji> - <naziv stranice>
  (za novu stranicu: predlozeni naziv, broj se dodjeljuje na implementaciji)
- Regioni: <lista predlozenih regiona ili "definisati u implementaciji">
- Navigacija: <odakle se dolazi na stranicu - meni, dugme, link; i kamo vodi dalje>
- Autorizacijski schema: <naziv ako postoji zahtjev>

## Poslovni kontekst
- Domena / modul: <pacijenti, termini, pregledi, ...>
- Korisnik: <ko koristi stranicu - prodavac, administrator, dispecer, ...>
- Pozadina: <zasto je task potreban, koji poslovni proces podrzava>
- Problem danas: <sta trenutno nedostaje ili ne radi>

## Funkcionalni zahtjevi

### Prikaz i forma
- <sta korisnik vidi na stranici - report, forma, tabulator, ...>
- <koja polja su na formi, koja su obavezna>
- <defaultne vrijednosti, unaprijed popunjeni podaci>

### Validacije
- <validacija 1 - uvjet i poruka korisniku>
- <validacija 2>

### Procesi (submit)
- <sta se desava na submit - insert, update, delete, poziv procedure>
- <package procedura koja se poziva, ako je poznato>

### Dynamic Actions
- <DA 1 - okidac, uvjet, akcija>
- <DA 2>

### Navigacija i dugmad
- <Cancel -> gdje ide>
- <Save / Submit -> gdje ide>
- <ostale akcije>

## Izvor podataka
- Tabele / pogledi: <koji objekti se koriste za prikaz i DML>
- Package za submit: <naziv procedure, ako je poznato>
- LOV-ovi: <lista LOV-ova i njihovi izvori>
- Filteri / parametri: <koji parametri dolaze sa prethodne stranice>

## Scope
- U scope-u:
  - <izmjena 1>
  - <izmjena 2>
- Van scope-a:
  - <sta se ne radi u ovom tasku>
  - <sta zahtijeva poseban dogovor>

## Constraints
- <tehnicko ili poslovno ogranicenje 1>
- <tehnicko ili poslovno ogranicenje 2>

## Acceptance Criteria
- [ ] <mjerljiv kriterij 1>
- [ ] <mjerljiv kriterij 2>
- [ ] <mjerljiv kriterij 3>

## Test scenariji

| Scenario | Koraci | Ocekivani rezultat |
|---|---|---|
| Uspjesan unos | 1. Otvoriti stranicu X<br>2. Popuniti formu<br>3. Kliknuti Save | Zapis se spremi, redirect na stranicu Y |
| Validacija - obavezno polje | 1. Ostaviti polje Z prazno<br>2. Kliknuti Save | Poruka "Polje Z je obavezno" |
| Neovlasteni korisnik | 1. Prijaviti se bez uloge A<br>2. Pokusati otvoriti stranicu | Redirect na stranicu gresaka / poruka |

## Delivery Notes
- <napomene za deployment ako postoje>
- <da li treba meni item, breadcrumb, precica>
- <da li treba dokumentovati novu stranicu u RAG-u>
```

---

## Kada koristiti

- Nova stranica (cijela funkcionalnost od nule)
- Wizard s vise koraka
- Refaktorisanje postojece stranice s promjenom strukture regiona ili procesa
- Zadatak koji ukljucuje vise od 3-4 neovisnih izmjena

## Kada NE koristiti

- Bug fix ili manja izmjena -> koristi `apex_task_template_short.md`
- Izmjena koja je iskljucivo PL/SQL bez APEX promjena -> koristi developer/Jira task standard
