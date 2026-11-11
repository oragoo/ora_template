---
project: "{{PROJECT_SLUG}}"
id: DEVELOPER_TASK_TEMPLATE_FULL
type: standards
tags: [standards, developer, task, template, full]
last_review: 2026-10-05
---

# Developer Task Template - Full

Koristi ovaj template za ozbiljnije zadatke prema programerima, posebno kad postoji vise modula, migracija, integracija ili veci rizik od regresije.

```md
# Task: <jasan naziv zadatka>

## Business Context
- Domena / modul: <npr. pacijenti, termini, pregledi>
- Poslovna pozadina: <zasto je task potreban>
- Problem za korisnika ili proces: <sta danas ne radi ili nedostaje>

## Goal
<sta mora biti istina nakon zavrsetka zadatka>

## Scope
- U scope-u:
  - <izmjena 1>
  - <izmjena 2>
- Van scope-a:
  - <sta se ne radi u ovom tasku>

## Functional Requirements
- <funkcionalni zahtjev 1>
- <funkcionalni zahtjev 2>
- <funkcionalni zahtjev 3>

## Technical Requirements
- <tehnicki zahtjev 1>
- <tehnicki zahtjev 2>
- <npr. nova V skripta, nova procedura, parser, seed, test>

## Relevant Systems / Files
- <repo putanja ili objekat 1>
- <repo putanja ili objekat 2>
- <eksterni sistem, endpoint ili tabela ako postoji>

## Constraints
- <tehnicka ogranicenja>
- <legacy ogranicenja>
- <deployment ogranicenja>

## Acceptance Criteria
- <mjerljiv rezultat 1>
- <mjerljiv rezultat 2>
- <mjerljiv rezultat 3>

## Testing and Validation
- Unit / compile / manual / integration provjera:
  - <provjera 1>
  - <provjera 2>
  - <provjera 3>

## Deployment Notes
- <da li treba nova V skripta>
- <da li treba seed / konfiguracija>
- <da li postoji redoslijed deploya>

## Documentation (preporuka)
- Ako izmjena utice na vec dokumentovano ponasanje, ekran ili strukturu, nakon implementacije zatrazi od AI agenta da dopuni pogodjenu tehnicku dokumentaciju (`@00-ai/`) i/ili korisnicko uputstvo (`@00-ai/80-user-documentation/apex/`, ako je rijec o APEX ekranu)
- Korekcija treba da bude integrisana u postojeci opis, u istom stilu kao ostale stavke u dokumentu - ne kao recenica koja objasnjava sta je ovaj task uradio

## Deliverables
- <kod>
- <migracije>
- <test dokaz ili opis validacije>
- <kratka dokumentacija ako je potrebna>

## Open Questions / Risks
- <ako postoje>
```

## Kada koristiti

- novi objekti i nova poslovna logika
- cross-schema ili cross-system integracije
- taskovi sa vise fajlova ili vise timova
- Jira ticketi koji treba da budu dovoljni programeru bez dodatnog usmenog konteksta
