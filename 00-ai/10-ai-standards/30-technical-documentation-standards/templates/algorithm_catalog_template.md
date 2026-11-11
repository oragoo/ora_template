---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_ALGORITHM_CATALOG
type: template
tags: [rag, template, oracle, algorithm, catalog]
last_review: 2026-10-05
---

# Template RAG kataloga algoritama (algorithms/_index.md)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_algorithm_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/_index.md`

```yaml
---
id: <SCHEMA>_ALGORITHMS
type: db_algorithm_catalog
schema: <SCHEMA>
tags: [<schema_malo>, algorithms, index]
last_review: YYYY-MM-DD
---
```

# Algoritmi - <SCHEMA>

## Glavni tok

```text
<ULAZNA_PROCEDURA>
  -> <medjukorak>
  -> <medjukorak>
      -> <UTIL_PAKET>.<dispecer koji bira algoritam>
```

Kratko objasnjenje kako dispecer bira konkretan algoritam.

---

## Dostupni algoritmi

| Algoritam | Public poziv | Smjer | Namjena | Detaljan opis |
|---|---|---|---|---|
| `<ALGORITAM>` | `<public_proceduru_ili_funkciju>` | forward / backward / ... | Kratak opis namjene | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/<algoritam>.md` |

Kolona `Detaljan opis` se popunjava samo ako za algoritam postoji poseban
`db_algorithm` fajl.

---

## Zajednicka pravila

- Pravila koja vaze za vise/sve algoritme (npr. relevantni tipovi aktivnosti,
  transakciono ponasanje, zajednicke temp/staging strukture).

---

## Povezani objekti

| Objekat | Tip | Uloga |
|---|---|---|
| `<PAKET>` | Paket | Sadrzi public API algoritama |
| `<TABELA>` | Tabela | Staging/temp kontekst |

---

## Napomene za odrzavanje RAG-a

Kad se mijenja `<PAKET>`, azurirati:
- odgovarajuci paket RAG fajl
- ovaj katalog (ako se mijenja spisak ili namjena algoritama)
- pojedinacni `db_algorithm` fajl ako postoji za dotican algoritam
