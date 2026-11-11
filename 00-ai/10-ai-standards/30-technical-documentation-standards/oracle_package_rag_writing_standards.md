---
project: "{{PROJECT_SLUG}}"
id: ORACLE_PACKAGE_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, package, interface-pkg, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za Oracle pakete

Ovaj dokument definise obaveznu strukturu, frontmatter i sekcije za RAG
dokumentaciju jednog Oracle paketa - standardnog i cross-schema interfejsnog
(`*_interface_pkg`).

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori sekcija)
su definisani u `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ovaj tip fajla - ovaj dokument ih ne ponavlja. Ovo ukljucuje i
pravilo "Integracija izmjena, ne changelog": RAG opisuje sta
procedura/funkcija radi i njenu namjenu - ne vodi evidenciju sta je mijenjano
po kom zadatku ili kada.

Template za standardni paket: `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/package_template.md`
Template za interfejsni paket: `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/package_interface_template.md`

---

## Tip: `package_doc` - Standardni Oracle paket

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/<naziv_paketa>.md`

### Frontmatter

```yaml
---
id: <PACKAGE_NAME>
type: package_doc
schema: <SCHEMA>
package: <PACKAGE_NAME>
tags: [<schema_malo>, <oznaka_domene>, ...]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Izvorni fajlovi` | Obavezno | Ide **prije** Svrhe - stvarni source fajlovi |
| `## Svrha` | Obavezno | Sta paket radi, kome je namijenjen |
| `## Tipican tok` | Opcionalno | Za orkestracione pakete - redoslijed poziva |
| `## Kursori` | Opcionalno | Samo ako spec eksponira kursore |
| `## Funkcije - <kategorija>` | Opcionalno | Tablica funkcija po kategoriji |
| `## Procedure - <kategorija>` | Obavezno (ako ima) | Procedure, grupisane po domeni |
| `## Zavisnosti` | Obavezno | Sve tabele i paketi koje ovaj paket koristi |
| `## Privatne procedure` | Opcionalno | Procedure koje postoje samo u body dijelu i imaju bitan kontekst |
| `## Implementacione napomene` | Opcionalno | Netrivijalna ponasanja, granicni slucajevi |
| `## Napomene` | Opcionalno | Poznate anomalije, preimenovani parametri, legacy |

### Sekcija `## Izvorni fajlovi`

Za sheme koje koriste `.spc` / `.bdy`:
```markdown
## Izvorni fajlovi

- Spec: `@01-database/05-packages/<naziv_paketa>.spc`
- Body: `@01-database/05-packages/<naziv_paketa>.bdy`
```

Za sheme koje koriste `.pks` / `.pkb`:
```markdown
## Izvorni fajlovi

- Spec: `@01-database/05-packages/<naziv_paketa>.pks`
- Body: `@01-database/05-packages/<naziv_paketa>.pkb`
```

> Uvijek koristi stvarno fizicko ime fajla iz repoa - ne pretpostavljaj naziv iz Oracle package imena.

### Tablica funkcija

```markdown
| Funkcija | Opis |
|---|---|
| `get_something(p_id)` | Vraca X po ID-u; null ako ne postoji |
```

- Potpis: samo parametre koji su bitni za razumijevanje - ne pusi listom svih
- Opis: sta vraca i kad je null/exception

### Sekcija procedure - kad treba detaljan potpis

Za kompleksne procedure s netrivijalnim parametrima, pisi SQL blok i posebnu tablicu parametara:

```markdown
### `PROCEDURE_NAME`

Kratki opis svrhe.

\`\`\`sql
procedure procedure_name(
    p_param1 in  tabela.kolona%type
   ,p_param2 in  varchar2 default null
   ,p_result out number
)
\`\`\`

| Parametar | Obavezno | Opis |
|---|---|---|
| `p_param1` | DA | ... |
| `p_param2` | NE | null = ... |
| `p_result` | OUT | vraca X |
```

Za jednostavne procedure bez posebne logike, dovoljna je jedna recenica iza naziva u listi.

### Tablica zavisnosti

```markdown
| Objekat | Smjer | Svrha |
|---|---|---|
| `UTIL_PKG` | Poziva | Helperi i konstante |
| `APPOINTMENTS` | DML | INSERT/UPDATE termina |
| `EXT_SERVICE_CATALOG_V` | SELECT | Sifrarnik usluga |
| `<LOGGER_PACKAGE>` | Poziva | Logovanje operacija |
```

