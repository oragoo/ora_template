---
project: "{{PROJECT_SLUG}}"
id: EXTERNAL_SQL_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, sql-server, external-module, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za eksterne SQL module

Ovaj dokument definise obaveznu strukturu, frontmatter i sekcije za RAG
dokumentaciju eksternih SQL modula u
`@00-ai/40-technical-documentation/03-integrations/<module>/` - pregled modula i pojedinacne procedure.

Ovaj standard koristiti kada postoji konkretan modul i dostupan izvor.
Putanje su planirane; `<module>`, DB platformu i stvarne nazive procedura
popuniti prema potvrdenoj integraciji. SQL Server primjeri vaze samo za tu
platformu; potpis i kvalifikaciju objekta prilagoditi stvarnoj bazi.

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori sekcija,
"Integracija izmjena, ne changelog") su definisani u
`@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ove tipove fajlova - ovaj dokument ih ne ponavlja. Konkretno za
proceduru: RAG opisuje sta procedura radi i njenu namjenu, ne vodi evidenciju
sta je mijenjano po kom zadatku ili kada.

Za Oracle RAG fajlove (tabela, paket, sema) koristi umjesto ovog:
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_table_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md`
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_schema_rag_writing_standards.md`

---

## Tip: `external_module_doc` - Pregled eksternog modula

**Lokacija:** `@00-ai/40-technical-documentation/03-integrations/<module>/overview.md`

### Frontmatter

```yaml
---
id: <MODULE>_OVERVIEW
type: external_module_doc
module: <MODULE>
tags: [<modul_malo>, overview, ...]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Svrha dokumentacije` | Obavezno | Koji folder pokriva, sta tu zivi |
| `## Sta ovaj sloj radi` | Obavezno | Potvrdjene operacije i tok razmjene podataka |
| `## Glavne komponente` | Obavezno | Tabele, kljucne procedure, dispatcheri |
| `## Primarni izvor podataka` | Obavezno | Putanja do izvornih fajlova |
| `## Ulazne tacke dokumentacije` | Obavezno | Tablica svih RAG fajlova modula |
| `## Napomene i upozorenja` | Obavezno | Dispatcher logika, JSON contract, lancani pozivi |

### Tablica ulaznih tacaka

```markdown
| Dokument | Sadrzaj |
|---|---|
| `@00-ai/40-technical-documentation/03-integrations/<module>/architecture.md` | Arhitektura i obrasci |
| `@00-ai/40-technical-documentation/03-integrations/<module>/procedures.md` | Navigacioni indeks procedura |
| `@00-ai/40-technical-documentation/03-integrations/<module>/procedures/<proc>.md` | Detaljna dokumentacija procedure |
```

---

## Tip: `procedure_doc` - Dokumentacija individualne SQL procedure

**Lokacija:** `@00-ai/40-technical-documentation/03-integrations/<module>/procedures/<naziv_procedure>.md`

### Frontmatter

```yaml
---
id: <MODULE>_PROC_<PROC_NAME>
type: procedure_doc
module: <MODULE>
procedure: <SCHEMA>.<NazivProcedure>
tags: [<modul_malo>, procedure, ...]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Izvorni fajl` | Obavezno | Putanja do `.sql` fajla |
| `## Svrha` | Obavezno | Sta procedura radi, u koji obrazac spada |
| `## Potpis` | Obavezno | SQL kod potpisa s parametrima |
| `## JSON ugovor` | Obavezno (ako JSON) | Struktura ulaznog i izlaznog JSON-a |
| `## Tok izvrsavanja` | Obavezno | Korak po korak |
| `## Zavisnosti` | Obavezno | Tabele i procedure koje poziva |
| `## Napomene` | Opcionalno | Popratni efekti, poznata ogranicenja |

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Procedura opisana kao "izmijenjena kroz zadatak <JIRA_KEY>" | Opisi samo sta procedura radi i njenu namjenu, bez pominjanja zadatka |
| `last_review` datum nije azuriran | Uvijek postavi na datum zadnje izmjene |
