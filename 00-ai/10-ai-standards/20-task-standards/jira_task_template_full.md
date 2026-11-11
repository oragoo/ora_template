---
project: "{{PROJECT_SLUG}}"
id: JIRA_TASK_TEMPLATE_FULL
type: standards
tags: [standards, jira, task, template, full]
last_review: 2026-10-05
---

# Jira Task Template Full

Koristi ovaj template kad Jira ticket prvenstveno cita programer, a detaljan AI handoff ide u zaseban `.md` attachment.

```md
# Task: <jasan naziv zadatka>

## AI Instructions
- Primary AI handoff file: `@00-ai/30-development-tasks/02-ai-tasks/<task_file>.md`
- Coding agent must first load and follow this file
- Do not implement from this Jira description alone

## Business Context
- Domena / modul: <npr. pacijenti, termini, pregledi>
- Poslovna pozadina: <zasto je task potreban>
- Problem za korisnika ili proces: <sta danas ne radi ili nedostaje>
- Ako korisnik u svom zahtjevu vec dostavi detaljno obrazlozenje zasto se ide na izmjenu (npr. konkretni test slucajevi sa brojevima, uzrok problema, dokazan scenario greske, poslovni/regulatorni rizik), prenesi to obrazlozenje ovdje u punom obimu, sa konkretnim primjerima i brojevima koje je korisnik naveo - ne svodi ga na jednu recenicu. Ako takvo obrazlozenje ne postoji u zahtjevu, ostavi kratak generican opis kao u placeholderu iznad.

## Goal
<sta mora biti istina nakon zavrsetka zadatka>

## Scope
- U scope-u:
  - <izmjena 1>
  - <izmjena 2>
  - <izmjena 3>
- Van scope-a:
  - <sta se ne radi u ovom tasku>
  - <sta zahtijeva poseban dogovor>

## Functional Requirements
- <funkcionalni zahtjev 1>
- <funkcionalni zahtjev 2>

## Technical Requirements
- <tehnicki zahtjev 1>
- <tehnicki zahtjev 2>
- Ako za neki tehnicki zahtjev vec postoji konkretan predlog SQL/PL-SQL koda (npr. korigovana funkcija, procedura ili DDL), ukljuci ga ovdje kao kod blok (` ```sql `), ne samo kao tekstualni opis - developer treba da vidi tacnu predlozenu izmjenu, ne samo njen opis. Ako predlog koda ne postoji ili nije poznat u trenutku pisanja taska, ostavi samo tekstualni opis zahtjeva kao u placeholderu iznad.

## Constraints
- <poslovno ili tehnicko ogranicenje 1>
- <poslovno ili tehnicko ogranicenje 2>

## Acceptance Criteria
- <mjerljiv rezultat 1>
- <mjerljiv rezultat 2>
- <mjerljiv rezultat 3>

## Testing and Validation
- <compile / query / search / manual check 1>
- <compile / query / search / manual check 2>
- <compile / query / search / manual check 3>

## Delivery Notes
- <deployment napomena ako postoji>
- <dokumentacija ili handoff napomena ako postoji - po potrebi navedi preporuku da se pogodjena tehnicka/korisnicka dokumentacija dopuni uz pomoc AI, integrisano u postojeci opis, ne kao changelog o ovom zadatku>
```

## Kada koristiti

- Jira ticket koji prvenstveno cita programer
- Integracije, cross-schema promjene i package izmjene
- Zadatke sa vise fajlova ili vecim rizikom od regresije
- Situacije gdje je AI handoff preopsiran za sam Jira opis
