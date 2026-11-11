---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_SCHEMA_OVERVIEW
type: template
tags: [rag, template, oracle, schema, overview]
last_review: 2026-10-05
---

# Template RAG fajla za pregled sheme

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_schema_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/overview.md`

```yaml
---
id: <SCHEMA>_OVERVIEW
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, overview]
last_review: YYYY-MM-DD
---
```

# <SCHEMA> - <kratak opis domene>

## Svrha sheme

Domena i primarna odgovornost sheme.

---

## Trenutno dokumentovani objekti

Jasno navesti sta je vec pokriveno u `00-ai` (linkovi na `tables.md`,
`packages.md`, i eventualno `views.md`/`triggers.md`/`synonyms.md`).

---

## Trenutno mapirani runtime tragovi

- Kljucne tabele i njihova uloga, sa dokazima.

---

## Konzumenti sheme

| Konzument | Tip | Nacin pristupa |
|---|---|---|
| APEX aplikacija | Graficko sucelje | Controller paketi |

---

## Cross-schema zavisnosti

Puna lista je u `external_deps.md`. Sazetak:

| Shema | Interfejsni paket | Svrha |
|---|---|---|
| <SHEMA> | `<SCHEMA>_<CONSUMER>_INTERFACE_PKG` | ... |

---

## Napomene i upozorenja

- Legacy, tehnicki dug, zabranjene prakse, status pokrivenosti.

---

Za seed pregled (dokumentacija tek zapoceta) dovoljne su sekcije `## Svrha
sheme` i `## Trenutno dokumentovani objekti`; ostale sekcije (`## Arhitektura
paketa` sa ASCII dijagramom, itd.) dodaju se kad dokumentacija sazrije. Detalji
u standardu.
