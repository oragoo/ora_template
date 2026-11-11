---
project: "{{PROJECT_SLUG}}"
id: ORACLE_SYNONYMS_CATALOG_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, synonyms, catalog, cross-schema, dependencies, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za katalog Oracle sinonima (`synonyms.md`)

Ovaj dokument definise pravila specificna za kreiranje i odrzavanje
`synonyms.md` kataloga jedne Oracle sheme.

Opsta pravila za jezik, putanje, dokazivost, inferencije, frontmatter ID,
`last_review`, integraciju izmjena i separatore sekcija definisana su u:

`@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`

Template za pisanje konkretnog kataloga nalazi se u:

`@00-ai/10-ai-standards/30-technical-documentation-standards/templates/synonyms_catalog_template.md`

Ako postoji konflikt, primjenjuje se hijerarhija definisana u opstem RAG
standardu.

---

## Svrha i opseg

Svaka Oracle shema koja sadrzi najmanje jedan sinonim treba imati jedan
`synonyms.md` na lokaciji:

`@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/synonyms.md`

`synonyms.md` je:

- kompletan inventar trenutno postojecih sinonima sheme,
- tehnicka mapa zavisnosti prema ciljnim objektima,
- navigacija prema SQL source fajlovima,
- pocetna tacka za developera, AI agenta i RAG pretragu.

Katalog opisuje koji sinonimi postoje, na koji objekat pokazuju i gdje se
nalazi njihova definicija. Ne sadrzi pojedinacne opise poslovne uloge niti
listu mjesta upotrebe za svaki sinonim.

Ne kreirati prazan `synonyms.md` samo radi forme ako shema nema sinonime.

---

## Izvor istine

Autoritativni izvor za trenutne definicije sinonima je:

`@01-database/01-synonyms/`

DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.
U katalog ukljuciti samo objekte potvrdene sheme, cak i kada folder sadrzi
objekte vise vlasnika. Nekvalifikovan DDL zahtijeva potvrdu konteksta sheme.

Pri odredjivanju trenutnog inventara:

- analizirati trenutno stanje SQL source fajlova (ukljucujuci `R__*.sql` ako se koristi Flyway) u `01-synonyms/` folderu,
- naziv sinonima i ciljni objekat potvrditi iz stvarnog `CREATE SYNONYM` ili
  `CREATE OR REPLACE SYNONYM` iskaza, a ne samo iz naziva fajla,
- jedan source fajl moze definisati vise sinonima; svaki se evidentira posebno,
- samo postojanje SQL fajla nije dovoljno ako njegov sadrzaj ne potvrdjuje
  konkretnu definiciju sinonima,
- V skripte, stari `DROP SYNONYM` iskazi i Flyway istorija ne koriste se za
  utvrdjivanje trenutnog inventara,
- public synonym-i i grantovi nisu dio ovog kataloga; provjeravaju se odvojeno
  u `@01-database/08-grants/`.

Ako se stanje repozitorija i poznato runtime stanje baze razlikuju, razliku
evidentirati u sekciji `## Napomena`.

Vidi i `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md` -> "Dokazivost i oznacavanje inferencije".

---

## Pravilo kompletnosti kataloga

`synonyms.md` mora sadrzavati svaki trenutno postojeci sinonim sheme.

- jedan sinonim ima tacno jedan red u katalogu,
- svaki red mora odgovarati sinonimu potvrdjenom u trenutnom source-u,
- svaki ciljni objekat se navodi onako kako je definisan u DDL-u,
- svaki sinonim ima jedan detaljni red: ili u `## Kriticni API sinonimi` ili
  u `## Ostali sinonimi`,
- zbir iz `## Grupe zavisnosti` mora odgovarati broju detaljnih redova,
- uklonjeni sinonim se uklanja iz kataloga nakon potvrde trenutnog source-a,
- wildcard zapis ne moze zamijeniti pojedinacni spisak sinonima.

---

## Frontmatter

| Polje | Pravilo |
|---|---|
| `id` | `<SCHEMA>_SYNONYMS`, sa nazivom sheme velikim slovima |
| `type` | `schema_doc` |
| `schema` | Tacan naziv Oracle sheme velikim slovima |
| `tags` | Najmanje naziv sheme malim slovima, `synonyms` i `index` |
| `last_review` | Datum posljednje sadrzajne provjere |

