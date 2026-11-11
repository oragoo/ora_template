---
project: "{{PROJECT_SLUG}}"
id: RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, dokumentacija, predlozak]
last_review: 2026-10-05
---

# RAG standardi za pisanje dokumentacije

Ovaj dokument definise opsta pravila zajednicka za sve tipove RAG fajlova u
`00-ai/`: jezik, putanje, dokazivost, integraciju izmjena bez changelog-a,
ID konvencije, `last_review` i separatore sekcija. Specificni standardi
referenciraju ovaj dokument umjesto da ponavljaju njegova pravila.

Ovaj dokument se **ne koristi direktno za kreiranje ili reviziju** RAG fajla.
Za kreiranje ili reviziju konkretnog tipa RAG fajla uvijek se polazi od
odgovarajuceg specificnog standarda navedenog u sekciji "Specificni standardi
po tipu RAG fajla". Specificni standard je entry point za konkretan tip RAG
fajla, a ovaj dokument je zajednicka osnova.

Redoslijed primjene pravila je:

1. eksplicitan zahtjev korisnika,
2. specificni standard za tip RAG fajla,
3. ovaj opsti standard,
4. odgovarajuci template.

Specificni standard moze dopuniti ili suziti opste pravilo za svoj tip fajla.
Ako postoji konflikt, prednost ima specificni standard. Template ne smije
uvoditi pravilo koje nije uskladjeno sa standardima.

Specificni standardi po tipu RAG fajla:

- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_table_rag_writing_standards.md` - pojedinacna Oracle tabela
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md` - standardni i interfejsni Oracle paket
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_schema_rag_writing_standards.md` - pregled sheme
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_tables_catalog_rag_writing_standards.md` - katalog tabela (`tables.md`)
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_packages_catalog_rag_writing_standards.md` - katalog paketa (`packages.md`)
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_views_catalog_rag_writing_standards.md` - katalog pogleda (`views.md`)
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_triggers_catalog_rag_writing_standards.md` - katalog triggera (`triggers.md`)
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_synonyms_catalog_rag_writing_standards.md` - katalog sinonima (`synonyms.md`)
- `@00-ai/10-ai-standards/30-technical-documentation-standards/external_sql_rag_writing_standards.md` - eksterni eksterni SQL moduli (pregled modula i procedure; uslovna primjena)
- `@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_algorithm_rag_writing_standards.md` - algoritamska/proceduralna logika razbacana kroz vise paketa (katalog algoritama i pojedinacni algoritam)

---

## Opsti principi

### Jezik

Prva cetiri pravila ispod su univerzalna - vrijede za svu dokumentaciju i sve
komentare u kodu u ovom repou, ne samo za RAG fajlove. Drugi standardni
fajlovi referenciraju ovu sekciju umjesto da je prepisuju,
i mogu dodati svoja dodatna, kontekst-specificna pravila.

- Srpski jezik, latinica
- Pisati cistim tekstom, po mogucnosti ASCII
- Ne koristiti slova sa dijakritikom iz lokalne latinice; pisati samo ASCII varijante
- Ne koristiti ukrasne Unicode znakove

Dodatna pravila specificna za RAG dokumentaciju:
- Komentari, opisi i napomene treba da budu jednostavni tekstualni zapisi radi lakse pretrage i konzistentnosti
- Tehnicki termini bez standardnog srpskog ekvivalenta ostaju na engleskom: `APEX`, `Flyway`, `JSON`, `MERGE`, `CRUD`, `DML`, `PK`, `FK`, `legacy`, `dispatcher`, `trigger`, `grant`, `synonym`, `spec`, `body`
- Nazivi sekcija su na srpskom - ne koristiti engleske naslove poput "Overview", "Source of truth", "Side effects"

### Putanje

- Putanje prema drugim RAG fajlovima uvijek pocinju s `@00-ai/`
- Putanje prema izvornim Oracle fajlovima pocinju s `@01-database/`
- Putanje prema eksternim SQL skriptama navode se tek kada je poznat stvarni izvor;
  ne pretpostavljati poseban folder ili dostupnost eksternog repozitorijuma.
- Nikad relativne putanje (`../`), uvijek `@` prefix forme

### Projektni kontekst

- Stanje projekta i planirane lokacije: `@00-ai/_index.md`.
- DB source je u `@01-database/<tip-objekta>/`, bez nivoa foldera po shemama.
- `<schema>` u RAG putanjama je stvarni vlasnik objekta potvrdjen iz izvora;
  naziv projekta ne dokazuje naziv DB sheme.
