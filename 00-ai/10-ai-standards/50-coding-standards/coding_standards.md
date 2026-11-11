---
project: "{{PROJECT_SLUG}}"
id: CODING_STANDARDS
type: standards
tags: [standards, plsql, packages, header, comments, changelog]
last_review: 2026-10-05
---

# PL/SQL Coding Standards

Primjenjuje se na PL/SQL objekte kada budu dodani u `@01-database/`.
Primjeri paketa i istorije izmjena su ilustrativni; ne opisuju postojeci kod.

## Svrha

Ovaj dokument je jedinstveni izvor istine za dvije povezane, ali odvojene teme:

- **Mehanicki format** - gdje ide header, koji je obavezan format, kako se
  vodi `Izmjene` changelog, i kako se isporucuje izmjena procedure/funkcije.
  Ovo vazi za sve PL/SQL objekte (paketi, view-ovi, trigeri, procedure).
- **Sadrzajno/narativno komentarisanje paketa** - kako napisati komentar koji
  je stvarno koristan developeru i buducem AI kontekstu, ne samo formalno
  prisutan: suzdrzan header, par sekcijskih komentara, i inline komentar
  samo tamo gdje je poslovna odluka skrivena u kodu (detalji u sekciji
  "Sadrzajno komentarisanje paketa" ispod).

Koristi ovaj dokument kad god:
- pises novi paket, view, trigger ili proceduru i treba ti header
- dopunjujes legacy paket komentarima bez promjene logike
- pises ili azuriras `Izmjene` liniju nakon izmjene postojeceg paketa
- zelis da provjeris da li je tvoj komentar dovoljno sazet i suzdrzan

---

## Header komentar

### Pozicioniranje

Header se pise **unutar** objekta - nakon `CREATE OR REPLACE PACKAGE ... AS`,
`CREATE OR REPLACE PACKAGE BODY ... AS`, ili ekvivalentnog `AS`/`IS` za view,
trigger ili proceduru - nikad prije.

**Ispravno:**
```sql
create or replace package naziv_pkg as

  -- =============================================================
  -- Naziv:    NAZIV_PKG
  -- Opis:     ...
  -- Autor:    Ime Prezime
  -- Datum:    YYYY-MM-DD
  -- Izmjene:  YYYY-MM-DD | Autor | Opis izmjene
  -- =============================================================

  -- konstante, funkcije...
end naziv_pkg;
/
```

**Pogresno** (header izvan paketa):
```sql
-- =============================================================
-- Naziv:    NAZIV_PKG   <- NE, ovo je van paketa
-- =============================================================
create or replace package naziv_pkg as
  ...
```

**Zasto:** Header treba da ostane dio Oracle objekta nezavisno od nacina isporuke. Header izvan `CREATE OR REPLACE` je tehnicki
validan SQL komentar, ali konvencija projekta je da header bude dio
definicije objekta - vidljiv u `USER_SOURCE` / `ALL_SOURCE`.

### Obavezni format

```sql
  -- =============================================================
  -- Naziv:    NAZIV_OBJEKTA
  -- Opis:     Kratki opis svrhe objekta
  --           Druga linija ako treba objasniti tok ili konzumenta (opciono)
  -- Autor:    Ime Prezime
  -- Datum:    YYYY-MM-DD
  -- Izmjene:  YYYY-MM-DD | Ime Prezime | kratak opis (<JIRA_KEY> ako je bitno)
  -- =============================================================
```

- Svaki paket (i `spec` i `body`) ima tacno jednu header sekciju u ovom
  formatu; `spec` i `body` imaju odvojene, nezavisne `Izmjene` liste (vidi
  "Komentarisanje izmjena" ispod).
- `Autor` je uvijek stvarno ime osobe koja pravi izmjenu, nikad naziv AI
  alata ili asistenta. Moze biti vise imena odvojenih zarezom kad je
  izmjena zajednicki rad (npr. `Marko Markovic, Ana Anic`).
- Ako paket nema poznatog originalnog autora/datuma (legacy kod), koristi
  `Autor: Nepoznato (legacy)` i najstariji datum potvrdjen iz git istorije
  kao `Datum`.

### SHOW ERRORS

