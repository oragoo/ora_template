---
project: "{{PROJECT_SLUG}}"
id: DEVELOPER_TASK_TEMPLATE_SHORT
type: standards
tags: [standards, developer, task, template, short]
last_review: 2026-10-05
---

# Developer Task Template - Short

Koristi ovaj template za manje zadatke prema programerima, kada je izmjena ogranicena i ne treba siroka analiza.

```md
# Task: <kratak naziv zadatka>

## Business Context
- Modul / domena: <gdje pripada>
- Zasto ovo radimo: <1-2 recenice>

## Goal
<sta treba biti gotovo kada se task zatvori>

## Scope
- U scope-u: <sta se mijenja>
- Van scope-a: <sta se ne dira>

## Technical Notes
- Relevantni fajlovi / objekti: <putanje ili nazivi>
- Standardi / reference: <linkovi na dokumentaciju>

## Acceptance Criteria
- <rezultat 1>
- <rezultat 2>
- <rezultat 3>

## Testing
- <kako provjeriti da izmjena radi>

## Deliverables
- Kod / skripta / dokumentacija koja treba biti isporucena
- (preporuka) Ako izmjena utice na vec dokumentovano ponasanje ili ekran, zatrazi od AI agenta da dopuni pogodjenu tehnicku/korisnicku dokumentaciju, integrisano u postojeci opis, ne kao opis ovog zadatka
```

## Kada koristiti

- manji bugfix
- mala dorada postojece logike
- dopuna jedne procedure, view-a ili paketa
- manji UI ili integracioni task sa jasnim granicama
