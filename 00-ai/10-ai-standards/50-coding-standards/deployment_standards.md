---
project: "{{PROJECT_SLUG}}"
id: DEPLOYMENT_STANDARDS
type: standards
tags: [standards, deployment, plsql, safety]
last_review: 2026-10-06
---

# Deployment standard - Oracle objekti

Ovaj standard se primjenjuje kada projekat isporucuje Oracle objekte kroz
Flyway repeatable migracije. Stvarni workflow, okruzenje, runner, konekciju,
putanje i postupak potvrditi iz projektne konfiguracije prije izvrsavanja.

Poslije deployment koraka preporucuje se rekompajlirati ciljne sheme i
provjeriti nevalidne objekte. Konkretne skripte i kriterij neuspjeha moraju
biti implementirani i dokumentovani u projektu; template ih ne pretpostavlja.

Standard vazi za R objekte koji se zamjenjuju kroz `CREATE OR REPLACE`,
ukljucujuci postojece poglede u `@01-database/04-view/` i PL/SQL izvore u
`@01-database/05-packages/`.
Flyway validacija poredi migracije sa njihovom istorijom i checksumima;
iz toga slijedi da ne zamjenjuje poredjenje sa definicijom objekta koja je
mogla biti rucno izmijenjena u bazi. Izvor:
[Flyway validate](https://documentation.red-gate.com/flyway/reference/commands/validate).

## Pravilo sigurnog deplojmenta

> **Prije zamjene R objekta provjeri razlike izmedju lokalnog fajla i definicije u bazi.**

R skripte za poglede (`.sql`) i pakete (`.spc` / `.bdy`)
zamjenjuju definiciju Oracle objekta kroz `CREATE OR REPLACE`. Ako je neko
drugi izmijenio objekat direktno na bazi (hotfix, rucna izmjena), lokalni fajl
moze pregaziti tu izmjenu. Pravilo poredjenja vazi i za dokumentacijske izmjene
R fajla, jer promjena checksuma moze izazvati njegovo ponovno izvrsavanje.

---

## Postupak provjere prije deplojmenta

### 1. Dohvati trenutni source iz baze

```sql
select line, text
  from user_source
 where name = 'IME_PAKETA'
   and type = 'PACKAGE BODY'   -- ili 'PACKAGE' za spec
 order by line;
```

Za objekte u drugoj shemi koristiti `all_source` s dodatnim filtrom `owner = 'SHEMA'`.

Za pogled koristiti DDL iz `DBMS_METADATA`, uz odgovarajuca prava. Primjer
za postojeci pogled:

```sql
select dbms_metadata.get_ddl('VIEW', 'LOV_ENTITY_V', '{{DB_SCHEMA}}')
  from dual;
```

Porediti sa `@01-database/04-view/R__lov_entity_v.sql`. Pri poredjenju
razlikovati formatiranje izvoza od promjena SQL definicije. Ako objekat jos
ne postoji, provjeriti njegove zavisnosti i evidentirati da se kreira prvi put.

### 2. Poredi s lokalnim fajlom

Vizuelno ili diff alatom uporedi rezultat upita s odgovarajucim lokalnim
fajlom pogleda, package spec-a ili body-ja.

### 3. Donesi odluku

| Situacija | Akcija |
|---|---|
| Razlike su samo u planiranoj izmjeni koja je u obimu zadatka | Nastavi nakon provjera relevantnih za izmjenu |
| Razlike ukljucuju tudje ili neobjasnjene izmjene definicije ili logike | Sinhronizuj lokalni fajl s bazom i zadrzi potrebne izmjene prije isporuke |
| Lokalni fajl i baza su identicni | Zamjena definicije nije potrebna; istoriju provjeri kroz `info` |

---

## Kada je posebno vazno

- Paketi koji se razvijaju **paralelno** (vise developera ili hotfixovi direktno na bazi)
- Paketi koji su oznaceni kao `M` (maintained) u git historiji bez Flyway migracijske skripte
- Svaki put kad radis samo **dokumentacijske izmjene** (dodavanje headera, komentara) - u tom slucaju jedino prihvatljive razlike su upravo te izmjene

---

## Napomene

- Ovaj standard vazi za R skripte (repeatable) - V skripte (versioned) se ne mijenjaju nakon commitanja i nemaju ovaj problem
- `USER_SOURCE` cuva source onako kako je kompajliran - bez trailing `/` i bez `SHOW ERRORS`
- Ako lokalni fajl **nema** promjena logike ali baza ima noviju verziju: kopiraj logiku iz baze u lokalni fajl, pa dodaj svoje izmjene, pa deplojuj