`SHOW ERRORS;` je SQLPlus komanda. **Ne dodavati** u `.pks`/`.pkb`/`.sql`
fajlove koji se kompajluju direktno na bazi (VS Code Oracle extension ili
run-sql).

`SHOW ERRORS;` smije biti samo u Flyway R skriptama koje se izvrsavaju kroz
SQLPlus runner - i to samo ako je Flyway konfigurisan sa SQLPlus nacinom
izvrsavanja.

---

## Komentarisanje izmjena (`Izmjene` changelog)

- `Izmjene` je living changelog - svaka izmjena dodaje NOVU liniju
  (`YYYY-MM-DD | Ime Prezime | kratak opis`), postojece linije se nikad ne
  brisu niti prepisuju.
- `Autor` u `Izmjene` liniji je uvijek stvarno ime osobe koja je napravila
  izmjenu, nikad naziv AI alata ili asistenta.
- U opisu se po potrebi navodi jedan ili vise <JIRA_KEY> zadataka pogodjenih
  tom izmjenom, npr. `Dodat is_appointment_status_valid (<JIRA_KEY>)` ili
  `Dodate 2 resolver funkcije (<JIRA_KEY>, <JIRA_KEY>)` kad vise zadataka pokriva
  istu liniju.
- `spec` biljezi promjenu interfejsa (nova/izmijenjena funkcija, promijenjen
  potpis), `body` biljezi implementacionu izmjenu (nova privatna procedura,
  promijenjena logika) - odvojene liste za odvojene fajlove.
- Opis mora biti sazet i jednostavan, sa sto manje rijeci - orijentaciono
  najvise 10, izuzev kad se opisuje veoma kompleksna izmjena koja stvarno
  zahtijeva vise objasnjenja; tada linija smije biti duza/prelomljena (vidi
  primjer ispod).
- Duzi opis se prelama u nastavak reda, poravnat ispod prve kolone opisa
  (ne ispod datuma ili autora) - vidi primjer.
- Komentar ne smije biti duzi od koda ili izmjene koju opisuje.
- Kratak inline komentar (`-- <JIRA_KEY>: ...`, orijentaciono do 10 rijeci) uz
  konkretnu izmijenjenu funkciju/proceduru je dozvoljen kao pokazivac na
  mjestu izmjene, ali ne smije ponavljati puno objasnjenje - to ostaje u
  header `Izmjene` listi, ne razbacano po tijelu paketa.
- Ne ponavljati ono sto je ocigledno iz naziva ili samog koda.

Primjer (body header sa akumuliranim `Izmjene` unosima i prelomljenim opisom):

```sql
create or replace package body appointment_pkg as

  -- =====================================================
  -- Naziv:    APPOINTMENT_PKG (body)
  -- Opis:     Ilustrativni paket za zakazivanje i promjenu termina.
  -- Autor:    Nepoznato (legacy)
  -- Datum:    2023-09-18
  -- Izmjene:  2026-08-24 | Ime Prezime | Dodat is_appointment_status_valid (<JIRA_KEY>)
  --           2026-08-24 | Ime Prezime | Dodata 4 resolver funkcije (<JIRA_KEY>)
  --           2026-09-03 | Ime Prezime | Dodat is_slot_available (<JIRA_KEY>)
  -- =====================================================
```

---

## Izmjena procedure/funkcije se isporucuje cijela, nikad kao fragment

Korekcija procedure ili funkcije znaci ispisati **cijelu rutinu** - potpis,
deklaracije, tijelo, exception blok, `end <naziv>;` - spremnu da se prekopira
preko stare. Nikad "dodaj ove dvije linije poslije `apex_json.write(...)`" i
nikad diff.

Ovo pravilo vazi za isporuku rutine za rucnu primjenu. Pri direktnoj izmjeni
fajla u repozitorijumu urediti stvarni izvor, a Git diff koristiti za pregled.

Isto vazi i za specifikaciju paketa: kad se potpis mijenja, dati cijelu
deklaraciju kako treba da glasi, ne samo dodati parametar.

---

## Sadrzajno komentarisanje paketa

### Obavezna pravila (sazetak)

