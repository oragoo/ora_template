---
project: "{{PROJECT_SLUG}}"
id: AI_TASK_TEMPLATE_FULL
type: standards
tags: [standards, ai, task, template, full]
last_review: 2026-10-05
---

# AI Task Template - Full

R/V pravila prate Flyway standard projekta. Za poglede je potvrdjena R
konvencija; konfiguraciju izvrsavanja i ostale tipove izvora provjeriti u repou.

Koristi ovaj template za slozenije zadatke projekta {{PROJECT_NAME}}, kada agent mora raditi analizu, zahvatiti vise fajlova ili paziti na granice izmjena.

````md
---
id: AI_TASK_<JASAN_IDENTIFIKATOR>
type: ai_task
created: YYYY-MM-DD
jira: null  # stvarni Jira kljuc ako postoji tiket
source: "<Jira key ili link ka izvornom zahtjevu>"
tags: [schema, domena, tema]
---

# Task: <jasan naziv zadatka>

## Context
- Repo/context entry point: `@00-ai/_index.md`
- Domena: <npr. pacijenti, termini, pregledi, integracija>
- Relevantna dokumentacija:
  - <putanja 1>
  - <putanja 2>
  - <putanja 3>
- Trenutno stanje:
  - <sta danas postoji>
  - <sta ne radi ili sta nedostaje>
  - <bitne poslovne ili tehnicke pretpostavke>

## Problem
<opis problema koji treba rijesiti, bez nejasnih formulacija>

## Source DDL
```sql
<obavezno ukljuci kad korisnik dostavi DDL; prenesi puni relevantni DDL ili kompletnu vjernu transkripciju>
```

## Goal
<sta tacno treba da bude istina nakon zavrsetka zadatka>

## In Scope
- <fajlovi / moduli / objekti koje smije mijenjati>
- <dozvoljene vrste izmjena>

## Out of Scope
- <sta ne smije dirati>
- <sta ne treba refaktorisati usput>
- <sta zahtijeva poseban dogovor>

## Constraints
- Postuj `@AGENTS.md`
- Postuj relevantne standarde iz `@00-ai/10-ai-standards/`
- Grantove u `@01-database/08-grants/` mijenjaj samo u obimu zadatka i uz provjeru prava
- Ne mijenjaj legacy objekte bez eksplicitnog zahtjeva
- V skripte se ne mijenjaju nakon commitanja; napravi novu ako je potrebno
- R skripte mijenjaj direktno, uz postovanje projekta i naming konvencija
- Ako je korisnik dostavio DDL, on je source of truth za strukturu; ne skracuj ga na slobodnu interpretaciju i ne uvodi dodatne kolone / rename / tipove bez eksplicitnog razloga
- Ako DDL nije kompletan za Oracle implementaciju, jasno razdvoji sta dolazi iz izvornog DDL-a a sta se dopunjava po projektnom obrascu
- Ako task ukljucuje izmjene package fajlova, u tasku eksplicitno naglasi da u zaglavlju paketa treba ostati komentar sta je korigovano / mijenjano
- Ako izmjene mijenjaju dokumentovani contract, naming, tok podataka, zavisnosti, kolone, procedure ili ponasanje objekta, azuriraj i odgovarajuce RAG fajlove u `@00-ai/`
- Ne mijenjaj nepovezane RAG fajlove i ne radi siroko prepisivanje dokumentacije bez potrebe
- Ako izmjena utice na vec dokumentovan ekran ili izvjestaj, azuriraj i pogodjenu korisnicku dokumentaciju (`@00-ai/80-user-documentation/apex/`, ako je rijec o APEX ekranu)
- Korekcija dokumentacije (tehnicke i korisnicke) mora biti integrisana u postojeci opis, u istom stilu kao ostale stavke u tom dokumentu - ne kao recenica koja objasnjava sta je ovaj task uradio (vidi `ai_task_writing_rules.md` -> "Korekcija dokumentacije nakon izmjene")

## Relevant Files / Objects
- <apsolutno ili repo-relative navedi najbitnije fajlove>
- <package, view, tabela, trigger, API endpoint, report...>

## Implementation Notes
- <ako postoji preporuceni pristup>
- <ako postoji poznat obrazac koji treba pratiti>
- <ako postoji slican objekat koji treba koristiti kao referencu>

## Acceptance Criteria
- <mjerljiv rezultat 1>
- <mjerljiv rezultat 2>
- <mjerljiv rezultat 3>
- Ako je task baziran na dostavljenom DDL-u: finalna struktura odgovara tom DDL-u za kolone, tipove, defaulte i constraint-e, osim eksplicitno navedenih dopuna ili odstupanja
- Pogodjena tehnicka (`@00-ai/`) i korisnicka (`@00-ai/80-user-documentation/apex/`, ako je rijec o APEX ekranu) dokumentacija, ako postoji, azurirana je da odrazava novo stanje, integrisano u postojeci opis, bez pominjanja ovog zadatka
- Nema regresije u: <navedi ako je poznato>

## Validation Steps
- <query, test, compile ili manuelna provjera 1>
- <provjera 2>
- <provjera 3>

## Expected Output Format
- Summary:
  - <sta je promijenjeno>
- Files changed:
  - <lista fajlova>
- Validation:
  - <sta je provjereno i rezultat>
- Open questions / risks:
  - <samo ako postoje>
````

## Kada koristiti

- Novi objekat ili nova poslovna logika
- Refaktorisanje sa vise dodirnih tacaka
- Integracije i cross-schema promjene
- Zadatke koje saljes drugom AI agentu bez dodatnog objasnjavanja

## Napomena o lifecycle-u

- Kad kreiras novi task, dodaj novi fajl u `@00-ai/30-development-tasks/02-ai-tasks/`
- Naziv fajla mora biti `<TASK_ID>_YYYY-MM-DD_<kratki_slug>.md` (`<TASK_ID>` je stvarni Jira kljuc ili lokalni `AI-<id>`)
- Task fajl se mijenja samo dok se pise; nakon handoff-a se vise ne edituje (ni sadrzaj, ni `status`) i trajno ostaje u folderu - nema premjestanja u archive
- Ne diraj `@00-ai/_index.md` samo da bi rucno upisao ili uklonio task iz spiska