- Imena objekata i poslovni primjeri u standardima su ilustrativni.
- Za licne, povjerljive i druge osjetljive podatke koristiti samo sinteticne primjere.
- Za folder koji sadrzi samo `.gitkeep` ne generisati katalog navodnih objekata.
- Kada zajednicki DB folder sadrzi objekte vise shema, katalog jedne sheme
  ukljucuje samo njene objekte. Vlasnika potvrditi iz DDL-a ili stvarnog
  konteksta izvrsavanja, a ne iz imena foldera ili projekta.
- Za poglede je potvrdjen format `R__<naziv_pogleda>.sql`, sa nazivom malim
  slovima. Za druge tipove objekata potvrditi stvarni naziv i ekstenziju izvora.
- Placeholderi i planirane lokacije nisu dokaz ni postojeci link: zamijeniti
  ih stvarnim putanjama ili jasno oznaciti da izvor jos nije dostupan.

### Dokazivost i oznacavanje inferencije

- Ne predstavljati pretpostavke, zakljucke ili obrasce kao potvrdjene cinjenice.
- Svaka netrivijalna tvrdnja mora biti zasnovana na konkretnom i pregledanom
  izvoru ili jasno oznacena kao inferencija.
- Direktno potvrdjenu tvrdnju, kada je korisno za provjeru, povezati sa izvorom
  formulacijom kao sto je `Potvrdjeno iz @...`, `Definisano u @...` ili
  `Vidljivo iz @...`.
- Tvrdnju koja nije direktno navedena u izvoru, ali se razumno izvodi iz
  dostupnih podataka, oznaciti formulacijom kao sto je `Inferirano na osnovu...`
  ili `Nije formalno potvrdjeno iz raspolozivih izvora`.
- Ako relevantan izvor nije pregledan ili nije dostupan, ne tvrditi da objekat,
  veza, pravilo, konfiguracija, zavisnost ili runtime ponasanje sigurno postoji.
- Izvor je autoritativan samo za informacije koje se iz njega mogu direktno
  utvrditi. Njegov sadrzaj ne prosirivati implicitnim pretpostavkama.
- Informacije koje nisu prisutne u pregledanom izvoru ne smiju se tiho dodavati
  kao sluzbeni dio dokumentacije.
- Dopune izvedene iz konvencije, obrasca, naziva, slicnih objekata ili
  arhitekturalnog konteksta moraju biti oznacene kao inferencija ili preporuka.
- Kada postoji vise izvora, koristiti izvor koji je za predmetnu informaciju
  definisan kao izvor istine.
- Ako su izvori neuskladjeni ili nepotpuni, razliku eksplicitno navesti umjesto
  samostalnog uskladjivanja ili nagadjanja.

Osnovno pravilo:

> RAG dokumentacija mora jasno razlikovati potvrdjenu cinjenicu, inferenciju i
> nepotvrdjenu informaciju.

DDL, API specifikacija, konfiguracija ili drugi dostavljeni izvor moze se
koristiti kao dokaz samo u granicama onoga sto direktno definise. Na primjer,
DDL je validan izvor za strukturu koju sadrzi, ali nije sam po sebi dokaz
runtime upotrebe, aktivnog konzumenta ili operativnog ponasanja.

### Integracija izmjena, ne changelog

RAG fajl opisuje trenutno stanje objekta (tabele, paketa, procedure, kolone),
ne istoriju njegovih izmjena. Kad se objekat izmijeni, RAG se azurira
integracijom te izmjene u postojeci opis - kao da je oduvijek tako izgledalo -
ne dodavanjem "changelog" recenice koja objasnjava sta je uradjeno i po kom
zadatku.

- Primjer (tabela): kad se doda kolona `COL10`, ona se jednostavno unese u
  tablicu kolona kao i sve ostale vec dokumentovane kolone - ne pise se da je
  "dodata kroz zadatak <JIRA_KEY>", niti da je "nova".
- Primjer (paket/procedura): RAG opisuje sta procedura/funkcija radi, njenu
  namjenu i ostale tehnicke detalje - ne vodi evidenciju sta je mijenjano po
  kom zadatku ili kada.
- Ovo vazi za sve sekcije RAG fajla (kolone, procedure, zavisnosti,
  napomene), ne samo za header komentare u samom kodu.
- RAG fajl nikad ne pominje Jira/task ID, datum izmjene niti razlog izmjene
  kao dio opisa objekta - to su podaci koji pripadaju task fajlu i git
  istoriji, ne RAG dokumentaciji.

Detaljnije pravilo, sa dodatnim primjerom: `@00-ai/10-ai-standards/20-task-standards/ai_task_writing_rules.md` -> "Korekcija dokumentacije nakon izmjene".

### Razdvajanje tehnicke i korisnicke dokumentacije