1. Header ide unutar `CREATE OR REPLACE PACKAGE ... AS` i `PACKAGE BODY ... AS` (vidi "Header komentar" iznad).
2. Opis paketa mora objasniti domenu i tok podataka, ne samo "paket sa procedurama".
3. Sekcijski komentari se dodaju iznad grupa srodnih procedura kada paket ima vise cjelina.
4. Inline komentari se pisu samo za WHY: integracioni razlog, TX granicu, fallback lookup, status flow, legacy ogranicenje.
5. Ne komentarisati self-dokumentujuci kod (npr. getter funkcije koje vracaju konstantu), svaki `select`/`if`/`update`/assignment, niti ponavljati imena parametara kao opis.
6. Svi komentari (header opis, sekcijski, inline) treba da budu sazeti - sto manje rijeci, orijentaciono do 10, izuzev kad se opisuje veoma kompleksna stvar koja stvarno zahtijeva vise objasnjenja.

### Sta znaci pisati suzdrzano

Preporuceni stil komentarisanja je namjerno suzdrzan:
- postoji jasan header u spec-u i body-ju
- komentar objasnjava svrhu paketa i integracioni tok
- nema komentarisanja trivijalnih linija
- komentari sluze za navigaciju kroz paket, ne kao prevod svake naredbe

To znaci da treba preferirati:
- jedan dobar header
- nekoliko sekcijskih komentara
- kratke inline komentare tamo gdje je poslovna odluka skrivena u kodu

Ne treba raditi:
- komentar na svaki `select`, `if`, `update` ili assignment
- ponavljanje imena parametara kao opis
- prepisivanje ociglednog PL/SQL toka u recenice

### Preporuceni obrazac za package spec

U spec-u komentar treba da odgovori na pitanje: "koje su javne cjeline paketa?"

Preporuceni raspored:
1. header
2. eventualna kratka napomena o public API obrascu
3. grupni komentari iznad blokova javnih procedura

Primjer grupisanja:
- wrapperi za pull prema eksternom sistemu
- opsti sifarnici
- pacijenti i ambulante
- termini i rasporedi
- pregledi i usluge

### Preporuceni obrazac za package body

U body-ju komentar treba da odgovori na pitanje: "kako je paket organizovan i zasto bas tako?"

Preporuceni raspored:
1. isti header kao u spec-u
2. jedan kratki komentar o internom obrascu paketa
3. sekcijski komentari prije vecih funkcionalnih cjelina
4. rijetki inline komentari samo gdje bez komentara motiv nije jasan

Dobri kandidati za inline komentar:
- zasto je `pragma autonomous_transaction` potrebna
- zasto se staging redovi prvo `bulk collect` u kolekciju
- zasto odredjeni downstream poziv mora biti "zadnji"
- zasto je neki branch privremeno iskljucen ili ostavljen kao legacy placeholder

### Kompatibilnost postojecih interfejsa

Ako projekat kasnije preuzme legacy kod, zadrzati potvrdene javne potpise i
overload obrasce dok zadatak ne predvidi njihovu promjenu. Ogranicenja
dokumentovati iz konkretnog izvora; ne pretpostavljati postojece legacy pakete.

### Jezik komentara

Univerzalna pravila (srpski jezik latinicom, ASCII, bez dijakritike, bez
ukrasnih Unicode znakova) definisana su u
`@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`
-> "Jezik" - vaze i za komentare u kodu, ne samo za RAG dokumentaciju.

Dodatna pravila specificna za PL/SQL komentare:
- Preferirani stil u ovom repou je lokalni B/H/S opis kad god je to dovoljno jasno
- Tehnicki termini i nazivi Oracle objekata ostaju iz koda (`bulk collect`, `autonomous_transaction`, `%type`) - ne prevoditi ih
- Komentar treba da bude: kratak, konzistentan, razumljiv timu koji odrzava ove pakete

Primjeri dobrih srpskih izraza: `sifrarnik`, `sinhronizacija`, `staging`, `obrada reda`

---

## Checklist prije zavrsetka komentarisanja

Prije nego sto zavrsis komentarisanje paketa provjeri:

- da li spec i body imaju isti smislen header
- da li komentar objasnjava integracioni tok
- da li su procedure grupisane po domeni
- da li si komentarisao samo neocigledne odluke
- da li si izbjegao "noise" komentare koji samo prepricavaju kod
- da li je nova izmjena dodata kao NOVA linija u `Izmjene`, bez brisanja postojecih
