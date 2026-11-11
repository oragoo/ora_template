---
project: "{{PROJECT_SLUG}}"
id: AI_TASK_WRITING_RULES
type: standards
tags: [standards, ai, task, writing]
last_review: 2026-10-05
---

# AI Task Writing Rules

R/V pravila prate Flyway standard projekta. Za poglede je potvrdjena R
konvencija; konfiguraciju izvrsavanja i ostale tipove izvora provjeriti u repou.

Ova pravila vaze kad formulises zadatak za AI agenta u repozitorijumu {{PROJECT_NAME}}.

## Obavezni elementi svakog taska

- YAML frontmatter sa najmanje: `id`, `type: ai_task`, `created`, `jira`
- `Context`: gdje agent radi i koji dokument prvo otvara
- `Goal`: sta mora biti gotovo na kraju
- `Scope`: sta smije, a sta ne smije mijenjati
- `Constraints`: tehnicka i poslovna ogranicenja
- `Acceptance Criteria`: kako znamo da je zadatak gotov
- `Validation`: kako agent provjerava da nije pokvario postojecu logiku
- `Output`: kako treba da vrati odgovor

## Pravila pisanja

- Pisi konkretno, ne apstraktno
- Koristi tacne nazive shema, paketa, procedura, view-ova i fajlova
- Navedi putanje do dokumentacije kad god je bitna
- Ako Jira tiket postoji, navesti stvarni kljuc u `jira:` i u nazivu fajla.
- Za lokalni zadatak bez tiketa koristiti `jira: null` i lokalni `AI-<id>`.
- Jira projektni kljuc ne izvoditi iz naziva projekta niti ga izmisljati.
- Task fajl je trajni, nepromjenjivi zapis zadatka; ne oslanjaj se na rucni centralni spisak u `@00-ai/_index.md`
- `@00-ai/_index.md` koristi kao staticki workspace guide, ne kao fajl koji treba dirati pri svakom dodavanju taska
- Kad korisnik dostavi DDL, tretiraj ga kao source of truth za strukturu objekta koji treba napraviti ili izmijeniti
- Koristi glagole akcije: `izmijeni`, `dodaj`, `provjeri`, `uporedi`, `ne diraj`
- Ako postoji granica izmjena, napisi je eksplicitno
- Ako nesto ne smije da se dira, navedi to u `Out of Scope`
- Ako ocekujes analizu prije izmjene, napisi to kao prvi korak u tasku
- Ako zelis da agent prati specifican obrazac, daj jedan referentni fajl ili objekat
- Task fajl se mijenja samo dok se pise; nakon handoff-a se vise ne edituje (frontmatter polje `status` se ne koristi, task se ne premjesta niti oznacava kao zavrsen u samom fajlu)
- Naziv task fajla pisi u formatu `<TASK_ID>_YYYY-MM-DD_<kratki_slug>.md` (`<TASK_ID>` je stvarni Jira kljuc ili lokalni `AI-<id>`)

## Pravila kad je korisnik dostavio DDL

- U task obavezno prenesi izvorni DDL blok ili vjernu, kompletnu transkripciju istog
- Ako task uvodi novu tabelu ili mijenja strukturu postojece, dodaj sekciju `## Source DDL` ili ekvivalentnu jasno oznacenu sekciju
- Ne svodi DDL na prepricanu listu tipa "tabela treba da cuva..." ako su kolone, tipovi, defaulti, constrainti ili nazivi vec poznati
- Ne dodaj nove kolone, ne preimenuj postojece i ne mijenjaj tipove samo zato sto "djeluje logicno" ili "prati obrazac" ako to nije eksplicitno trazeno ili dokazano iz repoa
- Ako postoji konflikt izmedju korisnickog DDL-a i postojecih repo konvencija, task mora to eksplicitno oznaciti kao otvoreno pitanje ili pravilo za razrjesavanje; agent ne smije sam preskociti ili reinterpretirati DDL bez napomene
- Ako korisnicki DDL nije potpun (npr. nedostaju sekvence, triggeri, komentari ili Oracle-specific detalji), task mora jasno razdvojiti sta je striktno zadano DDL-om a sta se smije dopuniti po projektnom obrascu
- Za svaku dozvoljenu dopunu po obrascu eksplicitno navedi granicu, npr. audit kolone, sekvence, triggeri, komentari, indeks po FK koloni
- Ako je cilj "preslikati model", acceptance kriterij mora traziti da finalna struktura direktno odgovara dostavljenom DDL-u, osim eksplicitno navedenih i obrazlozenih dopuna

