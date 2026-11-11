---
project: "{{PROJECT_SLUG}}"
id: ORACLE_VIEWS_CATALOG_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, views, catalog, read-models, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za katalog Oracle pogleda (`views.md`)

Ovaj dokument definise pravila specificna za kreiranje i odrzavanje
`views.md` kataloga jedne Oracle sheme.

Opsta pravila za jezik, putanje, dokazivost, inferencije, frontmatter ID,
`last_review`, integraciju izmjena i separatore sekcija definisana su u:

`@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`

Ovaj standard nasljedjuje opsti standard i ne ponavlja njegova pravila osim
kada je potrebno precizirati njihovu primjenu na Oracle poglede.

Template za pisanje konkretnog kataloga nalazi se u:

`@00-ai/10-ai-standards/30-technical-documentation-standards/templates/views_catalog_template.md`

Ako postoji konflikt, primjenjuje se hijerarhija definisana u opstem RAG
standardu. Standard definise pravila i znacenje sekcija, a template definise
njihov prakticni raspored.

---

## Svrha i opseg

Svaka Oracle shema koja sadrzi najmanje jedan pogled treba imati jedan
`views.md` na lokaciji:

`@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/views.md`

`views.md` je:

- kompletan inventar trenutno postojecih pogleda sheme,
- navigacija prema SQL source fajlovima,
- pregled opstih konvencija naziva i upotrebe pogleda,
- pocetna tacka za developera, AI agenta i RAG pretragu.

Katalog treba omoguciti brz odgovor na pitanja:

- Koji pogledi postoje u shemi?
- Kojoj standardnoj grupi po nazivu pripadaju?
- Gdje se nalazi njihov SQL source?
- Koja opsta pravila upotrebe vaze za njihove prefikse?

Katalog opisuje sta postoji i gdje se nalazi. Ne sadrzi pojedinacne opise
poslovne uloge niti listu mjesta upotrebe za svaki pogled. Opsta pravila
upotrebe vode se jednom, prema konvenciji naziva. SQL source i pretraga
repozitorija ostaju izvor za detaljnu analizu konkretnog pogleda.

Ne kreirati prazan `views.md` samo radi forme ako shema nema poglede.

---

## Izvor istine

Autoritativni izvor za trenutne definicije pogleda je folder izvornih definicija pogleda:

`@01-database/04-view/`

DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.
U katalog ukljuciti samo objekte potvrdene sheme, cak i kada folder sadrzi
objekte vise vlasnika. Nekvalifikovan DDL zahtijeva potvrdu konteksta sheme.

Pri odredjivanju trenutnog inventara primjenjuju se sljedeca pravila:

- analizirati trenutno stanje Flyway `R__*.sql` fajlova u `04-view/` folderu,
- naziv objekta potvrditi iz stvarne `CREATE VIEW` ili `CREATE OR REPLACE VIEW`
  definicije, a ne samo iz naziva fajla,
- jedan source fajl moze definisati vise pogleda; svaki se evidentira posebno,
- samo postojanje SQL fajla nije dovoljno ako iz njegovog trenutnog sadrzaja
  nije moguce potvrditi konkretan pogled,
- V skripte, stari `DROP VIEW` iskazi i Flyway istorija ne koriste se za
  utvrdjivanje trenutnog inventara, osim kada korisnik izricito trazi
  istorijsku analizu.

Ako se stanje repozitorija i poznato runtime stanje baze razlikuju, ne
uskladjivati ih pretpostavkom. Razliku oznaciti kao nepotvrdjenu i navesti koji
je izvor koristen za katalog.

SQL source ostaje autoritativan za kolone, joinove, filtere, agregacije i druge
implementacione detalje pogleda.

---

## Pravilo kompletnosti kataloga

`views.md` mora sadrzavati svaki trenutno postojeci pogled sheme.

Primjenjuju se sljedeca pravila:

- jedan pogled ima tacno jedan red u katalogu,
- svaki red kataloga mora odgovarati pogledu potvrdjenom u trenutnom source-u,
- pogled koji i dalje postoji mora biti evidentiran i kada je `legacy` ili
  interni,
- pogled koji vise nije definisan u trenutnom source-u uklanja se iz kataloga,
- ako jedan SQL fajl definise vise pogleda, svi imaju zasebne redove sa istom
  source putanjom,
- wildcard zapisi kao `LOV_*`, `Pxxxxx_*`, `EXT_*` ili `REP_*` mogu
  opisivati opstu konvenciju, ali ne mogu zamijeniti pojedinacni spisak
  pogleda.

Prakticno pravilo je:

