---
project: "{{PROJECT_SLUG}}"
id: FLYWAY_CONVENTIONS
type: standards
tags: [standards, flyway, migrations, r-scripts, v-scripts]
last_review: 2026-10-06
---

# Flyway konvencije

## Svrha

Definise predlozeni format i pravila za Flyway skripte kada projekat koristi
Oracle i Flyway. Pogledi, paketi, procedure i funkcije mogu koristiti R skripte,
a DB fajlovi mogu biti organizovani u `@01-database/` po tipu objekta.

Ako izvori koriste ekstenzije `.spc`, `.bdy`, `.prc` i `.fnc`, deployment mora
ih pripremiti kao `.sql` ili eksplicitno konfigurisati podrzane sufikse. Stvarni
workflow, `FLYWAY_LOCATIONS` i pripremne skripte dokumentovati iz projektne
konfiguracije; ovaj standard ne tvrdi da vec postoje.
Izvor: [Flyway SQL Migration Suffixes](https://documentation.red-gate.com/fd/flyway-sql-migration-suffixes-setting-277579039.html).

Pokretanje `info`, `baseline`, `migrate` i `repair`, kao i parametre
`baseline_version` i `out_of_order`, opisati u deployment dokumentaciji projekta.

---

## R skripte - repeatable, idempotentno izvrsenje
**Koriste se za:** sinonime, poglede, pakete, procedure, funkcije, trigere, tipove, sifarnike

- Format: `R__<naziv_objekta>.<ekstenzija>`; prefiks `R__` ostaje velikim slovom.
- Pogledi: `@01-database/04-view/R__<naziv_pogleda>.sql`, jedan pogled po fajlu;
  naziv pogleda i naziv fajla poslije prefiksa pisu se malim slovima.
- U SQL definiciji pogleda koristiti identifikator bez navodnika, npr.
  `create or replace force view {{DB_SCHEMA}}.lov_entity_v as ...`.
- Ukloniti SQL Developer izvozni blok `DDL for ...` sa vrha objektnog fajla.
  Potpise PL/SQL objekata pisati malim slovima, bez navodnika, npr.
  `create or replace editionable package {{DB_SCHEMA}}.entity_util_pkg as ...`.
- Zaglavlje pogleda nema `EDITIONABLE` niti eksplicitnu listu kolona.
  Pri uklanjanju liste potvrditi da SELECT kolone i aliasi daju ista imena
  kao izvorna lista; dodati alias ako je potreban za ocuvanje imena.
- Generisani SQL*Plus spiskovi sa `@` pozivima nisu zasebne R migracije;
  svaki pogled isporucuje se kroz svoj SQL fajl.
- Za Oracle objektne DDL R skripte obavezno koristi `CREATE OR REPLACE`; zavrsetak sa `/` koristi tamo gdje ga konkretan tip objekta zahtijeva
- PL/SQL fajlovi u `@01-database/05-packages/` koriste nazive malim slovima
  poslije prefiksa `R__` i sljedece ekstenzije:

  | Tip objekta | Format fajla |
  |---|---|
  | Specifikacija paketa | `R__<naziv_paketa>.spc` |
  | Tijelo paketa | `R__<naziv_paketa>.bdy` |
  | Procedura | `R__<naziv_procedure>.prc` |
  | Funkcija | `R__<naziv_funkcije>.fnc` |

  Specifikacija i tijelo imaju isto osnovno ime, npr. `R__account_util_pkg.spc`
  i `R__account_util_pkg.bdy`. Priprema dodaje sufikse `_01_spc` i `_02_bdy`,
  pa generisani SQL fajlovi imaju razlicite opise R migracija, a specifikacija
  prethodi tijelu istog paketa u abecednom redoslijedu.
- R data / sifrarnik skripte ne slijede pravilo `CREATE OR REPLACE`; za njih koristi idempotentan DML obrazac prema sadrzaju skripte
- `SHOW ERRORS;` se **ne dodaje** - fajlovi se kompajluju direktno na bazi, nije SQLPlus skripta
- Flyway izvrsava ponovo svaki put kad se checksum fajla promijeni
- R migracije se izvrsavaju nakon potrebnih V migracija, po abecednom
  redoslijedu opisa. Pripremna skripta dodaje broj foldera opisima R
  migracija, npr. `R__04_lov_company_v.sql`, pa R slijede numerisane foldere.
  Ovo pravilo redoslijeda vazi samo ako ga projektna priprema implementira.
  V migracije i dalje sve prethode R migracijama u jednom pozivu. Izvor:
  [Flyway repeatable migrations](https://documentation.red-gate.com/flyway/flyway-concepts/migrations/repeatable-migrations).
- Nikad ne brisati R skriptu - ako se objekat uklanja, skripta se mijenja

---

## V skripte - versioned, jednokratno izvrsenje
**Koriste se za:** ALTER TABLE, CREATE TABLE, jednokratne podatkovne migracije

- Format: `V<timestamp>__<opis>.sql` (npr. `V202610051214__alter_appointments_status.sql`)
- `timestamp` je obavezan u formatu `YYYYMMDDHH24MI`
- Obavezni dijelovi potpisa su:
  - godina `YYYY`
  - mjesec `MM`
  - dan `DD`
  - sat `HH24`
  - minuta `MI`
- Nije dozvoljeno ostavljati sate i minute kao placeholder `0000` ako stvarni trenutak kreiranja skripte nije bio `00:00`
- Kod odredjivanja zadnje V skripte gleda se cijeli numericki prefiks iza `V` i prije `__`, ne samo datum
- Obavezno: `COMMIT;` na kraju
- **NIKAD se ne mijenjaju nakon commitanja** - Flyway pamti checksum

`repair` uredjuje Flyway istoriju i ne mijenja ova pravila za R/V skripte.
Ne koristiti ga za prikrivanje izmjene vec commitane V migracije ili slucajno
obrisanog fajla. Postupak i razlika izmedju uklanjanja skripte i DB objekta
moraju biti opisani u stvarnoj deployment dokumentaciji projekta.