## Sta izbjegavati

- "Sredi ovo"
- "Pogledaj sta nije u redu"
- "Refaktorisi po potrebi" bez granica
- Neodredjene izraze kao `neko vrijeme`, `tu negdje`, `par fajlova`
- Sakrivene pretpostavke koje nisu napisane u tasku

## {{PROJECT_NAME}} / Oracle specificna pravila

- Kao pocetni kontekst koristi `@00-ai/_index.md`
- Za naming provjeri `@00-ai/10-ai-standards/50-coding-standards/naming_conventions.md`
- Za coding standarde provjeri `@00-ai/10-ai-standards/50-coding-standards/coding_standards.md`
- Za deployment pravila provjeri `@00-ai/10-ai-standards/50-coding-standards/deployment_standards.md`
- Ne mijenjaj V skripte koje su vec commitane
- Grantove u `@01-database/08-grants/` mijenjaj samo u obimu zadatka i uz provjeru prava
- Kod cross-schema pristupa provjeri da li treba ici kroz interface paket ili `EXT_*` view
- Kad je task baziran na korisnickom DDL-u, u acceptance kriterijima trazi da kolone, tipovi, nullability, defaulti i constrainti budu uskladjeni sa tim DDL-om, osim ako task eksplicitno navodi dokazani razlog za odstupanje
- Kad task ukljucuje izmjene Oracle package fajlova (`.spc`, `.bdy`, `.pks`, `.pkb`), eksplicitno napisi da u zaglavlju paketa treba ostati komentar koji navodi sta je korigovano / mijenjano u paketu
- Ako izmjene mijenjaju dokumentovani contract, naming, tok podataka, zavisnosti, kolone, procedure ili ponasanje objekta, eksplicitno trazi i azuriranje odgovarajucih RAG fajlova u `@00-ai/` (vidi sekciju `Korekcija dokumentacije nakon izmjene`)
- Ne trazi siroko prepisivanje dokumentacije; azuriraju se samo RAG fajlovi koji su stvarno pogodjeni izmjenom

## Korekcija dokumentacije nakon izmjene

Ako izmjena koju AI task pokriva mijenja dokumentovano ponasanje, strukturu, kolonu, proceduru, ekran ili tok podataka, task mora eksplicitno traziti da agent, kao zavrsni korak, azurira postojecu dokumentaciju:

- tehnicku RAG dokumentaciju u `@00-ai/40-technical-documentation/01-database/01-oracle/` (i srodnim RAG folderima) za promjene na tabelama, paketima, view-ovima, procedurama
- korisnicku dokumentaciju u `@00-ai/80-user-documentation/apex/` (npr. `screen_reference` fajl za APEX ekran ili izvjestaj) kad izmjena mijenja nesto sto korisnik vidi ili radi na ekranu

Ova korekcija se radi samo nad dokumentima koji vec postoje i koji su stvarno pogodjeni izmjenom. Ne kreiraj novu dokumentaciju i ne siri korekciju na nepovezane fajlove osim ako je to eksplicitno zatrazeno; ako pogodjena tema jos nije dokumentovana, to eksplicitno napomeni umjesto da je samoinicijativno dokumentujes od nule.