> jedan trenutno postojeci pogled = jedan red u katalogu

Kompletnost mora biti moguce provjeriti poredjenjem stvarnih `VIEW` definicija
u `04-view/` folderu sa zapisima u `views.md`.

---

## Frontmatter

Frontmatter konkretnog `views.md` mora sadrzavati:

| Polje | Pravilo |
|---|---|
| `id` | `<SCHEMA>_VIEWS`, sa nazivom sheme velikim slovima |
| `type` | `schema_doc` |
| `schema` | Tacan naziv Oracle sheme velikim slovima |
| `tags` | Najmanje naziv sheme malim slovima, `views` i `index` |
| `last_review` | Datum posljednje sadrzajne provjere prema opstem standardu |

Frontmatter sintaksa i placeholder-i definisani su u template-u. U ovom
standardu se ne odrzava njegova kopija.

---

## Obavezna struktura kataloga

Konkretni `views.md` sadrzi sljedece glavne sekcije:

| Sekcija | Status | Sadrzaj |
|---|---|---|
| Naslov dokumenta | Obavezno | Naziv sheme i oznaka da je dokument katalog pogleda |
| `## Izvor istine` | Obavezno | Iskljucivo putanja do odgovarajuceg `04-view/` foldera |
| `## Kako koristiti katalog` | Obavezno | Kratko uputstvo za provjeru source-a i tumacenje prefiksa |
| `## Konvencije naziva i opste upotrebe` | Obavezno | Jednom definisana pravila za `LOV_`, `Pxxxxx`, `EXT_`, `REP_` i ostale poglede |
| `## Katalog pogleda` | Obavezno | Sve standardne grupe i svi trenutno postojeci pogledi |
| `## Napomena` | Obavezno | Otvoreni problemi, greske i neusaglasenosti kataloga ili eksplicitna potvrda da nisu evidentirani |
| `## Odrzavanje` | Obavezno | Kratka pravila za dodavanje, izmjenu, uklanjanje i provjeru pogleda |

Nazivi glavnih sekcija su fiksni. Nazivi standardnih grupa unutar sekcije
`## Katalog pogleda` zavise od konkretne sheme.

Ne dodavati prazne sekcije. Ako obavezna sekcija nema ocekivani sadrzaj, prvo
provjeriti da li je katalog primjenjiv i kompletan.

---

## Sadrzaj sekcija

### `## Izvor istine`

Sekcija sadrzi samo tacnu putanju do source foldera konkretne sheme.

Ne ponavljati objasnjenja o ulozi kataloga, Flyway istoriji ili pravilima
postojanja pogleda. Ta pravila pripadaju ovom standardu.

### `## Kako koristiti katalog`

Sekcija treba kratko navesti da:

- katalog predstavlja pregled trenutno postojecih pogleda,
- se za implementacione detalje provjerava SQL source,
- se opsta upotreba tumaci prema konvenciji prefiksa,
- se konkretna mjesta upotrebe, kada su potrebna, utvrdjuju pretragom
  repozitorija i ne prepisuju u katalog.

Sekcija treba biti operativna i kratka. Ne prepisivati ostala pravila iz ovog
standarda.

### `## Konvencije naziva i opste upotrebe`

Sekcija sadrzi jednu tabelu sa opstom konvencijom za prepoznavanje vrste
pogleda:

| Obrazac naziva | Opsta upotreba |
|---|---|
| `LOV_*` | Pogledi za LOV liste unutar aplikacije. |
| `Pxxxxx_*` | Kontroler pogledi za APEX stranicu `xxxxx`; koriste se samo na toj stranici. `xxxxx` je petocifreni broj stranice. |
| `EXT_*` | Pogledi koji citaju podatke iz druge sheme i zamjenjuju direktan pristup njenim tabelama; mogu ih koristiti drugi pogledi i paketi. |
| `REP_*` | Pogledi koji se koriste u izvjestajima. |
| Ostali nazivi | Pogledi bez navedenih standardnih prefiksa; vode se u grupi `Ostali pogledi`. Mogu biti `legacy`, ali odsustvo prefiksa nije dokaz `legacy` statusa. |

Pravilo se navodi jednom u katalogu i ne ponavlja se uz svaki pogled. Obrazac
naziva sluzi za grupisanje i opstu interpretaciju. Za konkretne SQL detalje
ili mjesto upotrebe i dalje se provjerava source.

### `## Katalog pogleda`

Sekcija sadrzi standardne grupe kao podsekcije nivoa `###`, a zatim tabelu
sa pojedinacnim pogledima.

