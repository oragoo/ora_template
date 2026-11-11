---
project: "{{PROJECT_SLUG}}"
id: AI_STANDARDS_INDEX
type: index
tags: [index, standards, {{PROJECT_SLUG}}]
last_review: 2026-10-06
---

# {{PROJECT_NAME}} - standardi za AI dokumentaciju i razvoj

Standardi opisuju kako pisati RAG fajlove, zahtjeve, zadatke, korisnicka
uputstva i kod. Projektni kontekst je u `@AGENTS.md`, a pregled dokumentacije
u `@00-ai/_index.md`.

## Primjena u projektu

- `@00-ai/` je korijen projektne dokumentacije.
- Oracle, Flyway, APEX, React, ORDS i eksterni SQL standardi primjenjuju se
  samo kada je odgovarajuca tehnologija stvarno odabrana i postoji relevantan izvor.
- Ako se koristi predlozena Oracle struktura, DB izvori su u `@01-database/`
  po tipu objekta. Projekat moze dokumentovati drugu stvarnu strukturu.
- Imena objekata, domena, shema i aplikacija u primjerima su ilustrativna.
  Stvarne vrijednosti uvijek potvrditi iz projekta.
- Deployment putanje i workflow fajlovi nisu unaprijed zadani ovim templateom.
  Dokumentovati ih tek nakon sto budu implementirani i provjereni.
- Jira projektni kljuc nije definisan ovim dokumentima. `<JIRA_KEY>` je
  placeholder; lokalni zadaci mogu postojati bez Jira tiketa.
- Planirane lokacije za sadrzaj navedene su u `@00-ai/_index.md`. Folder ili
  fajl koji jos ne postoji ne smije biti predstavljen kao pregledani izvor.
- APEX source korijen je `@02-apex/applications/`. Konkretna aplikacija postoji
  tek kada je njen export dodat u taj folder.
- `<react-source>` oznacava buducu, jos neodredjenu lokaciju React izvornog
  koda. Zamijeniti je stvarnom putanjom nakon postavljanja aplikacije.
- U dokumentima, primjerima i screenshotovima koristiti sinteticne podatke.

---

## Izbor standarda

| Tema | Ulazni dokument |
|---|---|
| Klijentski zahtjevi | `@00-ai/10-ai-standards/10-client-requirements-standards/_index.md` |
| AI, developer, Jira i APEX zadaci; code review | `@00-ai/10-ai-standards/20-task-standards/_index.md` |
| Tehnicka RAG dokumentacija | `@00-ai/10-ai-standards/30-technical-documentation-standards/_index.md` |
| Korisnicka uputstva, ekrani i procesi | `@00-ai/10-ai-standards/40-user-documentation-standards/_index.md` |
| PL/SQL, imenovanje, migracije, isporuka i React | `@00-ai/10-ai-standards/50-coding-standards/_index.md` |

---

## Predlozene putanje DB objekata

| Tip | Izvorni folder |
|---|---|
| Postavljanje baze | `@01-database/00-setup/` |
| Sinonimi | `@01-database/01-synonyms/` |
| Tabele | `@01-database/02-tables/` |
| Sekvence | `@01-database/03-sequences/` |
| Pogledi | `@01-database/04-view/` |
| Paketi | `@01-database/05-packages/` |
| Tipovi | `@01-database/06-types/` |
| Triggeri | `@01-database/07-triggers/` |
| Grantovi | `@01-database/08-grants/` |
| Podaci i sifarnici | `@01-database/09-data/` |

Ova tabela se primjenjuje samo ako projekat prihvati navedenu strukturu. Shema
se potvrduje iz DDL-a ili drugog provjerenog izvora. Grupisanje RAG
fajlova po `<schema>` ne podrazumijeva dodatne source foldere po shemama.

---

## Pisanje RAG fajla

1. Izabrati specificni standard i odgovarajuci predlozak prema tipu objekta.
2. Procitati zajednicka pravila u
   `@00-ai/10-ai-standards/30-technical-documentation-standards/rag_writing_standards.md`.
3. Pregledati stvarni izvor; razdvojiti cinjenice, inferencije i nepoznanice.
4. Zamijeniti placeholdere, provjeriti putanje i azurirati `last_review`.
5. Ne kreirati dokumentaciju o nepostojecim objektima samo da se popuni struktura.
