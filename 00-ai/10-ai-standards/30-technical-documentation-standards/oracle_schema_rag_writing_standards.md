---
project: "{{PROJECT_SLUG}}"
id: ORACLE_SCHEMA_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, schema, overview, external-deps, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za pregled sheme i vanjske zavisnosti

Ovaj dokument definise obaveznu strukturu, frontmatter i sekcije za dva
schema-level RAG dokumenta: pregled sheme (`overview.md`) i vanjske
zavisnosti (`external_deps.md`).

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori sekcija)
su definisani u `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ove tipove fajlova - ovaj dokument ih ne ponavlja. Ovo ukljucuje i
pravilo "Integracija izmjena, ne changelog": npr. `## Trenutno dokumentovani
objekti` u pregledu sheme opisuje trenutno stanje pokrivenosti, ne istoriju
ko je i kad koji objekat dodao.

Za RAG standarde tabela i paketa vidi:
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_table_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md`

Za RAG standarde kataloga (tables.md, packages.md, views.md, triggers.md,
synonyms.md) vidi:
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_tables_catalog_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_packages_catalog_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_views_catalog_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_triggers_catalog_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_synonyms_catalog_rag_writing_standards.md`

Template-i:
- `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/schema_overview_template.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/schema_external_deps_template.md`

## Tip: `schema_doc` - Pregled sheme

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/overview.md`

### Frontmatter

```yaml
---
id: <SCHEMA>_OVERVIEW
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, overview, ...]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

Pregled sheme moze biti u dva nivoa zrelosti:

- **Seed / inkrementalni pregled**: kad je dokumentacija tek zapoceta i repo jos ne pokriva
  dovoljnu sirinu za puni arhitekturni pregled
- **Puni pregled**: kad je vec mapiran veci dio sheme, consumeri i cross-schema granice

Za seed pregled dovoljno je jasno dokumentovati sta je trenutno pokriveno i koje su do sada
potvrdjene veze. Nije obavezno nasilno uvoditi sve sekcije punog pregleda ako za njih jos nema
stabilnog sadrzaja.

| Sekcija | Status | Napomena |
|---|---|---|
| `## Svrha sheme` | Obavezno | Domena, primarna odgovornost |
| `## Trenutno dokumentovani objekti` | Obavezno za seed i puni pregled | Jasno navedi sta je vec pokriveno u `00-ai` |
| `## Trenutno mapirani runtime tragovi` | Preporuceno | Posebno korisno za seed pregled dok dokumentacija jos raste |
| `## Konzumenti sheme` | Obavezno za puni pregled / opcionalno za seed | Ko koristi shemu i kako |
| `## Cross-schema zavisnosti` | Obavezno za puni pregled / opcionalno za seed | Sta shema konzumira + sta izlaze |
| `## Arhitektura paketa` | Obavezno za puni pregled / opcionalno za seed | ASCII dijagram slojeva |
| `## Grupe objekata` | Obavezno za puni pregled / opcionalno za seed | Paketi i pogledi s pregledom po grupi |
| `## Napomene` ili `## Napomene i upozorenja` | Obavezno | Legacy, tehnicki dug, zabranjene prakse, status pokrivenosti |

### Tablica konzumenata

```markdown
| Konzument | Tip | Nacin pristupa |
|---|---|---|
| APEX aplikacija | Graficko sucelje | Controller paketi (`pXXXXX_controller_pkg`) |
| <KONZUMENT> | <TIP> | <POTVRDJENI NACIN PRISTUPA> |
| Mobilna aplikacija | REST | WS paket (`<schema>_ws_pkg`) |
```

### Tablica cross-schema zavisnosti (konzumira)

```markdown
| Shema | API sinonim | Svrha |
|---|---|---|
| <VANJSKA_SHEMA> | `<VANJSKA_SHEMA>_API` | <POTVRDJENA SVRHA> |
```

### Tablica cross-schema zavisnosti (izlaze)

```markdown
| Shema | Interfejsni paket | Svrha |
|---|---|---|
| <CONSUMER_SCHEMA> | `<SCHEMA>_<CONSUMER>_INTERFACE_PKG` | ... |
```

### ASCII dijagram

Prikazuje slojeve od grafickog sucelja prema core-u.
Prefer plain ASCII zapis (`->`, `|`, `+--`) radi stabilnog diff-a i manjeg rizika od encoding problema.
Nije obavezno pokriti sve pakete - dovoljno je prikazati kljucne slojeve i gdje se koji paket nalazi.

---

## Tip: `schema_doc` - Vanjske zavisnosti sheme

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/external_deps.md`

### Frontmatter

```yaml
---
id: <SCHEMA>_EXTERNAL_DEPS
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, synonyms, interface, cross-schema, external]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Pravilo cross-schema komunikacije` | Obavezno | Opsti obrazac za ovu shemu |
| `## Sheme koje <SCHEMA> konzumira` | Obavezno | Po jedna podsekcija za svaku vanjsku shemu |
| `## Sta <SCHEMA> izlaze prema van` | Obavezno | Tablica interfejsnih paketa i konzumenata |

### Podsekcija za jednu vanjsku shemu

```markdown
### <VANJSKA_SHEMA> - <kratak opis>

- **API sinonim:** `<VANJSKA_SHEMA>_API`
- **Svrha:** Kratki opis

| Sinonim | Objekt u <VANJSKA_SHEMA> | Opis |
|---|---|---|
| `<VANJSKA_SHEMA>_API` | Interfejsni paket | |
| `<EXTERNAL_TABLE>` | <POTVRDJENI OPIS> | |

- **EXT pogledi:**

| Pogled | Svrha |
|---|---|
| `<EXT_VIEW_NAME>` | <POTVRDJENI OPIS> |
```

Ako shema koristi sinonime ali **nema EXT pogleda** za neku vanjsku shemu, navedi tu napomenu eksplicitno.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Relativne putanje (`../schemas/...`) | Uvijek `@00-ai/...` |
| `last_review` datum nije azuriran | Uvijek postavi na datum zadnje izmjene |

Greske specificne za katalog fajlove (tables.md, packages.md, views.md,
triggers.md, synonyms.md) su u njihovim posebnim standardima - vidi listu
na vrhu ovog dokumenta.
