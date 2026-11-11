---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_TABLE
type: template
tags: [rag, template, oracle, table]
last_review: 2026-10-05
---

# Template RAG fajla za Oracle tabelu

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_table_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables/<naziv_tabele>.md`

```yaml
---
id: <SCHEMA>_TABLE_<TABLE_NAME>
type: db_table
schema: <SCHEMA>
object_name: <TABLE_NAME>
tags: [<schema_malo>, <oznaka_domene>, table]
last_review: YYYY-MM-DD
---
```

# <TABLE_NAME>

## Svrha

Kratak opis svrhe tabele, 2-5 recenica.

> Arhitekturni pregled: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/overview.md`

---

## Kolone

| Kolona | Tip | Obavezno | Default | Opis |
|---|---|---|---|---|
| `ID` | `NUMBER(10)` | DA | - | Primarni kljuc, puni sekvenca |

---

## Poslovna i runtime upotreba

Opisi kako se tabela stvarno koristi u paketima, view-ovima ili integracijama,
sa dokazima (putanja do izvora). Ako nema dovoljno dokazivih runtime tragova,
umjesto ove sekcije napisi jasan `## Poslovno znacenje`.

---

## Kljucevi i ogranicenja

| Ogranicenje | Tip | Kolone |
|---|---|---|
| `<TABLE>_PK` | Primary Key | `ID` |

---

## Indeksi

| Indeks | Tip | Kolone / izraz |
|---|---|---|
| `<TABLE>_PK` | Unique | `ID` |

---

## Povezani objekti

| Objekt | Tip | Veza |
|---|---|---|
| `<DRUGA_TABELA>` | Tabela | FK veza |

---

## Napomene i poznata ogranicenja

- Tehnicki dug, legacy kolone, poznate anomalije, ako postoje.

---

Opcionalne sekcije (dodaj samo kad je primjenjivo): `## Poslovno znacenje`,
`## Statusi`, `## Audit i lifecycle`, `## Privilegije`, `## Integracioni
payload`, `## Pravila za rad`. Detalji za svaku u standardu.