---

## Obavezna struktura kataloga

| Sekcija | Status | Sadrzaj |
|---|---|---|
| Naslov dokumenta | Obavezno | Naziv sheme i oznaka kataloga sinonima |
| `## Izvor istine` | Obavezno | Iskljucivo putanja do odgovarajuceg `01-synonyms/` foldera |
| `## Kako koristiti katalog` | Obavezno | Kratko uputstvo za provjeru source-a i mjesta upotrebe |
| `## Konvencije i opsta pravila` | Obavezno | Pravila za lokalne sinonime, ciljne objekte i javnu izlozenost |
| `## Grupe zavisnosti` | Obavezno | Broj svih sinonima po ciljnoj vlasnickoj shemi |
| `## Kriticni API sinonimi` | Obavezno | Cross-schema sinonimi prema API i interface paketima drugih shema ili potvrda da ih nema |
| `## Ostali sinonimi` | Obavezno ako postoje | Svi preostali sinonimi, grupisani po ciljnoj shemi |
| `## Napomena` | Obavezno | Otvoreni problemi, greske i neusaglasenosti ili potvrda da nisu evidentirani |
| `## Odrzavanje` | Obavezno | Pravila dodavanja, izmjene, uklanjanja i provjere |

---

## Sadrzaj sekcija

### `## Kako koristiti katalog`

Kratko navesti da katalog prikazuje trenutne sinonime i njihove ciljne
objekte, da se SQL source provjerava za detalje definicije i da se konkretna
mjesta upotrebe utvrdjuju pretragom repozitorija samo kada su potrebna.

### `## Konvencije i opsta pravila`

Sekcija jednom navodi:

- lokalni sinonim predstavlja tehnicku vezu prema ciljnom objektu, ali sam po
  sebi ne dokazuje aktivnu runtime upotrebu,
- sve sinonime brojati prema vlasnickoj shemi ciljnog objekta,
- kriticne API sinonime odvojiti od ostalih sinonima bez dupliciranja reda,
- ciljni objekat se zapisuje u DDL obliku, po pravilu
  `<VLASNICKA_SCHEMA>.<OBJECT_NAME>`,
- remote ili nepotpuno kvalifikovani ciljevi vode se u grupi `Ostali ciljevi`
  i objasnjavaju u sekciji `## Napomena` kada vlasnik nije potvrdjen,
- public synonym-i i grantovi provjeravaju se odvojeno u `08-grants/` i ne
  mijesaju se sa lokalnim sinonimima ovog kataloga.

### `## Grupe zavisnosti`

Sekcija daje sazet broj svih sinonima po ciljnoj vlasnickoj shemi:

| Kolona | Sadrzaj |
|---|---|
| `Ciljna shema` | Vlasnicka shema ciljnih objekata |
| `Broj sinonima` | Broj svih sinonima koji pokazuju na tu shemu |

Zbir mora obuhvatiti kriticne API i ostale sinonime. Ako vlasnicka shema nije
potvrdjena, koristiti `Ostali/nepotvrdjeni ciljevi` i objasniti problem u
`## Napomena`.

### `## Kriticni API sinonimi`

Sekcija sadrzi cross-schema sinonime koji pokazuju na API ili interface pakete
drugih shema. U ovu grupu ulaze sinonimi ciji DDL-potvrdjeni lokalni ili ciljni
naziv koristi obrazac `*_API`, `*_API_PKG` ili `*_INTERFACE_PKG`.

Naziv source fajla sam po sebi nije dokaz. Ako API status nije moguce
potvrditi iz DDL-a i ciljnog objekta, sinonim se vodi u `## Ostali sinonimi`,
a nejasnoca se navodi u `## Napomena`.

Tabela koristi tacno sljedece kolone:

| Kolona | Sadrzaj |
|---|---|
| `Sinonim` | Tacan naziv lokalnog sinonima |
| `Ciljni objekat` | Cilj iz stvarnog DDL iskaza |
| `Izvor` | Direktna putanja do SQL fajla koji definise sinonim |

Ako nema kriticnih API sinonima, sekcija umjesto tabele sadrzi tacno:

`Nema evidentiranih kriticnih API sinonima.`

### `## Ostali sinonimi`

