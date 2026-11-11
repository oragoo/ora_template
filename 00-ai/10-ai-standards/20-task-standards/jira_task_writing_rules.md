---
project: "{{PROJECT_SLUG}}"
id: JIRA_TASK_WRITING_RULES
type: standards
tags: [standards, jira, task, writing]
last_review: 2026-10-05
---

# Jira Task Writing Rules

Ova pravila vaze kada Jira ticket pises prvenstveno za programera, a coding agent dobija poseban `.md` attachment.

## Osnovni princip

Jira ticket treba da bude:

- pregledan i citljiv programeru
- dovoljan za razumijevanje poslovnog i tehnickog scope-a
- rasterecen od detalja koji su bitni samo AI agentu

AI attachment treba da bude:

- detaljan operativni handoff za coding agenta
- napisan po AI task standardu
- dovoljan da agent moze krenuti u implementaciju bez dodatnog tumacenja
- po potrebi sacuvan u repozitorijumu kao lokalni `.md` set instrukcija

## Obavezni elementi Jira opisa

- `AI Instructions`
- `Business Context`
- `Goal`
- `Scope`
- `Constraints`
- `Acceptance Criteria`
- `Validation`

## Pravila pisanja Jira opisa

- Jira opis pisi za covjeka, ne kao puni prompt za agenta
- `AI Instructions` mora biti prva sekcija u Jira opisu
- `AI Instructions` treba da sadrzi samo:
  - putanju do AI `.md` fajla u repozitorijumu
  - kratku naredbu da coding agent mora prvo otvoriti taj fajl
- Drzi fokus na poslovnom problemu, scope-u, granicama i done kriterijima
- `Relevant Systems / Files`, RAG putanje, repo putanje i slicne navigacione reference pripadaju AI attachment-u, ne Jira briefu, osim ako su stvarno potrebne developeru kao poslovni ili implementacioni kontekst
- U Jira opisu ne guraj pune inventory tabele, detaljne wrapper instrukcije i agent output format osim ako je zadatak bas mali
- Opsti repo standardi tipa `Postuj AGENTS.md`, Flyway pravila, package komentari i slicno pripadaju AI attachment-u, ne Jira briefu, osim ako su dio stvarnog poslovnog ili delivery ogranicenja
- Ostatak Jira opisa treba da ostane developer-facing brief
- Ako attachment postoji, Jira opis ne mora ponavljati pune AI instrukcije

## Pravila za AI attachment

- AI attachment pisi po `@00-ai/10-ai-standards/20-task-standards/ai_task_template_short.md` ili `@00-ai/10-ai-standards/20-task-standards/ai_task_template_full.md`
- Ako je zadatak slozen, cross-schema ili sklon dupliranju logike, koristi puni AI task template
- Ako je poznato da agent radi direktno u istom repozitorijumu, `Git Preparation` ide u AI attachment
- Ako postoji rizik od dupliranja helper funkcija ili pogresnog ownership-a, attachment mora traziti inventory kao prvi korak
- Lokalni `.md` attachment fajl moze se cuvati u repozitorijumu kao trajni AI handoff dokument

## Dokumentacija (AI korekcija / preporuka programeru)

- AI attachment nasljeduje pravilo iz `@00-ai/10-ai-standards/20-task-standards/ai_task_writing_rules.md` -> "Korekcija dokumentacije nakon izmjene": ako izmjena mijenja dokumentovano ponasanje, agent mora, kao zavrsni korak, azurirati pogodjenu tehnicku (`@00-ai/`) i korisnicku (`@00-ai/80-user-documentation/apex/`, ako je rijec o APEX ekranu) dokumentaciju
- Ta korekcija mora biti integrisana u postojeci opis, u istom stilu kao ostale stavke u dokumentu - ne kao "changelog" recenica koja objasnjava sta je zadatak uradio
- Developer-facing dio Jira opisa (npr. sekcija `Delivery Notes`) treba da sadrzi istu preporuku kao u `@00-ai/10-ai-standards/20-task-standards/developer_task_writing_rules.md` -> "Preporuka: koriscenje AI za dopunu dokumentacije", za slucaj kad programer sam radi dio izmjene mimo AI attachment-a

## Sta izbjegavati

- Stari model gdje Jira opis pokusava biti i developer brief i puni AI handoff u jednom tekstu
- Jira opis zatrpan agent-specifikom koju programer ne treba citati
- AI attachment bez jasne veze sa Jira ticketom
- Velike i teske sekcije u Jira opisu ako ista informacija vec postoji u AI `.md` fajlu

## Operativni workflow

- Kada korisnik trazi Jira task sa AI attachment-om, pripremi dva artefakta:
  - Jira opis po ovom standardu
  - AI `.md` attachment po AI task standardu
- U Jira opisu, u sekciji `AI Instructions`, jasno oznaci koji `.md` fajl je primarni operativni izvor za coding agenta
- Ako attachment treba da bude dugotrajan ili ponovo upotrebljiv, sacuvaj ga u repozitorijumu u `@00-ai/30-development-tasks/02-ai-tasks/`; ne dodaj ga rucno u `@00-ai/_index.md` - taj indeks nije rucni registar taskova

## Instrukcija "napisi Jira zadatak"

Kada korisnik napise instrukciju u obliku "napisi Jira zadatak", "napravi Jira zadatak", "kreiraj Jira task" ili slicno, model treba prvo pokusati koristiti dostupnu Jira/Atlassian konekciju i kreirati ili azurirati zadatak direktno na Jira portalu.

Ako je Jira konekcija dostupna:

- utvrditi ispravan Jira site/cloud i projekat iz konteksta ili dostupnih projekata;
- koristiti projekat potvrdjen za {{PROJECT_NAME}} ili eksplicitno naveden u zahtjevu;
  sama dostupnost nekog razvojnog projekta nije dokaz da mu {{PROJECT_NAME}} pripada;
- napisati zadatak u jasnom i urednom formatu, sa kratkim summaryjem i opisom koji razdvaja cilj, scope i acceptance kriterije kada je to korisno;
- nakon kreiranja ili izmjene korisniku vratiti Jira key i link.

Ako Jira konekcija nije dostupna:

- ne izmisljati da je zadatak kreiran;
- pripremiti tekst zadatka u Jira-ready formatu;
- jasno reci korisniku da Jira portal nije bio dostupan.

## AI i Developer dio u jednom Jira zadatku

Korisnik moze reci da zadatak ima dva dijela: AI dio i Developer dio.

U tom slucaju:

- AI dio zadatka uvijek mora dobiti handoff fajl u `@00-ai/30-development-tasks/02-ai-tasks/`;
- Jira opis mora referencirati taj handoff fajl u AI sekciji;
- Developer dio ostaje tekstualni dio Jira zadatka koji developer rucno ili uz pomoc AI rjesava;
- ne mijesati APEX/UI/developer aktivnosti u AI handoff ako ih je korisnik jasno oznacio kao Developer dio;
- ako korisnik kaze da dopuni postojeci Jira zadatak, azurirati postojeci zadatak i po potrebi kreirati/dodati handoff fajl.

Naziv handoff fajla treba pratiti postojecu konvenciju:

`@00-ai/30-development-tasks/02-ai-tasks/<JIRA_KEY>_<YYYY-MM-DD>_<kratak-slug>.md`

Primjer:

`@00-ai/30-development-tasks/02-ai-tasks/<JIRA_KEY>_YYYY-MM-DD_appointment-status-validation.md`
