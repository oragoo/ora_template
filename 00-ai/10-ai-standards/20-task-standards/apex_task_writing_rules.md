---
project: "{{PROJECT_SLUG}}"
id: APEX_TASK_WRITING_RULES
type: standards
tags: [standards, apex, frontend, task, writing]
last_review: 2026-10-05
---

# APEX Task Writing Rules

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; `<apex-source>` treba zamijeniti
stvarnom lokacijom izvoza. APEX aplikacija jos nije dodana u repozitorijum.

Ova pravila vaze kada pises zadatak za Oracle APEX frontend programera.

---

## Osnovno pravilo

APEX task je developer-facing brief za rad u Oracle APEX Application Builderu. Nije prompt za AI agenta i nije PL/SQL specifikacija. Pisi ga kao da razgovaras s iskusnim APEX programerom koji poznaje alat, ali ne poznaje poslovni kontekst i tacnu lokaciju problema.

---

## Obavezni identifikatori lokacije

Svaki APEX task mora sadrzavati bar dva od sljedecih:
- Naziv aplikacije i App ID, potvrdjeni naziv i stvarni App ID
- Broj stranice: stvarni `Page ID` iz aplikacije
- Naziv stranice, npr. `Zakazivanje termina` (ilustrativno)
- Naziv regiona ili itema, npr. `region "Detalji", item P<page_id>_PATIENT_ID` (ilustrativno)

Samo "aplikacija" ili "stranica za termine" nije dovoljno; navesti potvrdjeni App ID i Page ID.

---

## Pravila za bug taskove

- Uvijek navedi tacne korake za reprodukciju, ne "ne radi", nego "Korak 1: klikni X, Korak 2: vidi Y"
- Navedi sta se vidi umjesto ocekivanog, ne samo "greska"
- Ako je greska ORA- ili JS greska, navedi poruku doslovno
- Screenshot ili snimak ekrana je pouzdan prilog i ne treba ga zamjenjivati opisom ako moze biti prilozen
- Navedi u kojim uslovima se greska pojavljuje: uvijek, samo za odredjene korisnike ili samo za odredjene podatke

---

## Pravila za taskove nove funkcionalnosti

- Navedi ko koristi stranicu, jer to odredjuje autorizacijski schema
- Navedi odakle se dolazi na stranicu i kamo se odlazi, jer to odredjuje navigaciju i dugmad
- Navedi izvor podataka: tabela, pogled ili package procedura
- Ako je DML ukljucen, navedi paket/proceduru ako postoji; ako ne postoji, to je poseban zadatak
- Obavezna polja i validacije navedi eksplicitno, jer APEX programer ne moze pretpostaviti poslovna pravila

---

## Razdvajanje APEX i PL/SQL zadataka

APEX task i PL/SQL task su odvojeni zadaci. Ne mijesaj ih u jedan ticket osim za trivijalne slucajeve.

| Pripada APEX tasku | Pripada posebnom PL/SQL tasku |
|---|---|
| Dizajn stranice, regioni, itemi | Nova package procedura za submit |
| DA akcije, navigacija, dugmad | Nova tabela ili ALTER TABLE |
| LOV-ovi, defaulti, validacijske poruke | Novi poslovni izracun u bazi |
| Promjena query-ja na reportu | Nova funkcija lookup |
| Poziv postojece package procedure | Izmjena postojece procedure |

Ako APEX task zavisi od PL/SQL taska koji jos nije zavrsen, to mora biti eksplicitno navedeno kao zavisnost u sekciji `Constraints`.

---

## Pravila za validacijski dio

Test koraci moraju biti UI koraci u browseru, ne "kompajlirati" ili "izvrsiti query". Kompajliranje i deploy radi programer; to nije test.

Dobro:
`1. Prijaviti se kao testni korisnik X, 2. Otvoriti Page <page_id>, 3. Kliknuti Spremi bez popunjenog polja Y, 4. Provjeriti stvarnu poruku validacije`

Lose:
`Provjeriti da validacija radi`

---

## Sta ne pisati u APEX tasku

- Detalji o `cloude.md` pravilima, Flyway konvencijama i package header formatu, jer to nije relevantno za APEX Builder
- Repo putanje do PL/SQL fajlova, jer programer radi u Builderu, ne u fajlovima
- Kompleksni RAG instrukcioni blokovi, jer APEX task treba biti human-readable brief
- Pretpostavke o tome koji App ID treba koristiti; uvijek ga eksplicitno navedi

---

## Workspace i evidencija

Do daljnjeg APEX taskovi idu iskljucivo direktno na Jira portal.

Ako se za {{PROJECT_NAME}} odabere APEX i brief cuva u repozitorijumu, planirana lokacija
je `@00-ai/30-development-tasks/03-apex-tasks/`; kreira se uz prvi zadatak.

---

## Veza sa Jira standardom

Ovaj standard je namijenjen za brief koji ide direktno u Jira kao opis ticketa. Nije namijenjen za AI agent handoff. Ako uz APEX task postoji i PL/SQL dio koji ce raditi AI agent, za taj dio pripremi zaseban AI task attachment prema `@00-ai/10-ai-standards/20-task-standards/ai_task_template_short.md` ili `@00-ai/10-ai-standards/20-task-standards/ai_task_template_full.md`.
