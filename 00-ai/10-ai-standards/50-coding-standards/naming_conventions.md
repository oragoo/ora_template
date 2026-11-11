---
project: "{{PROJECT_SLUG}}"
id: CORE_DB_OBJECT_NAMING
type: core_standard
tags: [db_naming, oracle, packages, views, apex, interface, ws, util, controller, synonyms]
last_review: 2026-10-05
---

# Konvencija imenovanja DB objekata (packages i views)

Ovaj dokument definise standardnu konvenciju imenovanja Oracle DB objekata u projektu {{PROJECT_NAME}}, kada se koriste Oracle objekti. Konvencija omogucava da se iz naziva objekta odmah prepozna:
- namjena (controller / core / util / ws / interface),
- scope (page-specific ili shared),
- nacin koriscenja (APEX stranice, eksterne aplikacije, cross-schema integracije, reporting).

## 1) Paketi (PACKAGE)

### 1.1 `pXXXXX_controller_pkg`
**Znacenje:** controller paket vezan iskljucivo za jednu APEX stranicu.
- `XXXXX` je broj APEX stranice (npr. `p00003`, `p00039`).
- Sadrzi orchestraciju i logiku koja je specificna za tu stranicu (akcije, UI tok, validacije, pozivi core paketa).

**Scope:** page-specific.

---

### 1.2 `<schema>_util_pkg` (npr. `appointment_util_pkg`)
**Znacenje:** util paket za konstante i zajednicke pomocne funkcije.
Tipican sadrzaj:
- konstante (statusi, tipovi),
- helper funkcije (npr. current clinic id, appointment status lookup).

**Scope:** shared (kroz modul).

---

### 1.3 `<schema>_ws_pkg` (npr. `appointment_ws_pkg`)
**Znacenje:** web service sloj.
- Izlaze procedure/funkcije namijenjene za web servis (REST/SOAP zavisno od implementacije).

**Scope:** shared, integracioni sloj.

---

### 1.4 `<appShort>_pXXX_controller_pkg`
**Znacenje:** controller paket za eksterne aplikacije (nije APEX page controller).
- `<appShort>` je skraceni naziv aplikacije (npr. web, mobile, prema dogovoru).
- `pXXX` je identifikator kontrolera (pattern isti kao kod page controller paketa).

**Scope:** page/controller-specific za eksternu aplikaciju.

---

### 1.5 `<schema>_<name>_interface_pkg`
**Znacenje:** interface paket - javni ugovor funkcionalnosti seme prema drugim semama.
- Druga sema konzumira funkcionalnost iskljucivo kroz interface paket (ne direktno core pakete).

**Scope:** cross-schema contract.

#### Pravilo koriscenja preko sinonima
- U drugoj semi se pravi sinonim koji mapira ovaj interface paket.
- Pozivi se rade preko sinonima u formi `*_api.<procedura>`:
  - `<owner_schema>_api.<procedura>(...)` (stvarni naziv potvrditi iz DDL-a)

#### Izuzeci
- Izuzetke za zajednicke servise dokumentovati tek kada postoje i kada su
  potvrdjeni iz projekta.

---

### 1.6 Core paketi: `<name>_pkg` i `<name>_util_pkg`
**Znacenje:** core funkcionalnosti i pomocne funkcije za taj dio modula.
- Core paketi sadrze biznis logiku koja se poziva iz controller-a, interface paketa i ws sloja.

**Scope:** shared (kroz modul).

## 2) Pogledi (VIEW)

Naziv pogleda u SQL izvornom kodu pise se malim slovima, bez navodnika
(npr. `{{DB_SCHEMA}}.lov_entity_v`). Fajl se zove `R__<naziv_pogleda>.sql` i cuva se
u `@01-database/04-view/`; `R__` je Flyway prefiks i zadrzava veliko slovo.

### 2.1 `pXXXXX_<view_name>`
**Znacenje:** page-specific view za APEX stranicu `XXXXX`.
- Koristi se tipicno za report/IG/region na toj stranici.

**Scope:** page-specific.

---

### 2.2 `ext_<schema>_<view_name>_v`
**Znacenje:** view koji konzumira podatke iz druge seme, obicno preko sinonima.
- `ext_` oznacava da je izvor podataka eksterni u odnosu na trenutnu semu.
- `<schema>` oznacava semu/izvor podataka (prema dogovoru).

**Scope:** cross-schema read.

---

### 2.3 `lov_<name>_v`
**Znacenje:** view namijenjen za APEX LOV liste (list of values).

**Scope:** shared, UI pomocni.

---

### 2.4 `p00000_<view_name>`
**Znacenje:** globalni/shared view koji se koristi na vise stranica (nije vezan za jedan `pXXXXX`).

**Scope:** shared.

---

### 2.5 `<appShort>_pXXX_<view_name>`
**Znacenje:** view za eksterne aplikacije, analogno konvenciji kod controller paketa.
- `<appShort>` skraceni naziv aplikacije,
- `pXXX` identifikator kontrolera/stranice u kontekstu te aplikacije.

**Scope:** external app.

---

### 2.6 `rep_<name>`
**Znacenje:** view namijenjen izvjestajima.

**Scope:** reporting.

## 3) Brza klasifikacija po patternu (sa znacenjem)

### Paketi
- `pXXXXX_controller_pkg` -> APEX page controller (page-specific)
- `<schema>_util_pkg` -> konstante/helpers (shared)
- `<schema>_ws_pkg` -> web service layer (integracije)
- `<appShort>_pXXX_controller_pkg` -> external app controller
- `<schema>_<name>_interface_pkg` -> cross-schema public contract (preko sinonima)
- `<name>_pkg` / `<name>_util_pkg` -> core paketi (biznis logika)

### Pogledi
- `pXXXXX_<view_name>` -> page-specific view
- `ext_<schema>_<view_name>_v` -> view nad sinonimom druge seme
- `lov_<name>_v` -> APEX LOV view
- `p00000_<view_name>` -> global shared view
- `<appShort>_pXXX_<view_name>` -> external app view
- `rep_<name>` -> reporting view

## 4) Napomene
- Za cross-schema pozive prioritet je interface paket + sinonim (`*_api`), uz navedene izuzetke.
- Controller paketi su orkestracija; core paketi su biznis logika; util je konstante/helpers; ws je izlaganje servisa; interface je javni contract.

Kraj dokumenta.
