---
project: "{{PROJECT_SLUG}}"
id: ORACLE_TABLES_CATALOG_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, tables, catalog, index, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za katalog tabela (tables.md)

Ovaj dokument definise obaveznu strukturu, frontmatter i pravilo izvora istine
za `tables.md` - navigacioni indeks tabela jedne Oracle sheme i mjesto za
stanje sinhronizacije njihove dokumentacije.

Opsti principi (jezik, putanje, dokazivost, `last_review`, separatori sekcija)
su definisani u `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
i vaze i za ovaj tip fajla - ovaj dokument ih ne ponavlja.

Za standard pojedinacne tabele vidi
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_table_rag_writing_standards.md`.

Template: `@00-ai/10-ai-standards/30-technical-documentation-standards/templates/tables_catalog_template.md`

---

## Lokacija i svrha

**Lokacija:** `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables.md`

`tables.md` je navigacioni indeks - jedan red po dokumentovanoj tabeli,
grupisan po domeni, sa linkom na detaljan fajl `tables/<naziv>.md`. Ne
duplira sadrzaj detaljnog fajla. Stanje sinhronizacije table RAG fajlova
cuva se u ovom katalogu, u sekciji "Stanje sinhronizacije dokumentacije
tabela"; ne kreira se zaseban registry fajl.

### Frontmatter

```yaml
---
id: <SCHEMA>_TABLES
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, tables, index]
last_review: YYYY-MM-DD
---
```

---

## Izvor istine i obim kataloga

`tables.md` je indeks dokumentovanih tabela, a pojedinacni `tables/<naziv>.md`
fajl opisuje potvrdjenu strukturu tabele. Obim dokumentovanja odredjuje zadatak.

- Stvarni DDL izvori smjestaju se u `@01-database/02-tables/`.
- Prisustvo drugih DB objekata, poput pogleda, ne potvrduje kompletnost
  definicija tabela; provjeriti dostupni DDL u obimu zadatka.
- Ako se uvede Flyway, V skripte predstavljaju istoriju promjena; samo pominjanje
  imena u staroj migraciji nije dokaz da tabela trenutno postoji.
- Strukturu potvrditi iz dostavljenog DDL-a, aktuelnog izvora ili odobrenog
  pregleda baze; ogranicenja dostupnih izvora navesti u dokumentu.
- Katalog ne prosirivati pretpostavljenim tabelama. Dodavati dokumente u obimu
  zahtjeva, ukljucujuci novu tabelu kada zadatak obuhvata njeno dokumentovanje.
- Potpunost kataloga znaci pokrivenost dogovorenog obima, a ne nepotvrdjenu
  tvrdnju da su popisane sve tabele u bazi.

Vidi i `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`.

---

## Pravila pisanja

- Na vrhu: link prema `overview.md` u quote bloku (`> Arhitekturni pregled: ...`)
- Poslije uvoda i prije prve grupe tabela: sekcija
  `## Stanje sinhronizacije dokumentacije tabela`
- Sadrzaj se grupira po domeni (npr. sifarnici, operativne tabele, dokumenti),
  ne abecedno
- Svaki red sadrzi: naziv tabele, kratak opis (jedna recenica), link na
  `tables/<naziv>.md`
- Svrha fajla je brza navigacija - ne duplirati sadrzaj iz `tables/<naziv>.md`
- Napomena o obimu pokrivenosti (npr. "X/X tabela dokumentovano") pise se
  samo ako je taj broj administrator eksplicitno potvrdio kao kompletan skup

### Tablica tabela

