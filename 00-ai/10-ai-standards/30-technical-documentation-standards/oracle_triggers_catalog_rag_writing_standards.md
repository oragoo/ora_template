---
project: "{{PROJECT_SLUG}}"
id: ORACLE_TRIGGERS_CATALOG_RAG_WRITING_STANDARDS
type: standard
tags: [standard, rag, oracle, triggers, catalog, lifecycle, audit, dokumentacija]
last_review: 2026-10-05
---

# RAG standard za katalog Oracle triggera (`triggers.md`)

Ovaj dokument definise pravila specificna za kreiranje i odrzavanje
`triggers.md` kataloga jedne Oracle sheme.

Opsta pravila za jezik, putanje, dokazivost, inferencije, frontmatter ID,
`last_review`, integraciju izmjena i separatore sekcija definisana su u:

`@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`

Template za pisanje konkretnog kataloga nalazi se u:

`@00-ai/10-ai-standards/30-technical-documentation-standards/templates/triggers_catalog_template.md`

Ako postoji konflikt, primjenjuje se hijerarhija definisana u opstem RAG
standardu.

---

## Svrha i opseg

Svaka Oracle shema koja sadrzi najmanje jedan trigger treba imati jedan
`triggers.md` na lokaciji:

`@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/triggers.md`

`triggers.md` je:

- kompletan inventar trenutno postojecih triggera sheme,
- pregled ciljnih tabela ili pogleda i DML dogadjaja,
- navigacija prema trigger source fajlovima,
- upozorenje na implicitnu logiku koju treba provjeriti prije izmjene tabele.

Katalog ne prepisuje PL/SQL tijelo niti pojedinacni efekat svakog triggera.
Detaljna implementacija ostaje u source-u.

Ne kreirati prazan `triggers.md` samo radi forme ako shema nema triggere.

---

## Izvor istine

Autoritativni izvor za trenutne definicije triggera je:

`@01-database/07-triggers/`

DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.
U katalog ukljuciti samo objekte potvrdene sheme, cak i kada folder sadrzi
objekte vise vlasnika. Nekvalifikovan DDL zahtijeva potvrdu konteksta sheme.

Pri odredjivanju trenutnog inventara:

- analizirati trenutne `.trg` ili ekvivalentne source fajlove,
- naziv triggera, ciljni objekat, timing i DML dogadjaj potvrditi iz stvarnog
  `CREATE TRIGGER` ili `CREATE OR REPLACE TRIGGER` iskaza,
- jedan source fajl moze definisati vise triggera; svaki se evidentira posebno,
- samo postojanje source fajla nije dovoljno ako njegov sadrzaj ne potvrdjuje
  konkretnu definiciju triggera,
- V skripte, stari `DROP TABLE` ili `DROP TRIGGER` iskazi i Flyway istorija
  ne koriste se za utvrdjivanje trenutnog inventara.
- naziv triggera se ne koristi kao dokaz ciljnog objekta ili DML dogadjaja; ako
  se naziv i DDL razlikuju, stvarni DDL podaci ulaze u katalog, a razlika se
  evidentira u sekciji `## Napomena`.

Vidi i `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md` -> "Dokazivost i oznacavanje inferencije".

---

## Pravilo kompletnosti kataloga

`triggers.md` mora sadrzavati svaki trenutno postojeci trigger sheme.

- jedan trigger ima tacno jedan red u katalogu,
- svaki red odgovara triggeru potvrdjenom u trenutnom source-u,
- ciljni objekat i dogadjaj navode se iz DDL-a,
- uklonjeni trigger uklanja se nakon potvrde trenutnog source-a,
- wildcard zapis ne moze zamijeniti pojedinacni spisak triggera.

---

## Frontmatter

| Polje | Pravilo |
|---|---|
| `id` | `<SCHEMA>_TRIGGERS`, sa nazivom sheme velikim slovima |
| `type` | `schema_doc` |
| `schema` | Tacan naziv Oracle sheme velikim slovima |
| `tags` | Najmanje naziv sheme malim slovima, `triggers` i `index` |
| `last_review` | Datum posljednje sadrzajne provjere |

---

## Obavezna struktura kataloga

| Sekcija | Status | Sadrzaj |
|---|---|---|
| Naslov dokumenta | Obavezno | Naziv sheme i oznaka kataloga triggera |
| `## Izvor istine` | Obavezno | Iskljucivo putanja do odgovarajuceg `07-triggers/` foldera |
| `## Kako koristiti katalog` | Obavezno | Uputstvo za provjeru triggera prije izmjene tabele |
| `## Konvencije i opsta pravila` | Obavezno | Pravila za implicitnu DML logiku, ciljni objekat, dogadjaj i grupisanje |
| `## Audit, PK i lifecycle triggeri` | Obavezno ako postoje | Triggeri koji generisu kljuceve, audit ili lifecycle vrijednosti |
| `## Instead-of triggeri` | Obavezno ako postoje | Triggeri sa DDL-potvrdjenim `INSTEAD OF` timingom |
| `## Posebni slucajevi` | Obavezno ako postoje | History, validacija, `DELETE`, cross-schema i ostali posebni triggeri |
| `## Napomena` | Obavezno | Otvoreni problemi, greske i neusaglasenosti ili potvrda da nisu evidentirani |
| `## Odrzavanje` | Obavezno | Pravila dodavanja, izmjene, uklanjanja i provjere |

---

## Sadrzaj sekcija

### `## Kako koristiti katalog`

