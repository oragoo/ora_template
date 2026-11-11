---
project: "{{PROJECT_SLUG}}"
id: TASK_STANDARDS_INDEX
type: index
tags: [index, standards, tasks, ai, developer, jira, apex, review]
last_review: 2026-10-05
---

# Task Standards - Index

## Svrha

Ovaj folder sadrzi sve standarde za formulaciju zadataka u ovom repou - za AI
agente, za programere, za Jira tikete sa AI attachmentom, za APEX frontend, i
standard za code review po broju zadatka.

Namjena je da menadzeri, leadovi i ostali clanovi tima mogu mijenjati ove RAG
fajlove i prilagodavati stil zadavanja bez diranja ostatka dokumentacije.

---

## Dokumenti

| Dokument | Sadrzaj |
|---|---|
| `@00-ai/10-ai-standards/20-task-standards/ai_task_template_short.md` | Kratki template za AI task - male, jasno ogranicene izmjene sa malim scope-om i bez vise nepoznanica |
| `@00-ai/10-ai-standards/20-task-standards/ai_task_template_full.md` | Puni template za AI task - slozeniji zadaci projekta {{PROJECT_NAME}} koji zahtijevaju analizu, vise fajlova ili paznju na granice izmjena |
| `@00-ai/10-ai-standards/20-task-standards/ai_task_writing_rules.md` | Pravila pisanja AI task handoff fajla - obavezni elementi, tretman dostavljenog DDL-a, Git/Branch Preparation, korekcija dokumentacije nakon izmjene |
| `@00-ai/10-ai-standards/20-task-standards/apex_task_template_short.md` | Kratki APEX template - bug fix ili mala izmjena na vec postojecoj stranici |
| `@00-ai/10-ai-standards/20-task-standards/apex_task_template_full.md` | Puni APEX template - nova stranica, wizard tok ili veca funkcionalnost sa vise regiona/procesa |
| `@00-ai/10-ai-standards/20-task-standards/apex_task_writing_rules.md` | Pravila pisanja brief-a za APEX frontend programera koji radi u Application Builderu |
| `@00-ai/10-ai-standards/20-task-standards/developer_task_template_short.md` | Kratki developer template - manji, jasno ogranicen zadatak za programera |
| `@00-ai/10-ai-standards/20-task-standards/developer_task_template_full.md` | Puni developer template - integracije, migracije, vise fajlova ili veci rizik od regresije |
| `@00-ai/10-ai-standards/20-task-standards/developer_task_writing_rules.md` | Pravila pisanja zadatka za programera (ne za AI agenta) |
| `@00-ai/10-ai-standards/20-task-standards/jira_task_template_short.md` | Kratki Jira template - Jira opis ostaje kratak i citljiv programeru, AI detalji idu u poseban attachment |
| `@00-ai/10-ai-standards/20-task-standards/jira_task_template_full.md` | Puni Jira template - kompleksniji Jira zadatak sa detaljnim AI attachmentom |
| `@00-ai/10-ai-standards/20-task-standards/jira_task_writing_rules.md` | Pravila pisanja Jira tiketa sa AI attachmentom - razdvajanje developer-facing opisa i agent-facing handoff fajla |
| `@00-ai/10-ai-standards/20-task-standards/pr_review_standards.md` | Postupak AI-vodjenog code review-a grane/zadatka po broju - pronalazak grane, izvor zahtjeva, `git diff`, struktura izvjestaja po 4 dimenzije |

---

## Grupe standarda

| Standard | Kada se koristi | Glavni dokumenti |
|---|---|---|
| AI agent task standard | Kad zadatak pise AI agent koji treba samostalno da cita repo, primijeni pravila i vrati strukturisan rezultat | `ai_task_template_short.md`, `ai_task_template_full.md`, `ai_task_writing_rules.md` |
| Developer task standard | Kad zadatak cita programer - code review, Jira ticket, cross-team handoff za PL/SQL / backend rad | `developer_task_template_short.md`, `developer_task_template_full.md`, `developer_task_writing_rules.md` |
| Jira + AI attachment standard | Kad Jira treba biti citljiv programeru, a coding agent treba poseban `.md` attachment sa detaljnim handoff instrukcijama | `jira_task_template_short.md`, `jira_task_template_full.md`, `jira_task_writing_rules.md` |
| APEX frontend task standard | Kad zadatak opisuje rad u Oracle APEX Application Builderu - bug fix, nova stranica, izmjena regiona, procesa ili validacije | `apex_task_template_short.md`, `apex_task_template_full.md`, `apex_task_writing_rules.md` |
| Review standard | Kad korisnik trazi "odradi review \<broj>" - AI-vodjen code review konkretne grane/zadatka | `pr_review_standards.md` |

---

## Workspace folderi

| Workspace | Svrha |
|---|---|
| `@00-ai/_index.md` | Pregled postojecih izvora i planiranih lokacija dokumentacije i zadataka |

Lokacije za zadatke su planirane i kreiraju se uz prve dokumente. Jira
standard se koristi kada zadatak zaista ide u Jira; kljuc projekta nije
unaprijed odredjen. Lokalni AI zadatak ne zahtijeva Jira tiket. APEX pravila
vaze samo ako je APEX izabran.

---

## Pravilo izbora standarda

- Zadatak izvrsava AI agent -> **AI agent standard**
- Zadatak cita programer, rad je u PL/SQL fajlovima -> **Developer standard**
- Zadatak ide u Jira i developerov AI treba detaljan operativni handoff -> **Jira + AI attachment standard**
- Zadatak opisuje rad u Oracle APEX Builderu (stranice, regioni, procesi, DA) -> **APEX frontend standard**
- Korisnik trazi review postojece grane/zadatka po broju -> **Review standard**

Ako jedan poslovni zahtjev ima i APEX i PL/SQL komponentu, napravi **dva
odvojena taska**: jedan APEX brief i jedan developer/AI task za backend.
Navedi zavisnost u sekciji `Constraints`.

---

## Zajednicki minimum za sve standarde

Bez obzira kome pises zadatak, uvijek treba da postoji:

- Kontekst (poslovni i tehnicki)
- Cilj / Goal
- Scope (sta je u, sta van scope-a)
- Constraints
- Acceptance Criteria
- Validation / Test koraci

---

## Preporuka za menadzere

- Mijenjajte template i rules fajlove kad se promijeni stil rada tima
- Ne mijenjajte vec napisane task fajlove kao zamjenu za template; template je standard, task je konkretan, nepromjenjiv zapis zadatka (vidi `@00-ai/_index.md`)
- Ako se proces znacajno promijeni, zadrzite staru verziju u git historiji i azurirajte `last_review`

---

## Jira zadaci sa AI/Developer podjelom

Za instrukcije tipa "napisi Jira zadatak" pogledati `jira_task_writing_rules.md`.
Ako zadatak ima AI dio i Developer dio, AI dio obavezno dobija handoff fajl u
`@00-ai/30-development-tasks/02-ai-tasks/`, dok Developer dio ostaje
tekstualni dio Jira zadatka.
