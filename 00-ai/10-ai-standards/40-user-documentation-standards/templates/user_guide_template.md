---
project: "{{PROJECT_SLUG}}"
id: USER_DOCS_TEMPLATE_USER_GUIDE
type: template
tags: [user-docs, template, guide]
last_review: 2026-10-05
---

# Template korisnickog uputstva

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/40-user-documentation-standards/user_doc_writing_standards.md`, prednost ima standard.

Za dokument tipa `screen_reference` koristi poseban template:
`@00-ai/10-ai-standards/40-user-documentation-standards/templates/screen_reference_template.md`

```yaml
---
id: USER_<APP>_<TEMA>
type: user_guide
app: <app-ili-cross-app>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
status: draft
owner: <vlasnik-dokumenta>
last_review: 2026-05-22
outputs: [pdf, docx]
schemas: [<SCHEMA1>, <SCHEMA2>]        # opciono
reviewer: <reviewer>                   # opciono
version: <verzija>                     # opciono
---
```

# Naslov uputstva

## Svrha

Kratko objasnjenje cemu uputstvo sluzi i sta korisnik njime dobija.

## Kome je namijenjeno

- kojim korisnickim ulogama je tema relevantna

## Kada se koristi

- u kojim poslovnim situacijama korisnik koristi ovu funkcionalnost

## Navigacija

- tacna putanja kroz meni, modul, ekran ili tab

## Preduslovi

- koje role ili prava su potrebni
- koji podaci moraju postojati unaprijed
- koji status ili kontekst mora biti ispunjen

## Osnovni pojmovi

| Pojam | Znacenje |
|---|---|
| `<pojam>` | `<kratko objasnjenje>` |

## Funkcionalni opis

Kratko objasni:
- koje cjeline postoje na ekranu ili u procesu
- kako funkcionalnost radi iz ugla korisnika

## Polja i opcije

| Polje | Opis | Obavezno | Napomena |
|---|---|---|---|
| `<naziv polja>` | `<opis>` | `DA/NE/USLOVNO` | `<napomena>` |

## Koraci

1. Opis prvog koraka.
2. Opis drugog koraka.
3. Opis treceg koraka.

## Business rules

- konkretna pravila ponasanja sistema
- validacije, izuzeci, statusne promjene i posljedice akcije
- pisi u formi: "Ako ..., sistem ..."

## Primjeri

> Primjer: Ako korisnik unese ...

## Najcesce greske / FAQ

- tipicna greska ili pitanje i kratak odgovor

## Informacije za dopunu

| Tema | Sta nedostaje | Ko treba dopuniti |
|---|---|---|
| `<tema>` | `<otvoreno pitanje>` | `<vlasnik>` |

## Povezani dokumenti

- linkovi na srodna uputstva
