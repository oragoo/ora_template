---
project: "{{PROJECT_SLUG}}"
id: USER_DOCS_TEMPLATE_REACT_WORKFLOW_GUIDE
type: template
tags: [user-docs, template, workflow-guide, react]
last_review: 2026-10-05
---

# Template workflow guide dokumenta (React aplikacije)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md`
ili `@00-ai/10-ai-standards/40-user-documentation-standards/workflow_guide_writing_standards.md`,
prednost imaju ti standardi.

Naziv fajla: engleski, mala slova, podvlaka (npr. `appointment_booking.md`). Lokacija
zavisi od workspace-a za React korisnicku dokumentaciju - vidi
`react_user_docs_writing_standards.md` (trenutno rezervisano, bez postojeceg
workspace-a u repou).

```yaml
---
id: USER_<APP>_WORKFLOW_<NAZIV>
type: workflow_guide
app: <app-folder>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
screens: ["<slug1>", "<slug2>", "<slug3>"]
status: draft
owner: <vlasnik>
last_review: 2026-09-14
outputs: [pdf, docx]
---
```

# <Naziv procesa>

| Ekran | Uloga u procesu |
|---|---|
| `<slug1>` | <uloga u procesu> |
| `<slug2>` | <uloga u procesu> |

## Kada se koristi

- kada se proces koristi
- kada se NE koristi (granica prema drugim procesima)

## Uloge u procesu

- <uloga>: <sta radi i sta smije>

## Preduslovi

- <role, prava, podaci koji moraju vec postojati>

## Tok

1. Na ekranu **<naziv ekrana>** (`<slug>`) <opis koraka>.
2. ...

Ako proces prelazi APEX i React ekrane, navesti platformu eksplicitno kad
nije ocigledna iz konteksta, npr. "Na APEX ekranu **X** (`page_00034`)..." /
"Na React ekranu **Y** (`<slug>`, mobilna aplikacija)...".

## Odluke koje covjek mora donijeti

- <pravilo koje se ne vidi iz softvera - vidi Izvor znanja>

## Varijante i izuzeci

- <alternativni tok ili izuzetak>

## Sta kad podje naopako

- <cesta greska i sta se tada radi>

## Pitanja za tim

- <konkretno otvoreno pitanje>

## Izvor znanja

| Sta | Ko je dao | Datum |
|---|---|---|
| <pravilo odlucivanja u procesu> | <ime, uloga> | <datum> |
| <provjera toka na aplikaciji> | <ime> | <datum> |

## Povezani procesi

- <link na srodan workflow_guide ili user_guide>

Sekcije bez sadrzaja mogu se izostaviti osim:
- `## Kada se koristi`
- `## Uloge u procesu`
- `## Tok`
- `## Odluke koje covjek mora donijeti`
- `## Sta kad podje naopako`
- `## Pitanja za tim`
- `## Izvor znanja`
