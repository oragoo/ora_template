---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_PACKAGE
type: template
tags: [rag, template, oracle, package]
last_review: 2026-10-05
---

# Template RAG fajla za standardni Oracle paket

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md`,
prednost ima standard. Za `*_interface_pkg` koristi
`package_interface_template.md` umjesto ovog.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/<naziv_paketa>.md`

```yaml
---
id: <PACKAGE_NAME>
type: package_doc
schema: <SCHEMA>
package: <PACKAGE_NAME>
tags: [<schema_malo>, <oznaka_domene>]
last_review: YYYY-MM-DD
---
```

# <PACKAGE_NAME>

## Izvorni fajlovi

- Spec: `@01-database/05-packages/<naziv_paketa>.spc` (ili `.pks`)
- Body: `@01-database/05-packages/<naziv_paketa>.bdy` (ili `.pkb`)

---

## Svrha

Sta paket radi, kome je namijenjen.

---

## Procedure - <kategorija>

| Procedura | Opis |
|---|---|
| `procedure_name(p_param)` | Sta radi; sta vraca/kad je exception |

Za kompleksne procedure sa netrivijalnim parametrima, dodaj SQL potpis i
tablicu parametara (vidi standard).

---

## Zavisnosti

| Objekat | Smjer | Svrha |
|---|---|---|
| `UTIL_PKG` | Poziva | Helperi i konstante |
| `NEKA_TABELA` | DML | INSERT/UPDATE zaglavlja |

---

## Napomene

- Poznate anomalije, preimenovani parametri, legacy napomene.

---

Opcionalne sekcije (dodaj samo kad je primjenjivo): `## Tipican tok`,
`## Kursori`, `## Funkcije - <kategorija>`, `## Privatne procedure`,
`## Implementacione napomene`. Detalji za svaku u standardu.
