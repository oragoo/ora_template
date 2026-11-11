---
project: "{{PROJECT_SLUG}}"
id: USER_DOCS_TEMPLATE_WORKFLOW_GUIDE
type: template
tags: [user-docs, template, workflow-guide]
last_review: 2026-10-05
---

# Template workflow guide dokumenta

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; source exporti se smjestaju u
`@02-apex/applications/`. Konkretna APEX aplikacija postoji tek kada je njen export dodat u `@02-apex/applications/`.

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/40-user-documentation-standards/workflow_guide_writing_standards.md`,
prednost ima standard.

Naziv fajla: engleski, mala slova, podvlaka (npr. `forum.md`, `appointment_booking.md`),
smjesten u `@00-ai/80-user-documentation/apex/f<NNN>_<naziv>/workflows/`.

```yaml
---
id: USER_<APP>_WORKFLOW_<NAZIV>
type: workflow_guide
app: <app>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
screens: ["<ID1>", "<ID2>", "<ID3>"]
status: draft
owner: <vlasnik>
last_review: <datum>
outputs: [pdf, docx]
---
```

# <Naziv procesa>

| Ekran | Uloga u procesu |
|---|---|
| `page_<ID1>` | <uloga u procesu> |
| `page_<ID2>` | <uloga u procesu> |

## Kada se koristi

- kada se proces koristi
- kada se NE koristi (granica prema drugim procesima)

## Uloge u procesu

- <uloga>: <sta radi i sta smije>

## Preduslovi

- <role, prava, podaci koji moraju vec postojati>

## Tok

1. Na ekranu **<naziv ekrana>** (`page_<ID>`) <opis koraka>.
2. ...

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