```markdown
## <Naziv grupe>

| Tabela | Opis | Detalji |
|---|---|---|
| `TABELA_A` | Kratki opis | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/tables/tabela_a.md` |
```

---

## Stanje sinhronizacije dokumentacije tabela

Ova sekcija cuva trenutno stanje provjere na nivou sheme. Obavezna je u
novim katalozima i pri uvodjenju ili premjestanju evidencije sinhronizacije
u postojeci katalog. Ne sluzi kao dokaz kompletnosti kataloga ili strukture
baze; pravilo izvora istine iznad ostaje na snazi.

Obavezna polja (V skripta se popunjava samo ako se koristi Flyway; inace
navesti `nije primjenjivo`):

| Polje | Sadrzaj |
|---|---|
| Posljednja obradjena V skripta | Puna `@01-database/...` putanja do najnovije stvarno obradjene skripte; ako nije poznata, `nije registrovana` |
| Datum posljednje sinhronizacije | Datum stvarnog pregleda u formatu `YYYY-MM-DD`; ako pregled nije potvrdjen, to eksplicitno navesti |
| Obim provjere | Konkretan skup izvora i tabela ili raspon skripti koji je pregledan; razlikovati inicijalni, inkrementalni i ciljani pregled od dokumentovanja iz dostavljenog DDL-a |
| Poznati izuzeci | Nepregledane skripte, praznine i nepotvrdjene informacije; ako nisu evidentirani, napisati to bez tvrdnje da izuzetaka nema |

Po potrebi dodati kratku napomenu o osnovu dokumentovanja. Istorijski datum
dokumentacionog prolaza moze se sacuvati uz jasno objasnjenje da nije datum
Flyway sinhronizacije. Pri premjestanju postojece evidencije sacuvati
registrovanu skriptu i datum, ali oznaciti ako stvarna obrada nije potvrdjena.
Samo premjestanje evidencije ne predstavlja novu sinhronizaciju.

### Postupak sinhronizacije

1. Kada je trazena sinhronizacija table RAG fajlova sa V skriptama, prvo
   ucitati ovu sekciju u `tables.md` odgovarajuce sheme.
2. Ako nema potvrdjene granice, inicijalni pregled raditi u trazenom obimu.
   Ne birati najnoviji naziv skripte u folderu kao dokaz da je sync uradjen.
   Dokumentacija iz dostavljenog DDL-a sama po sebi ne inicijalizuje Flyway
   sync niti zahtijeva rekonstrukciju strukture kroz cijelu V istoriju.
3. Kod inkrementalnog pregleda obraditi novije skripte i poznate izuzetke.
   Ne preskakati naknadno dodatu ili ranije neanaliziranu stariju skriptu.
   Za nepotvrdjene dijelove prethodnog obima ne pretpostavljati da su pokriveni.
4. Prema sadrzaju pregledanih skripti uskladiti odgovarajuce table RAG
   fajlove u odobrenom obimu. Ovo ne prosiruje katalog na osnovu V istorije
   bez zahtjeva korisnika/administratora.
5. Posljednju obradjenu V skriptu pomjeriti samo nakon stvarne obrade novije
   skripte. Obrada jedne skripte ne potvrdjuje pregled svih prethodnih;
   ciljani obim i preostale praznine eksplicitno navesti. Ako je obradjena
   samo starija skripta, zadrzati granicu i azurirati datum, obim i izuzetke.
6. Izuzetke ukloniti tek kada je odgovarajuca provjera obavljena. U katalogu
   cuvati trenutno stanje; prethodne granice, task istoriju i opise izmjena
   pojedinacnih objekata ne dodavati kao changelog. Opis objekta ostaje u
   odgovarajucem detaljnom RAG fajlu, a istorija izmjena u Gitu.

Pravila postupka definisana su samo u ovom standardu. Katalozi sadrze
konkretno stanje sheme i link na standard, bez kopiranja postupka.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Provjera kompletnosti kataloga kroz V skripte ili DDL istoriju | Katalog je zavrsen kad to administrator potvrdi; V istorija nije dokaz |
| Tabela dodata bez potvrdjenog izvora ili van obima zadatka | Dodavati dokumente prema potvrdjenom DDL-u i dogovorenom obimu |
| Tabela prijavljena kao "nedokumentovana" jer se pominje u V skripti | To nije relevantan dokaz za ovaj katalog - vidi "Izvor istine" iznad |
| Dupliranje sadrzaja iz `tables/<naziv>.md` | Samo naziv, kratak opis, link |
| Zaseban registry fajl ili kopiranje postupka u svaki katalog | Stanje u `tables.md`, postupak u ovom standardu |
| Najnoviji V timestamp predstavljen kao potvrda punog sync-a | Navesti stvarno pregledan obim i poznate izuzetke |
| Datum premjestanja evidencije upisan kao datum sync-a | Sacuvati datum stvarnog pregleda i njegova ogranicenja |
| Relativne putanje (`../schemas/...`) | Uvijek `@00-ai/...` |
| `last_review` datum nije azuriran | Uvijek postaviti na datum zadnje izmjene |
