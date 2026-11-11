---
project: "{{PROJECT_SLUG}}"
id: CLIENT_REQ_TEMPLATE
type: client_requirement
status: incoming
source: <client_meeting | email | call | workshop | document>
received: YYYY-MM-DD
owner: <team_or_person>
app: <optional>
module: <optional>
jira: []
tags: []
---

# Naziv zahtjeva

## Originalni zahtjev

Prenesi originalni tekst sto vjernije.

Ako je zahtjev stigao usmeno ili kroz vise poruka, ovdje napravi jasan
konsolidovani zapis i navedi porijeklo informacije.

## Poslovni cilj

- Sta klijent zeli da postigne
- Zasto mu je to bitno
- Ko koristi rezultat

## Trenutno stanje

Opisati trenutno ponasanje procesa, ekrana ili sistema samo onoliko koliko je
potrebno da se razumije problem.

## Ocekivano ponasanje

Opisati sta treba da bude drugacije nakon realizacije.

## Scope

- Sta eksplicitno ulazi u scope
- Sta ne ulazi u scope
- Da li zahtjev vjerovatno proizvodi jedan ili vise Jira taskova

## Otvorena pitanja

- Pitanja koja treba vratiti klijentu
- Nedostajuci podaci, pravila ili odluke

## Pretpostavke

- Pretpostavke na kojima trenutno stoji razrada
- Stavke koje treba potvrditi prije Jira handoff-a

## Prilog / artefakti

- `attachments/...`
- Linkovi, screenshotovi, exporti, zapisnik sa sastanka

## Predlog za Jira

- Kratki naslov
- Potencijalni epic / modul
- Predlog kako razbiti zahtjev ako je sirok

## Povezani taskovi i dokumenti

- AI task:
- Developer brief:
- User docs:
- Tehnicki RAG:
