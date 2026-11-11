---
project: "{{PROJECT_SLUG}}"
id: DEVELOPER_TASK_WRITING_RULES
type: standards
tags: [standards, developer, task, writing]
last_review: 2026-10-05
---

# Developer Task Writing Rules

R/V pravila prate Flyway standard projekta. Za poglede je potvrdjena R
konvencija; konfiguraciju izvrsavanja i ostale tipove izvora provjeriti u repou.

Ova pravila vaze kada se zadatak pise za programera, a ne za AI agenta.

## Osnovni princip

Programer treba iz taska da razumije:

- poslovni razlog izmjene
- sta tacno treba isporuciti
- granice odgovornosti
- kako ce znati da je task zavrsen

## Obavezni elementi

- `Business Context`
- `Goal`
- `Scope`
- `Acceptance Criteria`
- `Testing`

Za vece taskove dodati i:

- `Functional Requirements`
- `Technical Requirements`
- `Deployment Notes`
- `Open Questions / Risks`

## Kako pisati task za programera

- Pocni od poslovnog problema, ne od tehnickog detalja
- Navedi sta je expected behaviour nakon izmjene
- Razdvoji obavezno od pozeljnog
- Napisi sta nije dio taska
- Ako postoji referentni fajl ili slicna implementacija, navedi je
- Ako task ukljucuje bazu, navedi source fajlove i nacin isporuke; R/V pravila
  primijeni samo ako projekat koristi Flyway
- Ako postoji rizik od regresije, navedi gdje posebno paziti

## Sta izbjegavati

- "Sredi ovo"
- "Optimizuj gdje treba"
- "Provjeri sve vezano za modul"
- Task bez definisanog done kriterija
- Mijesanje vise nepovezanih ciljeva u jednom briefu

## {{PROJECT_NAME}} i projektna pravila

- Kao ulaznu dokumentaciju koristi `@00-ai/_index.md`
- Za Oracle objekte provjeri naming i coding standarde u `@00-ai/10-ai-standards/`
- Za potvrdjene eksterne SQL integracije ukljuci i reference na `@00-ai/40-technical-documentation/03-integrations/<module>/`
- Za V skripte navedi da se ne mijenjaju nakon commitanja
- Za R skripte navedi da se mijenjaju direktno kad je to odgovarajuci obrazac

## Preporuka: koriscenje AI za dopunu dokumentacije

Ako task mijenja ponasanje, strukturu ili izgled necega sto je vec dokumentovano - tehnicka RAG dokumentacija u `@00-ai/` ili korisnicko uputstvo (`@00-ai/80-user-documentation/apex/`, ako je rijec o APEX ekranu) - task treba da sadrzi eksplicitnu preporuku programeru da nakon implementacije zatrazi od AI agenta da dopuni tu dokumentaciju.

Preporuka mora naglasiti:

- da AI treba da azurira samo dokumente koji vec postoje i koji su stvarno pogodjeni izmjenom, ne da siri korekciju na nepovezane fajlove niti da dokumentuje nesto sto ranije nije bilo dokumentovano
- da korekcija ne smije biti "changelog" recenica koja opisuje sta je task uradio (npr. "dodata je nova kolona kroz zadatak <JIRA_KEY>"), vec mora biti integrisana u postojeci opis, u istom stilu kao ostale stavke koje vec stoje u dokumentu (npr. opis nove kolone izvjestaja dodaje se u listu kolona kao i za sve ostale kolone koje su vec dokumentovane, bez pominjanja zadatka ili razloga izmjene)

Ovo je preporuka, ne obavezan acceptance kriterij - programer odlucuje da li ce je iskoristiti, ali task treba da je eksplicitno ponudi kao korak nakon implementacije, a ne da dokumentaciju prepusti da zastari.

## Razlika u odnosu na AI standard

- Developer task moze biti malo siri i prirodniji u jeziku
- Nije potrebno detaljno propisivati format odgovora kao kod AI agenta, osim ako je to bitno za handoff
- Dozvoljeno je ostaviti otvorena pitanja ako task sluzi kao radni brief za diskusiju

## Preporuceni uvod

```md
Prije implementacije procitaj relevantnu dokumentaciju iz `@00-ai/_index.md`.
Ako tokom rada nadjes konflikt sa legacy ogranicenjima ili nejasan scope, vrati otvoreno pitanje prije sirenja izmjena van dogovorenog okvira.
```