- Smjer: `Poziva` (procedura/funkcija), `DML` (INSERT/UPDATE/DELETE), `SELECT`
- Navedi samo direktne zavisnosti iz ovog paketa

---

## Tip: `package_doc` - Interfejsni paket (`*_interface_pkg`)

Sve sekcije standardnog `package_doc` su obavezne, plus sljedece **dodatne obavezne sekcije**.

Redoslijed izmijenjenog dijela:

| Sekcija | Status | Napomena |
|---|---|---|
| `## Izvorni fajlovi` | Obavezno | Kao u standardnom |
| `## Svrha` | Obavezno | + eksplicitno navedi cross-schema granicu |
| `## Tok podataka` | Obavezno | ASCII lanac od pozivajuce strane do core paketa |
| procedure/funkcije ... | Obavezno | Kao u standardnom |
| `## Tabele koje paket mijenja` | Obavezno | Tablica s operacijama po tabeli |
| `## Cross-schema i runtime zavisnosti` | Obavezno | Umjesto standardnih Zavisnosti |
| `## Dokazivi konzumenti` | Obavezno | Grant + sinonim + stvarni poziv (s putanjom do fajla) |
| `## Standardni redoslijed poziva` | Opcionalno | Ako redoslijed ima znacajan uticaj |
| `## Poznata ogranicenja i oprez` | Obavezno | Zakucana logika, tihi kvarovi, pretpostavke pozivajuce strane |
| `## Kada koristiti ovu dokumentaciju` | Opcionalno | Lista situacija |

### Sekcija `## Tok podataka`

```markdown
## Tok podataka

\`\`\`text
Konzumerska shema
    -> sinonim consumer.owner_api
        -> owner_consumer_interface_pkg
            -> core_pkg / util_pkg
\`\`\`
```

Ilustrativni obrazac slozenije integracije (koristiti samo ako je potvrdjen):

```markdown
\`\`\`text
Eksterni sistem
    -> staging tabele integracije
        -> integration_consumer_interface_pkg
            -> sinonim integration.owner_api
                -> owner_integration_interface_pkg
                    -> core_pkg
\`\`\`
```

### Sekcija `## Dokazivi konzumenti`

```markdown
## Dokazivi konzumenti

- `@01-database/01-synonyms/<owner_api_source>.sql`
  definira sinonim `consumer.owner_api` prema ovom paketu
- `@01-database/05-packages/<consumer_package_source>.bdy`
  koristi: `procedure_a`, `procedure_b`
```

> Ne navoditi pretpostavljene konzumente - samo one potvrdjene u izvornom kodu.

### Sekcija `## Tabele koje paket mijenja`

```markdown
## Tabele koje paket mijenja

| Tabela | Operacije |
|---|---|
| `CLINIC_ROOMS` | `INSERT`, `UPDATE` |
| `VISITS` | `INSERT`, `UPDATE` |
```

---

## Obavezna provjera interfejsnog lanca

Ovaj standard je jedini izvor pravila za package RAG dokumente. Za svaki
`*_interface_pkg` dodatno potvrdi stvarna fizicka imena source fajlova, owner
i consumer shemu, `GRANT EXECUTE`, konkretan sinonim i stvarni consumer poziv.
Dokumentuj cijeli lanac od consumer koda, preko sinonima i interface paketa,
do core/util paketa. Ne pretpostavljaj genericko ime ako repo koristi izuzetak.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| `## Izvorni fajlovi` nedostaje ili je nakon `## Svrha` | Ide **prije** `## Svrha` u svim package fajlovima |
| Naziv fajla pretpostavljen umjesto provjeren | Provjeri fizicko ime u repou; postojeci naziv se zadrzava radi kompatibilnosti |
| `*_interface_pkg` bez `## Dokazivi konzumenti` | Obavezno - bez ovoga se ne moze verifikovati cross-schema lanac |
| `## Zavisnosti` u interface_pkg bez sinonima | Za interface_pkg koristi `## Cross-schema i runtime zavisnosti` - ukljucuje sinonim |
| Procedure dokumentovane u jednom bloku bez grupiranja | Grupisi po domeni (Pacijenti, Termini, Pregledi...) |
| Nova/izmijenjena procedura opisana kao "dodato kroz zadatak <JIRA_KEY>" | Opisi samo sta procedura radi i njenu namjenu, bez pominjanja zadatka ili datuma izmjene |
| `last_review` datum nije azuriran | Uvijek postavi na datum zadnje izmjene |