Svaka tabela koristi tacno sljedece kolone:

| Kolona | Sadrzaj |
|---|---|
| `Pogled` | Tacan Oracle naziv pogleda |
| `Izvor` | Direktna putanja do SQL fajla koji definise pogled |

Ne dodavati kolone za pojedinacni opis, mjesto upotrebe ili grupu. Grupa je
vec definisana naslovom podsekcije, a detalji konkretnog pogleda provjeravaju
se u SQL source-u i pretragom repozitorija.

### `## Napomena`

Sekcija evidentira otvorene probleme, greske i neusaglasenosti u samom
katalogu, na primjer:

- inventar nije potpuno provjeren prema trenutnom source-u,
- naziv pogleda u katalogu nije uskladjen sa DDL definicijom,
- source putanja nedostaje, nije direktna ili nije pouzdano potvrdjena,
- pogled je privremeno svrstan u grupu koju treba dodatno provjeriti,
- stanje repozitorija i poznato runtime stanje baze nisu uskladjeni,
- postoji druga prepreka zbog koje katalog nije moguce smatrati potpuno
  provjerenim.

Svaka napomena treba kratko opisati konkretan problem i, kada je moguce,
navesti `@` putanju do relevantnog izvora. Ne koristiti ovu sekciju kao
changelog niti za redovne opise pojedinacnih pogleda.

Ako nema poznatih problema, sekcija sadrzi tacno:

`Nema evidentiranih problema, gresaka ili neusaglasenosti.`

### `## Odrzavanje`

Sekcija sadrzi kratka operativna pravila za odrzavanje konkretnog kataloga:

- novi pogled se dodaje odmah nakon dodavanja u trenutni source,
- promjena naziva, grupe ili source putanje azurira postojeci red,
- uklonjeni pogled se uklanja iz kataloga nakon potvrde trenutnog source-a,
- pogled koji postoji, ali je `legacy`, ostaje u katalogu,
- otkriveni ili rijeseni problem azurira sekciju `## Napomena`,
- `last_review` se azurira nakon stvarne sadrzajne provjere.

Sekcija ne vodi changelog i ne navodi istoriju pojedinacnih izmjena.

---

## Grupisanje pogleda

Poglede grupisati prema standardnim obrascima naziva:

- `LOV pogledi` za `LOV_*`,
- `APEX kontroler pogledi` za `Pxxxxx_*`,
- `Eksterni pogledi` za `EXT_*`,
- `Izvjestajni pogledi` za `REP_*`,
- `Ostali pogledi` za sve ostale nazive.

U konkretnom katalogu koristiti samo grupe koje imaju najmanje jedan pogled.
Unutar grupe poglede sortirati abecedno. Jedan pogled se navodi samo u jednoj
grupi.

Pogled bez standardnog prefiksa svrstava se u `Ostali pogledi`. Ne oznacavati
ga kao `legacy` samo na osnovu naziva. Wildcard obrazac moze stajati samo u
opstoj tabeli konvencija; ne moze zamijeniti pojedinacne redove kataloga.

Katalog ne sadrzi listu kolona, tipove podataka, `SELECT`, joinove, filtere,
agregacije, SQL hintove, grant skripte ni Flyway istoriju.

---

## Source putanja

Svaki pogled mora imati direktnu `@01-database/` putanju do SQL fajla u kojem
je definisan.

Primjenjuju se sljedeca pravila:

- navesti stvarni fajl u `@01-database/04-view/` i potvrditi vlasnicku shemu iz izvora,
- navesti konkretan fajl, ne samo `04-view/` folder,
- ne koristiti relativne putanje,
- ne koristiti wildcard putanju kao izvor pojedinacnog pogleda,
- kada jedan fajl definise vise pogleda, ista putanja se moze ponoviti,
- putanja vodi do trenutne definicije pogleda, a ne do drugog ili istorijskog
  SQL fajla.

---

## Poseban dokument za pojedinacni pogled

Zaseban Markdown dokument za svaki pogled nije standardna praksa.

Poseban dokument ima smisla kada pogled:

- predstavlja javni ili integracioni ugovor,
- sadrzi slozenu i neociglednu poslovnu semantiku,
- ima sigurnosno osjetljivu funkciju,
- ima dokazano visok rizik promjene,
- zahtijeva pravila koristenja koja ne pripadaju katalogu.

Takav dokument mora referencirati `views.md` i odgovarajuci SQL source.
Pogled i dalje ostaje evidentiran u katalogu. Poseban dokument ne smije postati
alternativni source of truth za SQL implementaciju.

---

