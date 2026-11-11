---
project: "{{PROJECT_SLUG}}"
id: APEX_TASK_TEMPLATE_SHORT
type: standards
tags: [standards, apex, frontend, task, template, short]
last_review: 2026-10-05
---

# APEX Task Template Short

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; source exporti se smjestaju u
`@02-apex/applications/`. Konkretna APEX aplikacija postoji tek kada je njen export dodat u `@02-apex/applications/`.

Koristi ovaj template za male, jasno ogranicene promjene na postojecoj stranici: bug fix, novi item, izmjena labela, nova validacija, korekcija query-ja.

```md
# Task: <jasan naziv zadatka>

## Tip
Bug / Enhancement / Refactor  (obrisi nepotrebno)

## APEX Lokacija
- Aplikacija: <potvrdjeni naziv i stvarni App ID>
- Stranica: Page <broj> - <naziv stranice>
- Region / Item: <naziv regiona ili itema ako je poznat>

## Kontekst
<Jedan paragraf - zasto se radi ovaj task i ko je pogodjen>

## Trenutno ponasanje
<Za bug: tacni koraci za reprodukciju, sta se vidi umjesto ocekivanog>

## Zeljeno ponasanje
<Sta treba da se desava nakon izmjene>

## Acceptance Criteria
- [ ] <konkretan, testabilan kriterij>
- [ ] <konkretan, testabilan kriterij>

## Test koraci
1. Otvoriti stranicu X u aplikaciji Y (link ili navigacija)
2. Unijeti / odabrati / kliknuti Z
3. Provjeriti da se pojavi / promijeni / spremi W
```

---

## Kada koristiti

- Bug fix koji se tice jedne stranice ili jednog regiona
- Dodavanje jednog ili dva nova itema na formu
- Izmjena LOV-a, labela, validacijske poruke
- Korekcija SQL query-ja na reportu
- Promjena DA akcije ili procesne logike na jednoj stranici

## Kada NE koristiti

- Nova stranica ili kompleksnija funkcionalnost -> koristi `apex_task_template_full.md`
- Izmjena koja zahtijeva i PL/SQL package promjene -> napravi poseban developer/Jira task za PL/SQL dio
