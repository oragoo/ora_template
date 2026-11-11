---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_TABLES_CATALOG
type: template
tags: [rag, template, oracle, tables, catalog, index]
last_review: 2026-10-05
---

# Template RAG kataloga tabela (tables.md)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_tables_catalog_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables.md`

```yaml
---
id: <SCHEMA>_TABLES
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, tables, index]
last_review: YYYY-MM-DD
---
```

```markdown
# <SCHEMA> - Tabele

> Arhitekturni pregled: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/overview.md`

Za svaku dokumentovanu tabelu postoji detaljan fajl u
`@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables/`.

## Stanje sinhronizacije dokumentacije tabela

- Posljednja obradjena V skripta: <puna @01-database/... putanja, nije registrovana ili nije primjenjivo ako se ne koristi Flyway>
- Datum posljednje sinhronizacije: <YYYY-MM-DD ili nije potvrdjen>
- Obim provjere: <stvarno pregledani izvori i tabele; ako obim nije poznat, navesti to>
- Poznati izuzeci: <nepregledane skripte i ogranicenja ili nisu evidentirani>

Pravila sinhronizacije:
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_tables_catalog_rag_writing_standards.md`.

---

## <Naziv grupe, npr. Sifarnici i statusi>

| Tabela | Opis | Detalji |
|---|---|---|
| `TABELA_A` | Kratki opis | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables/tabela_a.md` |

---

## <Sljedeca grupa>

| Tabela | Opis | Detalji |
|---|---|---|
| `TABELA_B` | Kratki opis | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables/tabela_b.md` |

---

## Napomene

Ovaj katalog pokriva `<N>` tabela u dogovorenom obimu dokumentovanja.
Navesti izvor potvrde obima; sama V/DDL istorija nije dokaz potpunosti.
```

---

Sadrzaj se grupira po domeni, ne abecedno. Svrha ovog fajla je brza navigacija
prema `tables/<naziv>.md` - ne duplirati sadrzaj detaljnog fajla.