**Kljucno pravilo forme:** korekcija ne smije biti "changelog" recenica koja objasnjava sta je task uradio. Izmjena se integrise u postojeci opis kao da oduvijek tako izgleda, u istom stilu, tonu i formatu kao ostale stavke u tom dokumentu - bez pominjanja zadatka, Jira keya, datuma izmjene ili razloga izmjene.

Primjer:
- Pogresno: "Kroz zadatak <JIRA_KEY> dodata je nova kolona 'Status termina' u izvjestaju."
- Ispravno: opis nove kolone se doda u postojecu tabelu/listu kolona tog izvjestaja, napisan u istom stilu kao opisi ostalih kolona koje vec stoje u dokumentu (npr. naziv kolone, izvor podatka, znacenje) - bez ikakvog pominjanja da je kolona nova ili da je dodata kroz neki zadatak.

Task mora ovu obavezu eksplicitno navesti u `Constraints`, a rezultat provjeriti u `Acceptance Criteria`.

## Pravilo izbora template-a

- Koristi `@00-ai/10-ai-standards/20-task-standards/ai_task_template_short.md` za male, izolovane izmjene
- Koristi `@00-ai/10-ai-standards/20-task-standards/ai_task_template_full.md` za sve zadatke koji ukljucuju analizu, vise fajlova ili veci rizik
- Ako nisi siguran, koristi full template

## Preporuceni standardni uvod za task

```md
---
id: AI_TASK_<JASAN_IDENTIFIKATOR>
type: ai_task
created: YYYY-MM-DD
jira: null  # stvarni Jira kljuc ako postoji tiket
source: "<Jira key ili link ka izvornom zahtjevu>"
tags: [schema, domena, tema]
---

Prvo ucitaj kontekst iz `@00-ai/_index.md`, zatim otvori samo dokumente relevantne za ovaj zadatak.
Ne diraj nepovezane fajlove i ne mijenjaj V skripte koje su vec commitane.
Ako mijenjas package fajlove, u zaglavlju paketa ostavi komentar sta je korigovano.
Ako izmjene uticu na dokumentovane cinjenice, azuriraj i odgovarajuce RAG fajlove u `@00-ai/`.
```

## Priprema Git grane pri izvrsenju taska

Prije izmjena pregledati `git status` i sacuvati postojece lokalne izmjene.
Ako handoff odredjuje ciljnu granu i setup korake, izvrsiti ih u skladu sa
zahtjevom i dostupnim pristupom. Ne izmisljati remote niti dodatne grane.

Polazna grana je `main`; radne grane imenovati prema `@AGENTS.md`, npr.
`feat/appointments`, `fix/appointment-validation` ili `docs/rag-standards`.
Jira kljuc dodati samo ako postoji. Ne uvoditi obavezan Jira tiket kao uslov
za lokalni rad. Ako priprema nije moguca, navesti konkretno ogranicenje i
nastaviti nezavisne, bezbjedne korake koji su u obimu zahtjeva.

## AI dio Jira zadatka kao handoff

Kada Jira zadatak ima eksplicitno odvojen AI dio i Developer dio, AI dio se ne smije ostaviti samo kao tekst u Jira opisu. Potrebno je napraviti handoff fajl u `@00-ai/30-development-tasks/02-ai-tasks/` tako da drugi AI moze otvoriti fajl, razumjeti scope i odmah krenuti u implementaciju.

Handoff fajl treba sadrzati najmanje:

- Jira key i link;
- cilj AI dijela;
- tacan scope za AI;
- sta je van scope-a, posebno Developer/APEX/UI dio ako postoji;
- relevantne RAG fajlove;
- napomene za implementaciju;
- acceptance kriterije.

Developer dio zadatka ostaje u Jira opisu kao tekstualna instrukcija za developera. Ne treba ga pretvarati u AI scope osim ako korisnik to naknadno eksplicitno trazi.

Naziv fajla treba pratiti konvenciju:

`<JIRA_KEY>_<YYYY-MM-DD>_<kratak-slug>.md`
