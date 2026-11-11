---
project: "{{PROJECT_SLUG}}"
id: ORACLE_PACKAGES_CATALOG_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, packages, catalog, index, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za katalog paketa (packages.md)

Ovaj dokument definise obaveznu strukturu, frontmatter i pravilo izvora istine
za `packages.md` - navigacioni indeks paketa jedne Oracle sheme.

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori sekcija)
su definisani u `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ovaj tip fajla - ovaj dokument ih ne ponavlja.

Za standard pojedinacnog paketa (standardnog i interfejsnog `*_interface_pkg`)
vidi `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md`.

Template: `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/packages_catalog_template.md`

---

## Lokacija i svrha

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages.md`

`packages.md` je navigacioni indeks - jedan red po paketu iz trenutnog
source-a, grupisan po tipu/domeni (core/util, controller, interface). Ako
postoji detaljni fajl `packages/<naziv>.md`, red vodi do njega; ako ne
postoji, kolona `Detalji` sadrzi `TBD`. Katalog ne duplira procedure,
funkcije i zavisnosti iz detaljnog fajla.

### Frontmatter

```yaml
---
id: <SCHEMA>_PACKAGES
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, packages, index]
last_review: YYYY-MM-DD
---
```

---

## Izvor istine

Jedini izvor istine za trenutni inventar paketa je folder za izvorne definicije paketa:

`@01-database/05-packages/`

DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.
U katalog ukljuciti samo objekte potvrdene sheme, cak i kada folder sadrzi
objekte vise vlasnika. Nekvalifikovan DDL zahtijeva potvrdu konteksta sheme.

- Paket postoji kada trenutni `.spc`, `.bdy`, `.pks`, `.pkb` ili `.sql` source sadrzi
  stvarni `CREATE PACKAGE` ili `CREATE OR REPLACE PACKAGE` iskaz.
- Naziv paketa potvrditi iz DDL iskaza, ne samo iz naziva fajla.
- Specifikacija i body istog paketa predstavljaju jedan paket i jedan
  katalogski red; ne brojati source fajlove kao odvojene pakete.
- Standalone `.prc` i `.fnc` rutine u istom folderu nisu paketi i ne ulaze
  u `packages.md`.
- Pri provjeri da li je katalog azuran (nedostaje paket, ima "orphan" red)
  porediti iskljucivo trenutno stanje `05-packages/` foldera sa sadrzajem
  `packages.md` - ne konsultovati V skripte, `DROP PACKAGE` iskaze niti drugu
  Flyway istoriju; ona je nebitna za ovu provjeru.
- Ako je paket uklonjen iz sheme (source fajl obrisan), red u `packages.md` i
  pripadajuci `packages/<naziv>.md` se uklanjaju u istom dokumentacionom
  prolazu.

Vidi i `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md` -> "Dokazivost i oznacavanje inferencije".

---

## Pravilo kompletnosti kataloga

- svaki paket potvrdjen u trenutnom source-u mora imati tacno jedan red u
  katalogu,
- paket se ne smije izostaviti zato sto nema detaljni Markdown fajl,
- paket sa postojecim detaljnim fajlom mora imati direktnu
  `@00-ai/.../packages/<naziv>.md` putanju u koloni `Detalji`,
- paket bez detaljnog fajla mora imati oznaku `TBD` u koloni `Detalji`,
- `TBD` znaci da detaljna dokumentacija tek treba biti napisana; ne znaci da
  paket nije provjeren u source-u,
- red bez odgovarajuceg paketa u trenutnom source-u je orphan i uklanja se iz
  kataloga.

Prakticno pravilo:

> jedan trenutni `CREATE PACKAGE` objekat = jedan katalogski red

---

## Pravila pisanja

- Na vrhu: link prema `overview.md` u quote bloku
- Grupisati po tipu/domeni (npr. core/util, controller po APEX stranici,
  interface), ne abecedno
- Svaki red sadrzi naziv paketa, kratku ulogu i vrijednost `Detalji`:
  direktnu putanju do `packages/<naziv>.md` ili `TBD`
- Interfejsni paketi (`*_interface_pkg`) izdvajaju se u posebnu grupu sa
  dodatnom kolonom "Konzument" (koja shema/aplikacija ga koristi)
- Napomena o obimu pokrivenosti (npr. "X/X paketa dokumentovano") pise se
  samo kada je broj jedinstvenih DDL-potvrdjenih paketa uporedjen sa brojem
  postojecih detaljnih Markdown fajlova; ne koristi se broj source fajlova

### Tablica core/util i controller paketa

```markdown
## <Naziv grupe>

| Paket | Uloga | Detalji |
|---|---|---|
| `CORE_PKG` | Kratak opis uloge | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/core_pkg.md` |
| `UNDOCUMENTED_PKG` | Kratak opis potvrdjen iz source-a | `TBD` |
```

### Tablica interface paketa

```markdown
## Interface paketi (cross-schema)

| Paket | Konzument | Svrha | Detalji |
|---|---|---|---|
| `<SCHEMA>_X_INTERFACE_PKG` | `X` shema | Svrha interfejsa | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/<schema>_x_interface_pkg.md` |
| `<SCHEMA>_Y_INTERFACE_PKG` | `Y` shema | Svrha interfejsa | `TBD` |
```

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Provjera postojanja paketa kroz V skripte ili istoriju uklanjanja | Jedini dokaz je trenutni source fajl u `05-packages/` |
| Specifikacija i body se broje kao dva paketa | Jedan DDL paket ima jedan katalogski red |
| Paket bez detaljnog Markdown fajla je izostavljen | Paket ostaje u katalogu sa oznakom `TBD` |
| Nepostojeca Markdown putanja ostaje u koloni `Detalji` | Koristiti `TBD` dok fajl stvarno ne postoji |
| Paket ostaje u katalogu nakon sto je source fajl obrisan | Ukloniti red iz `packages.md` i obrisati `packages/<naziv>.md` u istom prolazu |
| Dupliranje liste procedura/funkcija u katalogu | Detalji idu u `packages/<naziv>.md`, ne u indeks |
| Relativne putanje (`../schemas/...`) | Uvijek `@00-ai/...` |
| `last_review` datum nije azuriran | Uvijek postaviti na datum zadnje izmjene |
