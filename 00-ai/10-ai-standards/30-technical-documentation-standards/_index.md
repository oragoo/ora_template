---
project: "{{PROJECT_SLUG}}"
id: TECHNICAL_DOCUMENTATION_STANDARDS_INDEX
type: index
tags: [index, standards, rag, dokumentacija]
last_review: 2026-10-05
---

# Technical Documentation Standards - Index

## Svrha

Ovaj folder sadrzi sve standarde za pisanje tehnicke RAG dokumentacije u
`@00-ai/40-technical-documentation/01-database/01-oracle/` i `@00-ai/40-technical-documentation/03-integrations/<module>/` - opsti principi
(jezik, putanje, dokazivost) plus poseban standard za svaki tip RAG fajla, i
template-e za Oracle tipove (tabela, paket, sema, algoritam).

Planirane lokacije za samu tehnicku dokumentaciju su `@00-ai/40-technical-documentation/01-database/01-oracle/`
i `@00-ai/40-technical-documentation/03-integrations/<module>/`. Kreiraju se uz prve
dokumente o potvrdjenim objektima. Ovaj folder sadrzi pravila i predloske.

---

## Dokumenti

| Dokument | Sadrzaj |
|---|---|
| `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md` | Iskljucivo opsti principi (jezik, putanje, dokazivost, integracija izmjena bez changelog-a, ID konvencija, `last_review`) - zajednicki za sve tipove RAG fajlova |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_table_rag_writing_standards.md` | Standard za pojedinacnu Oracle tabelu (`db_table`) |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md` | Standard za standardni i interfejsni (`*_interface_pkg`) Oracle paket |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_schema_rag_writing_standards.md` | Standard za pregled sheme (`overview.md`) i vanjske zavisnosti (`external_deps.md`) |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_tables_catalog_rag_writing_standards.md` | Standard za katalog tabela (`tables.md`) - izvor istine je RAG dokumentacija, admin-kurirano |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_packages_catalog_rag_writing_standards.md` | Standard za katalog paketa (`packages.md`) - izvor istine je trenutni source kod |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_views_catalog_rag_writing_standards.md` | Standard za katalog pogleda (`views.md`) - izvor istine je trenutni source kod |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_triggers_catalog_rag_writing_standards.md` | Standard za katalog triggera (`triggers.md`) - izvor istine je trenutni source kod |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_synonyms_catalog_rag_writing_standards.md` | Standard za katalog sinonima (`synonyms.md`) - izvor istine je trenutni source kod |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/external_sql_rag_writing_standards.md` | Uslovni standard za eksterne SQL module (`external_module_doc`, `procedure_doc`) |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_algorithm_rag_writing_standards.md` | Standard za algoritamsku/proceduralnu logiku razbacanu kroz vise paketa (`db_algorithm_catalog`, `db_algorithm`) |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/table_template.md` | Template za RAG fajl jedne tabele |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/package_template.md` | Template za RAG fajl standardnog paketa |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/package_interface_template.md` | Template za RAG fajl interfejsnog paketa (`*_interface_pkg`) |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/schema_overview_template.md` | Template za `overview.md` sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/schema_external_deps_template.md` | Template za `external_deps.md` sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/tables_catalog_template.md` | Template za `tables.md` katalog sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/packages_catalog_template.md` | Template za `packages.md` katalog sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/views_catalog_template.md` | Template za `views.md` katalog sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/triggers_catalog_template.md` | Template za `triggers.md` katalog sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/synonyms_catalog_template.md` | Template za `synonyms.md` katalog sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/algorithm_catalog_template.md` | Template za `algorithms/_index.md` katalog algoritama sheme |
| `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/algorithm_template.md` | Template za RAG fajl pojedinacnog algoritma |

---

## Pravilo izbora

- Pises RAG za jednu Oracle tabelu -> `oracle_table_rag_writing_standards.md` + `templates/table_template.md`
- Pises RAG za standardni Oracle paket -> `oracle_package_rag_writing_standards.md` + `templates/package_template.md`
- Pises RAG za `*_interface_pkg` -> `oracle_package_rag_writing_standards.md` + `templates/package_interface_template.md`
- Pises pregled sheme ili vanjske zavisnosti -> `oracle_schema_rag_writing_standards.md` + odgovarajuci template
- Pises/revidiras katalog tabela (`tables.md`) -> `oracle_tables_catalog_rag_writing_standards.md` + `templates/tables_catalog_template.md`
- Pises/revidiras katalog paketa (`packages.md`) -> `oracle_packages_catalog_rag_writing_standards.md` + `templates/packages_catalog_template.md`
- Pises/revidiras katalog pogleda (`views.md`) -> `oracle_views_catalog_rag_writing_standards.md` + `templates/views_catalog_template.md`
- Pises/revidiras katalog triggera (`triggers.md`) -> `oracle_triggers_catalog_rag_writing_standards.md` + `templates/triggers_catalog_template.md`
- Pises/revidiras katalog sinonima (`synonyms.md`) -> `oracle_synonyms_catalog_rag_writing_standards.md` + `templates/synonyms_catalog_template.md`
- Pises RAG za potvrdjeni eksterni SQL modul (ako takva integracija postoji) -> `external_sql_rag_writing_standards.md`
- Pises RAG za algoritamsku logiku razbacanu kroz vise paketa (npr. planiranje, scheduling) -> `oracle_algorithm_rag_writing_standards.md` + `templates/algorithm_catalog_template.md`/`templates/algorithm_template.md`
- Nisi siguran koji opsti princip vazi (jezik, putanje, dokazivost, integracija izmjena) -> `rag_writing_standards.md` -> "Opsti principi"

---
