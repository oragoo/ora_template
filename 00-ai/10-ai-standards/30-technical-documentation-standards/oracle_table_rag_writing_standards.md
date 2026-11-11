---
project: "{{PROJECT_SLUG}}"
id: ORACLE_TABLE_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, table, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za Oracle tabele

Ovaj dokument definise obaveznu strukturu, frontmatter i sekcije za RAG
dokumentaciju jedne Oracle tabele.

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori sekcija)
su definisani u `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ovaj tip fajla - ovaj dokument ih ne ponavlja. Ovo ukljucuje i
pravilo "Integracija izmjena, ne changelog": kad se doda kolona (npr.
`COL10`), ona se jednostavno unese u tablicu kolona kao i sve ostale vec
dokumentovane kolone - ne pise se da je "dodata kroz zadatak <JIRA_KEY>" niti da
je "nova".

Template za novu tabelu: `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/table_template.md`

---

## Tip: `db_table` - Individualna tabela

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables/<naziv_tabele>.md`

### Frontmatter

```yaml
---
id: <SCHEMA>_TABLE_<TABLE_NAME>
type: db_table
schema: <SCHEMA>
object_name: <TABLE_NAME>
tags: [<schema_malo>, <oznaka_domene>, table, ...]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Svrha` | Obavezno | Kratki opis svrhe tabele, 2-5 recenica |
| `## Kolone` | Obavezno | Tablica s kolonama |
| `## Poslovna i runtime upotreba` | Obavezno* | Kad postoje dokazivi tragovi u paketima, view-ovima, integracijama ili consumerima |
| `## Poslovno znacenje` | Opcionalno | Koristi kad je vazno objasniti sta jedan red predstavlja; moze biti alternativa ili dopuna runtime sekciji |
| `## Statusi` | Opcionalno | Samo ako postoji kolona tipa STATUS s enum vrijednostima |
| `## Kljucevi i ogranicenja` | Obavezno | PK, FK, unique constrainti |
| `## Indeksi` | Obavezno | Svi potvrdjeni indeksi; `Svrha` kolona je pozeljna kad stvarno dodaje vrijednost |
| `## Audit i lifecycle` | Opcionalno | Ako postoji trigger koji puni audit kolone ili lifecycle logiku |
| `## Privilegije` | Opcionalno | Ako postoje GRANT iskazi nad tabelom |
| `## Integracioni payload` | Opcionalno | Ako tabela ucestvuje u JSON/XML ili drugom integracionom ugovoru |
| `## Povezani objekti` | Obavezno | Sve tabele, sekvence, triggeri, paketi koji koriste ovu tabelu |
| `## Pravila za rad` | Opcionalno | Koristi samo kad postoji stvarno domenjsko pravilo, zabranjeni put za DML ili jasno propisan nacin rada |
| `## Napomene` ili `## Napomene i poznata ogranicenja` | Preporuceno | Tehnicki dug, legacy kolone, poznate anomalije |

\* Ako za tabelu nema dovoljno dokazivih runtime tragova, umjesto ove sekcije je dovoljan
jasan `## Poslovno znacenje`.

### Tablica kolona

```markdown
| Kolona | Tip | Obavezno | Default | Opis |
|---|---|---|---|---|
| `ID` | `NUMBER(10)` | DA | - | Primarni kljuc, puni sekvenca |
```

- Obavezno: DA / NE
- Default: vrijednost ili `-` / `-` ako nema; budi konzistentan unutar istog fajla
- Opis: jedna recenica, naglasi poslovno znacenje; navedi ako trigger puni automatski

### Tablica kljuceva

```markdown
| Ogranicenje | Tip | Kolone |
|---|---|---|
| `TABLE_PK` | Primary Key | `ID` |
| `TABLE_FK1` | Foreign Key | `X_ID -> DRUGA_TABELA.ID` |
| `TABLE_UK1` | Unique | `KOL_A, KOL_B` |
```

- Ako je tabela nastala direktno iz korisnickog DDL-a, tabela kolona u RAG-u mora biti potpuna u odnosu na taj DDL; ne izostavljaj "manje bitne" kolone radi sazetka

### Tablica indeksa

```markdown
| Indeks | Tip | Kolone / izraz |
|---|---|---|
| `TABLE_PK` | Unique | `ID` |
| `TABLE_IDX1` | Non-unique | `TRUNC(DATUM)` |
```

Dopustena je i prosirena varijanta sa kolonom `Svrha` ako to pomaze citljivosti:

```markdown
| Indeks | Kolone / izraz | Svrha |
|---|---|---|
| `TABLE_IDX1` | `TRUNC(DATUM)` | Pretraga po datumu |
```

### Tablica povezanih objekata

```markdown
| Objekt | Tip | Veza |
|---|---|---|
| `DRUGA_TABELA` | Tabela | FK veza |
| `TABLE_SEQ` | Sekvenca | Puni ID na INSERT |
| `BIUD_TABLE` | Trigger | Audit polja |
| `CORE_PKG` | Paket | Jedina dozvoljena tacka za DML |
```

---

## Sinhronizacija dokumentacije tabela

Stanje sinhronizacije cuva se u
`@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables.md`,
u sekciji "Stanje sinhronizacije dokumentacije tabela".
Postupak i pravila odrzavanja definisani su u istoimenoj sekciji standarda
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_tables_catalog_rag_writing_standards.md`.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Nepotpuna lista kolona kad postoji korisnicki DDL | Tabela kolona u RAG-u mora biti potpuna u odnosu na dostavljeni DDL |
| `## Poslovna i runtime upotreba` izostavljena bez zamjene | Ako nema dokazivih runtime tragova, umjesto nje napisi jasan `## Poslovno znacenje` |
| Nova kolona opisana kao "dodata kroz zadatak <JIRA_KEY>" | Kolona se unosi u tablicu kolona kao i sve ostale, bez pominjanja zadatka ili da je nova |
| `last_review` datum nije azuriran | Uvijek postavi na datum zadnje izmjene |
