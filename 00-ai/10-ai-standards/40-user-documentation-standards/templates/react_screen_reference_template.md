---
project: "{{PROJECT_SLUG}}"
id: USER_DOCS_TEMPLATE_REACT_SCREEN_REFERENCE
type: template
tags: [user-docs, template, screen-reference, react]
last_review: 2026-10-05
---

# Template screen reference dokumenta (React aplikacije)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md`
ili `@00-ai/10-ai-standards/40-user-documentation-standards/screen_reference_writing_standards.md`,
prednost imaju ti standardi (React delta prvo, opsti standard za sadrzaj
sekcija).

Naziv fajla ovog dokumenta mora biti `<screen-slug>.md`, kebab-case slug
izveden iz naziva React komponente bez sufiksa `Page` (npr.
`AppointmentListPage.tsx` -> `appointment-list.md`) - bez brojevnog sufiksa.

```yaml
---
id: USER_<APP>_SCREEN_<SLUG>
type: screen_reference
app: <app-folder>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
status: draft
owner: <vlasnik-dokumenta>
last_review: 2026-09-14
outputs: [pdf, docx]
schemas: [<API_SCHEMA>, <SCHEMA1>]        # opciono
reviewer: <reviewer>                   # opciono
version: <verzija>                     # opciono
---
```

# <Naziv ekrana>

**Naziv ekrana u kodu:** `<PascalCase naziv komponente>`
**Izvorni fajl:** `<react-source>/src/pages/<...>/<Component>.tsx`
**Ruta:** `<route path>`
**API poziv:** vidi `@00-ai/40-technical-documentation/02-webapp/01-react/<app-folder>/screens.md`

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
