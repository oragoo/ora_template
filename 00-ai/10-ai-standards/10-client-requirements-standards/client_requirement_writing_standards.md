---
project: "{{PROJECT_SLUG}}"
id: CLIENT_REQUIREMENT_WRITING_STANDARDS
type: standard
tags: [standard, client-requirements, intake, jira-prep, writing]
last_review: 2026-10-05
---

# Standardi za pisanje klijentskih zahtjeva

Ovaj dokument definise kako pisati i razradjivati zapis klijentskog zahtjeva.
Planirana lokacija za klijentske zahtjeve, koja se kreira uz prvi zapis:
`@00-ai/20-client-requirements/01-client-requirements/`.

Zapis klijentskog zahtjeva nije Jira task, AI task, developer brief ni
korisnicko uputstvo. To je poslovni intake dokument: sto vjerniji zapis onoga
sto je klijent trazio, plus razrada dovoljna da se zahtjev kasnije pretvori u
jedan ili vise Jira taskova.

Koristi ga kada:
- klijent dostavi zahtjev preko sastanka, maila, poziva ili workshopa
- treba konsolidovati vise razlicitih poruka/inputa u jedan jasan zapis
- zahtjev jos nije dovoljno razjasnjen da bi direktno postao Jira task

---

## Obavezni elementi

Svaki zapis klijentskog zahtjeva ima YAML frontmatter sa najmanje:
`id`, `type: client_requirement`, `status`, `source`, `received`, `owner`,
`jira`, `tags`.

Obavezne sekcije (redoslijed prati template):
- `Originalni zahtjev`
- `Poslovni cilj`
- `Trenutno stanje`
- `Ocekivano ponasanje`
- `Scope`
- `Otvorena pitanja`
- `Pretpostavke`
- `Prilog / artefakti`
- `Predlog za Jira`
- `Povezani taskovi i dokumenti`

Template: `@00-ai/10-ai-standards/10-client-requirements-standards/templates/client_requirement_template.md`.

---

## Pravila pisanja

- `Originalni zahtjev` prenosi klijentov zahtjev sto vjernije, bez
  preformulisanja u tehnicki jezik - ako je zahtjev stigao usmeno ili kroz
  vise poruka, napravi jasan konsolidovani zapis i navedi porijeklo
  informacije (sastanak, mail, poziv).
- `Poslovni cilj` objasnjava zasto je zahtjev bitan i ko koristi rezultat -
  ne samo sta treba promijeniti, vec i zbog cega.
- `Trenutno stanje` i `Ocekivano ponasanje` ostaju na poslovnom nivou -
  detaljna tehnicka analiza (paketi, tabele, procedure) ide u AI task ili
  developer brief, ne u ovaj dokument.
- `Scope` eksplicitno navodi i sta NE ulazi u zahtjev, ne samo sta ulazi.
- Nepoznanice idu u `Otvorena pitanja`, ne u `Pretpostavke` - pretpostavka je
  radna odluka na kojoj trenutno stoji razrada, otvoreno pitanje je nesto sto
  treba vratiti klijentu.
- Ne izmisljati poslovno pravilo, rok ili prioritet koji klijent nije naveo -
  ako nesto nije receno, to ide u `Otvorena pitanja`.
- `Prilog / artefakti` cuva reference (screenshotovi, exporti, zapisnik), ne
  duplira njihov sadrzaj u tekstu zahtjeva.
- `Povezani taskovi i dokumenti` se dopunjava kako zahtjev napreduje kroz
  lifecycle (vidi ispod) - popunjava se linkovima na stvarne AI taskove,
  developer briefove i dokumentaciju, ne unaprijed predvidjenim putanjama.

---

## Lifecycle i status

- `status: incoming` - zahtjev je zaprimljen, jos nije razradjen
- `status: ready_for_jira` - cilj, scope i otvorena pitanja su razjasnjeni
- `status: archived` - zahtjev je zavrsen, odustan ili zastarjeo

Fizicko mjesto fajla prati `status` (`incoming/`, `ready_for_jira/`,
`archive/`) unutar `@00-ai/20-client-requirements/01-client-requirements/` -
vidi preporucenu strukturu foldera u `templates/client_requirement_template.md`.

---

## Odnos prema drugim standardima

- Kad je zahtjev razjasnjen i spreman za implementaciju, iz njega nastaje
  AI task (`@00-ai/10-ai-standards/20-task-standards/ai_task_writing_rules.md`),
  developer brief (`@00-ai/10-ai-standards/20-task-standards/developer_task_writing_rules.md`)
  ili Jira task (`@00-ai/10-ai-standards/20-task-standards/jira_task_writing_rules.md`).
- Klijentski zahtjev ne zamjenjuje te dokumente niti prepisuje njihov sadrzaj
  - on je ulazna tacka prije njih, na poslovnom, ne agent-facing nivou.
- Klijentski zahtjev ne zamjenjuje krajnje korisnicko uputstvo
  (`@00-ai/10-ai-standards/40-user-documentation-standards/_index.md`) niti
  tehnicku RAG dokumentaciju (`@00-ai/10-ai-standards/30-technical-documentation-standards/_index.md`).