## Odrzavanje i provjera

### Dodavanje pogleda

Nakon dodavanja pogleda u trenutni source potrebno je:

1. potvrditi stvarni naziv objekta iz DDL-a,
2. dodati jedan red u odgovarajucu standardnu grupu,
3. dodati direktnu source putanju,
4. azurirati `last_review`.

### Izmjena ili preimenovanje pogleda

Katalog se mijenja ako su promijenjeni naziv, standardna grupa ili source
putanja. Tehnicka izmjena SQL-a koja ne mijenja katalogske podatke ne zahtijeva
izmjenu reda, ali moze zahtijevati novu sadrzajnu provjeru.

Kod preimenovanja azurirati postojeci zapis tako da katalog opisuje trenutno
stanje. Ne ostavljati stari naziv kao istorijski zapis.

### Uklanjanje pogleda

Zapis se uklanja tek kada je potvrdjeno da pogled vise nije definisan u
trenutnom source-u. Katalog ne vodi istoriju uklonjenih pogleda; istorija
pripada Git i Flyway evidenciji.

### Provjera kompletnosti

Revizija mora otkriti:

- pogled postoji u trenutnom source-u, ali nije u katalogu,
- pogled postoji u katalogu, ali nije u trenutnom source-u,
- isti pogled je naveden vise puta,
- naziv objekta nije uskladjen sa DDL-om,
- source putanja je netacna ili koristi wildcard,
- pogled je u pogresnoj grupi prema standardnom obrascu naziva,
- katalog sadrzi dodatne opisne kolone po pogledu.

Inventar objekata, duplikati, source putanje i grupisanje prema standardnim
prefiksima mogu se provjeravati automatizovano. `Legacy` status se ne smije
automatski izvesti samo iz naziva.

---

## Minimalni kriterij kvaliteta

`views.md` se smatra uskladjenim sa ovim standardom kada:

- sadrzi sve trenutno postojece poglede sheme,
- ne sadrzi poglede koji vise ne postoje u trenutnom source-u,
- svaki pogled je naveden tacno jednom,
- svaki pogled ima tacan Oracle naziv,
- svaki pogled pripada odgovarajucoj standardnoj grupi,
- svaki pogled ima direktnu i tacnu source putanju,
- tabela svakog pogleda sadrzi samo kolone `Pogled` i `Izvor`,
- katalog jednom navodi opste konvencije naziva i upotrebe,
- sekcija `## Napomena` navodi otvorene probleme ili eksplicitno potvrduje da
  nisu evidentirani,
- SQL implementacija nije nepotrebno duplicirana,
- struktura prati template,
- `last_review` odgovara posljednjoj sadrzajnoj provjeri.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Katalog sadrzi samo wildcard obrasce | Svaki pogled ima zaseban red |
| Postojanje fajla se automatski izjednacava sa postojanjem pogleda | Naziv objekta potvrditi iz trenutne DDL definicije |
| Jedan fajl sa vise pogleda ima samo jedan katalogski red | Svaki definisani pogled evidentirati zasebno |
| Katalog kopira SQL definiciju | Katalog navodi naziv pogleda i vodi do source-a |
| Pogledi su samo abecedno nabrojani bez grupa | Grupisati prema standardnim obrascima naziva, zatim sortirati abecedno |
| Opsta pravila prefiksa ponavljaju se u svakom redu | Navesti ih jednom u sekciji `Konvencije naziva i opste upotrebe` |
| Dodaju se opisne kolone po pogledu | Koristiti samo kolone `Pogled` i `Izvor` |
| Poznat problem kataloga nije evidentiran | Navesti ga u sekciji `Napomena` sa provjerljivim izvorom kada je dostupan |
| Sekcija `Napomena` se koristi kao changelog | Navesti samo trenutno otvorene probleme i neusaglasenosti |
| Source kolona vodi samo do foldera ili wildcard-a | Navesti direktnu putanju do konkretnog SQL fajla |
| `legacy` pogled je izostavljen | Ako trenutno postoji, mora biti evidentiran |
| Uklonjeni pogled ostaje radi istorije | Ukloniti ga; istorija pripada Git/Flyway evidenciji |
| Pravila opsteg standarda su prepisana u katalog | Katalog sadrzi samo konkretne podatke i kratka operativna uputstva |

---

## Glavno pravilo

> `views.md` govori sta postoji i gdje se nalazi.

> SQL source govori kako je pogled implementiran.

Katalog mora biti dovoljno kompletan da predstavlja pouzdan inventar Oracle
pogleda i dovoljno sazet da ostane navigacioni dokument.
