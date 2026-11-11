---
project: "{{PROJECT_SLUG}}"
id: ORACLE_ALGORITHM_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, algorithm, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za Oracle algoritme

Ovaj dokument definise obaveznu strukturu, frontmatter i sekcije za RAG
dokumentaciju algoritamske/proceduralne poslovne logike koja je razbacana
kroz vise procedura ili paketa i koju standardni paket ili tabela RAG format
ne moze smisleno opisati (npr. planiranje, scheduling, matching, alokacija
resursa).

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori
sekcija) su definisani u `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ovaj tip fajla - ovaj dokument ih ne ponavlja. Ovo ukljucuje i
pravilo "Integracija izmjena, ne changelog": kad se algoritam izmijeni
(nova aktivnost, promijenjeno pravilo), opis se azurira kao da je oduvijek
tako izgledao - ne dodaje se recenica koja objasnjava sta je uradjeno kroz
koji zadatak.

Koristi ovaj standard kad:
- poslovna/algoritamska logika se grana kroz vise procedura, cesto u vise paketa
- postoji vise varijanti ili modova iste logike (npr. forward/backward
  planiranje, vise nacina rjesavanja istog problema) koje treba brzo uporediti
- pojedinacni paket ili tabela RAG fajl ne moze na smislen nacin objasniti
  "sta se desava kad se sve sastavi" (tok poziva kroz vise paketa, pravila
  koja vrijede za citav algoritam, ne za jednu proceduru)

Ne koristi ga za:
- opis jedne funkcije/procedure koja radi jednu jasnu, izolovanu stvar - to
  ide u odgovarajuci paket RAG fajl (`oracle_package_rag_writing_standards.md`)
- poslovna pravila namijenjena krajnjem korisniku, bez implementacionih
  detalja - to ide u korisnicku dokumentaciju (`screen_reference`/`workflow_guide`,
  vidi `@00-ai/10-ai-standards/40-user-documentation-standards/_index.md`)

Template-i:
`@00-ai/10-ai-standards/30-technical-documentation-standards/templates/algorithm_catalog_template.md`
i
`@00-ai/10-ai-standards/30-technical-documentation-standards/templates/algorithm_template.md`

---

## Tip: `db_algorithm_catalog` - Katalog algoritama sheme

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/_index.md`

Navigacioni indeks svih dokumentovanih algoritama sheme - jedan red po
algoritmu, dovoljno informacija da agent zna koji algoritam da otvori bez
citanja svih pojedinacnih fajlova.

### Frontmatter

```yaml
---
id: <SCHEMA>_ALGORITHMS
type: db_algorithm_catalog
schema: <SCHEMA>
tags: [<schema_malo>, algorithms, index]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Glavni tok` | Obavezno | Dispecerski/ulazni poziv koji bira algoritam - potvrdjeni lanac poziva |
| `## Dostupni algoritmi` | Obavezno | Tabela: algoritam, public poziv, smjer, namjena, link na detaljan opis ako postoji |
| `## Zajednicka pravila` | Opcionalno | Pravila koja vaze za vise/sve algoritme (npr. relevantni tipovi aktivnosti, transakciono ponasanje) |
| `## Povezani objekti` | Obavezno | Paketi/tabele koje ucestvuju u algoritmima |
| `## Napomene za odrzavanje RAG-a` | Preporuceno | Sta azurirati kad se algoritam mijenja |

### Tabela dostupnih algoritama

```markdown
| Algoritam | Public poziv | Smjer | Namjena | Detaljan opis |
|---|---|---|---|---|
| `AVAILABLE_SLOT` | `find_available_slot` | pretraga unaprijed | Ilustracija: pronalazak slobodnog termina u ambulanti | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/available_slot.md` |
```

Kolona `Detaljan opis` se popunjava samo za algoritme koji imaju poseban
`db_algorithm` fajl - ne izmisljati link ako fajl ne postoji.

---

## Tip: `db_algorithm` - Pojedinacni algoritam (deep-dive)

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/algorithms/<algorithm_name>.md`

Pise se samo za algoritme dovoljno slozene da im opis u katalogu (jedan red)
nije dovoljan - npr. imaju specificna pravila, staging/temp kontekst, vise
istorijskih naziva ili cestu istoriju pogresnog razumijevanja.

### Frontmatter

```yaml
---
id: <SCHEMA>_ALGORITHM_<ALGORITHM_NAME>
type: db_algorithm
schema: <SCHEMA>
object_name: <ALGORITHM_NAME>
tags: [<schema_malo>, algorithm, ...]
last_review: YYYY-MM-DD
---
```

### Redoslijed i status sekcija

| Sekcija | Status | Napomena |
|---|---|---|
| `## Sta radi` | Obavezno | Sta algoritam postize, 2-5 recenica |
| `## Tok poziva` | Obavezno | Potvrdjeni lanac poziva od ulazne tacke do algoritma |
| `## Kljucna pravila` | Obavezno | Konkretna pravila ponasanja algoritma |
| `## Odnos prema drugim algoritmima` | Opcionalno | Poredjenje sa srodnim algoritmima iz istog kataloga, ako postoje |
| `## Transakcije i logovanje` | Opcionalno | Runtime ponasanje (commit, logging) - samo ako je potvrdjeno |
| `## Napomene za izmjene` | Preporuceno | Sta sve provjeriti/azurirati kod izmjene ovog algoritma |

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Algoritam opisan unutar paket RAG fajla iako je logika razbacana kroz vise paketa | Izdvoji u poseban `db_algorithm` fajl i referenciraj ga iz svih ukljucenih paket RAG fajlova |
| Katalog bez linka na detaljan opis za algoritme koji ga imaju | Svaki red u `## Dostupni algoritmi` sa posebnim fajlom mora linkovati na njega |
| Stariji, nepotvrdjeni opis toka ostavljen bez oznake | Oznaci eksplicitno kao "stariji/istorijski opis, treba provjeru" ili ukloni ako je zamijenjen potvrdjenim opisom |
| Algoritam pomijesan sa korisnickim uputstvom (poslovni jezik bez implementacionih detalja) | Tehnicki deep-dive ide ovdje; poslovno objasnjenje za krajnjeg korisnika ide u `80-user-documentation/` |