- `40-technical-documentation/01-database/` (Oracle sheme, tabele, paketi u `01-oracle/`; eksterne integracije u `@00-ai/40-technical-documentation/03-integrations/`) i tehnicki standardi sluze za razvojni, implementacijski i integracioni kontekst
- `@00-ai/80-user-documentation/` sluzi iskljucivo za krajnja korisnicka uputstva i dokumente
- U tehnickim RAG fajlovima ne referencirati `@00-ai/80-user-documentation/...`
- U korisnickim uputstvima ne prepisivati razvojne i implementacijske detalje osim ako su neophodni za razumijevanje korisnickog postupka

### Primjena standarda

- Standard je obavezan za nove RAG fajlove i za fajlove koje znacajno mijenjas
- Postojeci stariji RAG fajlovi uskladjuju se inkrementalno, kad ih stvarno dotaknes
- Nije cilj retroaktivno preformatirati cijeli repo bez posebnog zahtjeva
- Ne uvoditi prazne ili trivijalne sekcije samo da bi forma bila ispostovana

### ID konvencija u frontmatteru

| Tip fajla | Obrazac ID-a | Primjer |
|---|---|---|
| Tabela | `<SCHEMA>_TABLE_<OBJECT_NAME>` | `{{DOC_ID_PREFIX}}_TABLE_APPOINTMENTS` |
| Paket | `<PACKAGE_NAME>` (velika slova) | `APPOINTMENT_PKG` |
| Pregled sheme | `<SCHEMA>_OVERVIEW` | `{{DOC_ID_PREFIX}}_OVERVIEW` |
| Vanjske zavisnosti sheme | `<SCHEMA>_EXTERNAL_DEPS` | `{{DOC_ID_PREFIX}}_EXTERNAL_DEPS` |
| Indeks tabela sheme | `<SCHEMA>_TABLES` | `{{DOC_ID_PREFIX}}_TABLES` |
| Indeks paketa sheme | `<SCHEMA>_PACKAGES` | `{{DOC_ID_PREFIX}}_PACKAGES` |
| Katalog pogleda sheme | `<SCHEMA>_VIEWS` | `{{DOC_ID_PREFIX}}_VIEWS` |
| Katalog triggera sheme | `<SCHEMA>_TRIGGERS` | `{{DOC_ID_PREFIX}}_TRIGGERS` |
| Katalog sinonima sheme | `<SCHEMA>_SYNONYMS` | `{{DOC_ID_PREFIX}}_SYNONYMS` |
| Pregled eksternog modula | `<MODULE>_OVERVIEW` | `EXTERNAL_MODULE_OVERVIEW` |
| Eksterna procedura | `<MODULE>_PROC_<PROC_NAME>` | `EXTERNAL_MODULE_PROC_IMPORT_RESULT` |
| Katalog algoritama sheme | `<SCHEMA>_ALGORITHMS` | `{{DOC_ID_PREFIX}}_ALGORITHMS` |
| Pojedinacni algoritam | `<SCHEMA>_ALGORITHM_<ALGORITHM_NAME>` | `{{DOC_ID_PREFIX}}_ALGORITHM_AVAILABLE_SLOT` |

### `last_review`

- Format je `YYYY-MM-DD`.
- Vrijednost predstavlja datum posljednje sadrzajne provjere ili izmjene fajla.
- Datum se ne mijenja samo zbog formatiranja koje ne utice na sadrzaj.
- Vrijednost ne smije ostati prazna.

### Separatori sekcija

- Svaka glavna sekcija nivoa `##` zavrsava linijom `---` prije sljedece glavne
  sekcije.
- Separator dolazi ispod posljednjeg reda sadrzaja sekcije, ne iznad naslova
  sljedece sekcije.

---

## Ceste greske (opste, vrijede za sve tipove RAG fajlova)

| Greska | Ispravno |
|---|---|
| Relativne putanje (`../schemas/...`) | Uvijek `@00-ai/...` |
| `last_review` datum nije azuriran | Postavi datum posljednje sadrzajne provjere ili izmjene |
| Engleski naslov sekcije (Overview, Side effects, Source of truth) | Prevedi na srpski prema ovom dokumentu |
| Pretpostavka je napisana kao cinjenica | Navedi dokaz ili jasno oznaci inferenciju |
| Informacija je dopunjena po slicnom objektu bez oznake | Oznaci je kao inferenciju ili preporuku |
| Pravilo za samo jedan tip fajla dodato je u opsti standard | Premjesti ga u odgovarajuci specificni standard |

Greske specificne za pojedinacan tip RAG fajla (Oracle tabela, paket, sema
dokument, eksterni SQL Server modul) su u odgovarajucim specificnim
standardima (vidi pointer-e na vrhu ovog dokumenta).
