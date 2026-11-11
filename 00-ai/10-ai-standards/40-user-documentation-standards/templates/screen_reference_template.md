---
project: "{{PROJECT_SLUG}}"
id: USER_DOCS_TEMPLATE_SCREEN_REFERENCE
type: template
tags: [user-docs, template, screen-reference]
last_review: 2026-10-05
---

# Template screen reference dokumenta

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; `<apex-source>` treba zamijeniti
stvarnom lokacijom izvoza. APEX aplikacija jos nije dodana u repozitorijum.

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/40-user-documentation-standards/screen_reference_writing_standards.md`,
prednost ima standard.

Prije popunjavanja ovog template-a, prvo uradi kratak plan po sekciji
`Preporuceni plan prije pisanja dokumenta` iz screen reference standarda.

Naziv fajla ovog dokumenta mora biti `page_<ID>.md`, sa istim zero-padded
ID-jem kao izvorni `page_<ID>.sql` (npr. `page_00033.md`) - bez opisnog
nastavka u nazivu fajla.

```yaml
---
id: USER_<APP>_SCREEN_PAGE_<ID>
type: screen_reference
app: <app-ili-cross-app>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
status: draft
owner: <vlasnik-dokumenta>
last_review: 2026-08-13
outputs: [pdf, docx]
schemas: [<SCHEMA1>, <SCHEMA2>]        # opciono
reviewer: <reviewer>                   # opciono
version: <verzija>                     # opciono
---
```

# <Naziv ekrana>

**Naziv stranice u izvoru:** `<p_name iz create_page bloka>`
**Izvorni fajl:** `@<apex-source>/f<app>/application/pages/page_<ID>.sql`

## Svrha

Kratko objasnjenje cemu ekran sluzi i sta korisnik na njemu moze da uradi.

## Kome je namijenjeno

- potvrdene korisnicke uloge

## Navigacija

- odakle se ekran otvara
- naziv menija, stranice ili taba

## Preduslovi

- potrebne role ili prava
- podaci koji moraju postojati unaprijed
- statusni ili kontekstualni uslovi

## Funkcionalni opis

Kratko objasni:
- koje cjeline postoje na ekranu
- sta korisnik u svakoj cjelini moze da vidi ili uradi
- sta je read-only, a sta editabilno, ako je potvrdeno
- ako postoje child sekcije, sta svaka od njih konkretno odrzava, prikazuje ili
  otvara dalje

## Polja, dugmad i akcije

| Element | Kratki opis | Duzi opis | Pitanje / nejasnoca |
|---|---|---|---|
| `<naziv elementa>` | `<kratki opis za help>` | `<detaljniji opis za korisnicku dokumentaciju>` | `-` ili `<konkretno pitanje>` |

Ako ekran ima child sekcije, dodaj i zasebnu podsekciju, npr. `### Child
sekcije`, i za svaku opisi:
- sta sekcija poslovno predstavlja
- koje podatke, kolone ili tipove zapisa prikazuje ili odrzava
- da li je pregledna ili editabilna
- da li vodi na drugi ekran ili modal

## Postupci

### <Naziv postupka>

1. Opis prvog koraka.
2. Opis drugog koraka.
3. Opis treceg koraka.

Dalje na ekranu: **<naziv ekrana>**

## Pitanja za tim

- konkretno otvoreno pitanje

## Business rules

- samo potvrdena pravila

## Povezani ekrani

| Akcija | Povezani ekran |
|---|---|
| `<akcija>` | `<ekran>` |

## Uocena ponasanja i moguci problemi

- moguce neocekivano ponasanje koje treba provjeriti

## Najcesce greske / FAQ

- tipicna korisnicka zabuna ili cesto pitanje

Sekcije bez sadrzaja mogu se izostaviti osim:
- `## Svrha`
- `## Funkcionalni opis`
- `## Polja, dugmad i akcije`
- `## Postupci`
- `## Pitanja za tim`
