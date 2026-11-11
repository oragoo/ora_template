---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_ALGORITHM
type: template
tags: [rag, template, oracle, algorithm]
last_review: 2026-10-05
---

# Template RAG fajla za pojedinacni algoritam

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_algorithm_rag_writing_standards.md`,
prednost ima standard. Pisi ga samo za algoritme dovoljno slozene da im opis
u katalogu (jedan red) nije dovoljan.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/<algorithm_name>.md`

```yaml
---
id: <SCHEMA>_ALGORITHM_<ALGORITHM_NAME>
type: db_algorithm
schema: <SCHEMA>
object_name: <ALGORITHM_NAME>
tags: [<schema_malo>, algorithm]
last_review: YYYY-MM-DD
---
```

# <ALGORITHM_NAME>

## Sta radi

Sta algoritam postize, 2-5 recenica. Ako je poznat pod vise naziva (stariji
opisi, staging procedure), navesti ih ovdje da pretraga ne promasi dokument.

> Katalog svih algoritama sheme: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/_index.md`

---

## Tok poziva

```text
<ULAZNA_PROCEDURA>
  -> <medjukorak>
  -> <medjukorak>
      -> <PAKET>.<algoritam>
```

Potvrdjeni lanac poziva - ne pretpostavljati korake koji nisu provjereni u
kodu.

---

## Kljucna pravila

- Konkretno pravilo ponasanja algoritma.
- Jos jedno pravilo, sa referencom na kolonu/tabelu ako je relevantno.

---

## Odnos prema drugim algoritmima

| Algoritam | Karakteristika |
|---|---|
| `<SRODNI_ALGORITAM>` | Kratka razlika u odnosu na ovaj algoritam |

---

## Transakcije i logovanje

Runtime ponasanje (commit, logging) - navesti samo ono sto je potvrdjeno u
kodu; ako commit nije pronadjen eksplicitno, tako i napisati umjesto da se
pretpostavi.

---

## Napomene za izmjene

Kod izmjena ovog algoritma provjeriti zajedno:

- `<PAKET>.<procedura_1>`
- `<PAKET>.<procedura_2>`
- katalog algoritama (`algorithms/_index.md`), ako se mijenja javni potpis ili namjena