Sekcija sadrzi sve sinonime koji nisu navedeni u `## Kriticni API sinonimi`.
Grupisati ih po ciljnoj vlasnickoj shemi kao podsekcije nivoa `###` i
koristiti iste kolone: `Sinonim`, `Ciljni objekat` i `Izvor`.

Isti sinonim ne smije biti naveden u obje detaljne sekcije. Ne dodavati kolone
za pojedinacnu poslovnu ulogu, mjesto upotrebe ili grupu.

### `## Napomena`

Sekcija evidentira otvorene probleme, greske i neusaglasenosti kataloga, na
primjer nepotpun inventar, neslaganje naziva ili cilja sa DDL-om, nepotvrdjenu
vlasnicku shemu, netacnu source putanju, neuskladjen broj u grupi zavisnosti,
nejasnu API klasifikaciju ili razliku izmedju repozitorija i poznatog runtime
stanja.

Svaka napomena kratko opisuje problem i, kada je moguce, navodi `@` putanju
do izvora. Sekcija nije changelog.

Ako nema poznatih problema, sekcija sadrzi tacno:

`Nema evidentiranih problema, gresaka ili neusaglasenosti.`

### `## Odrzavanje`

- novi sinonim dodati odmah nakon dodavanja u trenutni source,
- promjenu naziva, ciljnog objekta, grupe ili source putanje azurirati u
  postojecem redu,
- nakon svake promjene azurirati broj u `## Grupe zavisnosti`,
- uklonjeni sinonim ukloniti nakon potvrde trenutnog source-a,
- otkriveni ili rijeseni problem azurirati u sekciji `## Napomena`,
- prije brisanja ili preusmjeravanja sinonima pretraziti reference u kodu,
- `last_review` azurirati nakon stvarne sadrzajne provjere.

---

## Source putanja

Svaki sinonim mora imati direktnu `@01-database/` putanju do SQL fajla u
kojem je definisan. Ne koristiti relativnu putanju, folder, wildcard ili
istorijsku skriptu kao izvor pojedinacnog sinonima.

---

## Minimalni kriterij kvaliteta

`synonyms.md` je uskladjen kada:

- sadrzi sve trenutno postojece sinonime i nijedan uklonjeni sinonim,
- svaki sinonim je naveden tacno jednom i ima DDL-potvrdjen ciljni objekat,
- svaki red ima direktnu i tacnu source putanju,
- tabele koriste samo kolone `Sinonim`, `Ciljni objekat` i `Izvor`,
- zbir brojeva u `## Grupe zavisnosti` odgovara detaljnom inventaru,
- svaki sinonim je naveden ili kao kriticni API sinonim ili kao ostali
  sinonim, nikad u obje sekcije,
- opsta pravila su navedena jednom,
- sekcija `## Napomena` navodi probleme ili potvrduje da nisu evidentirani,
- struktura prati template i `last_review` je azuran.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Postojanje SQL fajla se izjednacava sa postojanjem sinonima | Naziv i cilj potvrditi iz stvarnog DDL iskaza |
| Provjera inventara kroz V/DROP istoriju | Koristiti trenutne definicije u `01-synonyms/` |
| Katalog sadrzi samo grupe ili wildcard obrasce | Svaki sinonim ima zaseban red |
| Sinonim se navodi kao dokaz aktivne upotrebe | Konkretna mjesta upotrebe utvrditi pretragom repozitorija |
| Lokalni i public synonym-i su pomijesani | Public synonym-e i grantove provjeravati odvojeno |
| Dodaju se opisne kolone po sinonimu | Koristiti samo `Sinonim`, `Ciljni objekat` i `Izvor` |
| Broj po ciljnoj shemi ne odgovara detaljnim redovima | Uskladiti `Grupe zavisnosti` sa potpunim inventarom |
| Kriticni API sinonim je dupliciran medju ostalim sinonimima | Svaki sinonim navesti u samo jednoj detaljnoj sekciji |
| Poznat problem nije evidentiran | Navesti ga u sekciji `Napomena` |
| Sekcija `Napomena` se koristi kao changelog | Navesti samo trenutno otvorene probleme |
| Source vodi do foldera ili wildcard-a | Navesti konkretan SQL fajl |

---

## Glavno pravilo

> `synonyms.md` govori koji sinonimi postoje, na sta pokazuju i gdje su
> definisani.

> SQL source govori kako je sinonim deklarisan.
