---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_SCHEMA_EXTERNAL_DEPS
type: template
tags: [rag, template, oracle, schema, external-deps]
last_review: 2026-10-05
---

# Template RAG fajla za vanjske zavisnosti sheme

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_schema_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/external_deps.md`

```yaml
---
id: <SCHEMA>_EXTERNAL_DEPS
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, synonyms, interface, cross-schema, external]
last_review: YYYY-MM-DD
---
```

# <SCHEMA> - vanjske zavisnosti

> Arhitekturni pregled: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/overview.md`

## Pravilo cross-schema komunikacije

Opsti obrazac za ovu shemu - kako se pristupa drugim shemama i kako se ova
shema izlaze prema van.

---

## Sheme koje <SCHEMA> konzumira

### <VANJSKA_SHEMA> - <kratak opis>

- **API sinonim:** `<VANJSKA_SHEMA>_API`
- **Svrha:** Kratak opis

| Sinonim | Objekt u <VANJSKA_SHEMA> | Opis |
|---|---|---|
| `<VANJSKA_SHEMA>_API` | Interfejsni paket | |

- **EXT pogledi:**

| Pogled | Svrha |
|---|---|
| `EXT_<...>_V` | ... |

---

## Sta <SCHEMA> izlaze prema van

| Shema | Interfejsni paket | Svrha |
|---|---|---|
| <CONSUMER_SHEMA> | `<SCHEMA>_<CONSUMER>_INTERFACE_PKG` | ... |
