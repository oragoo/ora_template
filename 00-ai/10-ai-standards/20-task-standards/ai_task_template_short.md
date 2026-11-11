---
project: "{{PROJECT_SLUG}}"
id: AI_TASK_TEMPLATE_SHORT
type: standards
tags: [standards, ai, task, template, short]
last_review: 2026-10-05
---

# AI Task Template - Short

Koristi ovaj template za manje, jasno ogranicene zadatke gdje je scope mali i nema vise nepoznanica.

````md
---
id: AI_TASK_<JASAN_IDENTIFIKATOR>
type: ai_task
created: YYYY-MM-DD
jira: null  # stvarni Jira kljuc ako postoji tiket
source: "<Jira key ili link ka izvornom zahtjevu>"
tags: [schema, domena, tema]
---

# Task: <kratak naziv zadatka>

## Context
- Radimo u repozitorijumu {{PROJECT_NAME}}: `@00-ai/_index.md`
- Relevantni modul/shema: <navedi tacan modul, shemu ili dokument>
- Bitan kontekst: <2-4 kratke cinjenice koje agent mora znati prije rada>

## Goal
<jedna jasna recenica sta treba biti uradjeno>

## Source DDL
```sql
<ukljuci obavezno kad korisnik dostavi DDL; ne skracuj na opis ako su strukturalni detalji bitni>
```

## Scope
- Dozvoljene izmjene: <fajlovi, folderi, objekti>
- Van scope-a: <sta se ne smije dirati>

## Constraints
- Postuj postojece standarde iz: <navedi dokumente ili pravila>
- Ne mijenjaj nepovezane dijelove
- Ako je Flyway V skripta vec commitana, ne mijenjaj je
- Ako je korisnik dostavio DDL, tretiraj ga kao source of truth i ne dodaji / ne uklanjaj / ne preimenuj kolone bez eksplicitnog razloga
- Ako treba dopuna po projektnom obrascu, eksplicitno navedi sta je dopuna a sta je preuzeto iz DDL-a
- Ako task ukljucuje izmjene package fajlova, naglasi da u zaglavlju paketa treba ostati komentar sta je korigovano / mijenjano
- Ako izmjene uticu na dokumentovane cinjenice, azuriraj i odgovarajuce RAG fajlove u `@00-ai/`, ali ne diraj nepovezanu dokumentaciju
- Ako izmjena utice na vec dokumentovan ekran ili izvjestaj, azuriraj i pogodjenu korisnicku dokumentaciju (`@00-ai/80-user-documentation/apex/`, ako je rijec o APEX ekranu)
- Korekcija dokumentacije mora biti integrisana u postojeci opis, u istom stilu kao ostale stavke u tom dokumentu - ne kao recenica koja objasnjava sta je ovaj task uradio

## Acceptance Criteria
- <mjerljiv rezultat 1>
- <mjerljiv rezultat 2>
- <mjerljiv rezultat 3>
- Ako je task baziran na DDL-u: finalna struktura odgovara dostavljenom DDL-u, osim eksplicitno navedenih dopuna ili odstupanja
- Pogodjena tehnicka i korisnicka dokumentacija, ako postoji, azurirana je da odrazava novo stanje, bez pominjanja ovog zadatka

## Validation
- <kako provjeriti rezultat>

## Output
- Kratak summary izmjena
- Lista izmijenjenih fajlova
- Rizici ili otvorena pitanja, ako postoje
````

## Kada koristiti

- Jedan bugfix u poznatom paketu ili view-u
- Manja izmjena postojece logike
- Dokumentovanje ili dopuna komentara
- Dodavanje manjeg, izolovanog dijela funkcionalnosti

## Napomena o lifecycle-u

- Kad kreiras novi task, dodaj novi fajl u `@00-ai/30-development-tasks/02-ai-tasks/`
- Naziv fajla mora biti `<TASK_ID>_YYYY-MM-DD_<kratki_slug>.md` (`<TASK_ID>` je stvarni Jira kljuc ili lokalni `AI-<id>`)
- Task fajl se mijenja samo dok se pise; nakon handoff-a se vise ne edituje (ni sadrzaj, ni `status`) i trajno ostaje u folderu - nema premjestanja u archive
- Ne diraj `@00-ai/_index.md` samo da bi rucno upisao ili uklonio task iz spiska