Kratko navesti da trigger sadrzi implicitnu logiku, da se prije izmjene tabele
provjeravaju svi triggeri na toj tabeli i da se implementacioni detalji citaju
iz source-a.

### `## Konvencije i opsta pravila`

Sekcija jednom navodi:

- naziv triggera nije dokaz ciljnog objekta, timinga ili DML dogadjaja,
- ciljni objekat, timing i dogadjaj citaju se iz stvarnog DDL iskaza,
- triggeri se grupisu u `Audit, PK i lifecycle triggeri`, `Instead-of
  triggeri` ili `Posebni slucajevi`,
- pojedinacni efekat i PL/SQL tijelo ne prepisuju se u katalog,
- trigger treba provjeriti prije izmjene strukture ili DML toka ciljne tabele.

### Grupe triggera

Katalog koristi sljedece glavne sekcije nivoa `##`:

- `## Audit, PK i lifecycle triggeri` za triggere koji generisu kljuceve,
  popunjavaju audit podatke ili upravljaju lifecycle vrijednostima,
- `## Instead-of triggeri` za triggere sa DDL-potvrdjenim `INSTEAD OF`
  timingom,
- `## Posebni slucajevi` za history, validaciju, `DELETE`, cross-schema
  pozive, neobicne triggere i sve sto ne pripada prethodnim grupama.

Kada trigger moze pripadati u vise grupa, `Instead-of triggeri` ima prednost,
zatim `Audit, PK i lifecycle triggeri`, a `Posebni slucajevi` je zavrsna
grupa. Koristiti samo neprazne grupe. Svaka tabela koristi tacno sljedece
kolone:

| Kolona | Sadrzaj |
|---|---|
| `Trigger` | Tacan Oracle naziv triggera |
| `Ciljni objekat` | Ciljna tabela ili pogled iz DDL iskaza |
| `Dogadjaj` | Potvrdjeni timing i DML dogadjaj |
| `Izvor` | Direktna putanja do source fajla koji definise trigger |

Ne dodavati kolone za pojedinacni efekat, opis ili posebnu napomenu po
triggeru.

### `## Napomena`

Sekcija evidentira otvorene probleme, greske i neusaglasenosti kataloga, na
primjer nepotpun inventar, neslaganje naziva sa stvarnom tabelom ili
dogadjajem, netacnu source putanju, nejasno grupisanje, neobicnu vrstu triggera
koju treba dodatno provjeriti ili razliku izmedju repozitorija i poznatog
runtime stanja.

Svaka napomena kratko opisuje problem i, kada je moguce, navodi `@` putanju
do izvora. Sekcija nije changelog i ne sluzi za redovan opis efekta triggera.

Ako nema poznatih problema, sekcija sadrzi tacno:

`Nema evidentiranih problema, gresaka ili neusaglasenosti.`

### `## Odrzavanje`

- novi trigger dodati odmah nakon dodavanja u trenutni source,
- promjenu naziva, ciljnog objekta, dogadjaja, grupe ili source putanje azurirati u
  postojecem redu,
- uklonjeni trigger ukloniti nakon potvrde trenutnog source-a,
- otkriveni ili rijeseni problem azurirati u sekciji `## Napomena`,
- prije izmjene tabele provjeriti sve njene triggere,
- `last_review` azurirati nakon stvarne sadrzajne provjere.

---

## Source putanja

Svaki trigger mora imati direktnu `@01-database/` putanju do source fajla u
kojem je definisan. Ne koristiti relativnu putanju, folder, wildcard ili
istorijsku skriptu kao izvor pojedinacnog triggera.

---

## Minimalni kriterij kvaliteta

`triggers.md` je uskladjen kada:

- sadrzi sve trenutno postojece triggere i nijedan uklonjeni trigger,
- svaki trigger je naveden tacno jednom,
- naziv, ciljni objekat i dogadjaj su potvrdjeni iz DDL-a,
- svaki red ima direktnu i tacnu source putanju,
- tabele koriste samo `Trigger`, `Ciljni objekat`, `Dogadjaj` i `Izvor`,
- triggeri su grupisani prema tri standardne grupe i svaki je naveden samo
  jednom,
- opsta pravila su navedena jednom,
- sekcija `## Napomena` navodi probleme ili potvrduje da nisu evidentirani,
- struktura prati template i `last_review` je azuran.

---

## Ceste greske

| Greska | Ispravno |
|---|---|
| Postojanje source fajla se izjednacava sa postojanjem triggera | Definiciju potvrditi iz stvarnog DDL iskaza |
| Provjera inventara kroz V/DROP istoriju | Koristiti trenutne definicije u `07-triggers/` |
| Ciljni objekat ili dogadjaj izvedeni su iz naziva triggera | Citati ih iz stvarnog `CREATE TRIGGER` iskaza |
| Katalog sadrzi samo grupe ili wildcard obrasce | Svaki trigger ima zaseban red |
| Efekat ili PL/SQL tijelo prepisani su u katalog | Detalje ostaviti u source-u |
| Dodaju se opisne kolone po triggeru | Koristiti samo `Trigger`, `Ciljni objekat`, `Dogadjaj` i `Izvor` |
| Poznat problem nije evidentiran | Navesti ga u sekciji `Napomena` |
| Sekcija `Napomena` se koristi kao changelog | Navesti samo trenutno otvorene probleme |
| Source vodi do foldera ili wildcard-a | Navesti konkretan source fajl |

---

## Glavno pravilo

> `triggers.md` govori koji triggeri postoje, nad kojim objektom i za koji
> dogadjaj se izvrsavaju te gdje su definisani.

> Trigger source govori sta se izvrsava.
