---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_PACKAGE_INTERFACE
type: template
tags: [rag, template, oracle, package, interface-pkg]
last_review: 2026-10-05
---

# Template RAG fajla za interfejsni Oracle paket (`*_interface_pkg`)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_package_rag_writing_standards.md`,
prednost ima standard, ukljucujuci njegovu sekciju
"Obavezna provjera interfejsnog lanca".

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/<naziv_interface_paketa>.md`

```yaml
---
id: <PACKAGE_NAME>
type: package_doc
schema: <SCHEMA>
package: <PACKAGE_NAME>
tags: [<schema_malo>, <consumer_schema_malo>, interface, cross-schema]
last_review: YYYY-MM-DD
---
```

# <PACKAGE_NAME>

## Izvorni fajlovi

- Spec: `@01-database/05-packages/<naziv_paketa>.spc` (ili `.pks`)
- Body: `@01-database/05-packages/<naziv_paketa>.bdy` (ili `.pkb`)

---

## Svrha

Sta paket radi + eksplicitno navedi cross-schema granicu: owner shema u kojoj
paket fizicki postoji, i consumer shema kojoj je izlozen.

---

## Tok podataka

```text
Konzumerska shema
    -> sinonim consumer.owner_api
        -> owner_consumer_interface_pkg
            -> core_pkg / util_pkg
```

---

## Procedure - <kategorija>

| Procedura | Opis |
|---|---|
| `procedure_name(p_param)` | Sta radi; sta vraca/kad je exception |

---

## Tabele koje paket mijenja

| Tabela | Operacije |
|---|---|
| `NEKA_TABELA` | `INSERT`, `UPDATE` |

---

## Cross-schema i runtime zavisnosti

| Objekat | Smjer | Svrha |
|---|---|---|
| `owner.some_util_pkg` | Poziva | Helperi |
| `consumer.owner_api` | Sinonim | Ulazna tacka za consumer shemu |

---

## Dokazivi konzumenti

- `@01-database/01-synonyms/<owner_api_source>.sql`
  definira sinonim `consumer.owner_api` prema ovom paketu
- `@01-database/05-packages/<consumer_package_source>.bdy`
  koristi: `procedure_a`, `procedure_b`

> Ne navoditi pretpostavljene konzumente - samo one potvrdjene u izvornom kodu.

---

## Poznata ogranicenja i oprez

- Zakucana logika, tihi kvarovi, pretpostavke pozivajuce strane.

---

Opcionalna sekcija: `## Standardni redoslijed poziva` (ako redoslijed ima
znacajan uticaj), `## Kada koristiti ovu dokumentaciju`. Detalji u standardu.
