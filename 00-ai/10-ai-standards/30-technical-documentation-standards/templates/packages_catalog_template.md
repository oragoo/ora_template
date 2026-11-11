---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_PACKAGES_CATALOG
type: template
tags: [rag, template, oracle, packages, catalog, index]
last_review: 2026-10-05
---

# Template RAG kataloga paketa (packages.md)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_packages_catalog_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages.md`

```yaml
---
id: <SCHEMA>_PACKAGES
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, packages, index]
last_review: YYYY-MM-DD
---
```

```markdown
# <SCHEMA> - katalog paketa

> Arhitekturni pregled: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/overview.md`

## Izvor istine

`@01-database/05-packages/`

Svaki DDL-potvrdjeni paket iz ovog foldera mora imati tacno jedan red u
katalogu. Specifikacija i body istog paketa broje se kao jedan paket.
Standalone procedure i funkcije ne ulaze u katalog paketa.

---

## Core / util paketi

| Paket | Uloga | Detalji |
|---|---|---|
| `CORE_PKG` | Centralna biznis logika | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/core_pkg.md` |
| `UNDOCUMENTED_PKG` | Kratak opis potvrdjen iz source-a | `TBD` |

---

## Controller paketi

| Paket | Uloga | Detalji |
|---|---|---|
| `P00001_CONTROLLER_PKG` | Kratak opis uloge/APEX stranice | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/p00001_controller_pkg.md` |
| `P00002_CONTROLLER_PKG` | Kratak opis uloge/APEX stranice | `TBD` |

---

## Interface paketi (cross-schema)

| Paket | Konzument | Svrha | Detalji |
|---|---|---|---|
| `<SCHEMA>_X_INTERFACE_PKG` | `X` shema | Svrha interfejsa | `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/packages/<schema>_x_interface_pkg.md` |
| `<SCHEMA>_Y_INTERFACE_PKG` | `Y` shema | Svrha interfejsa | `TBD` |

---

## Napomene

Broj paketa u ovom katalogu mora odgovarati broju jedinstvenih
DDL-potvrdjenih `CREATE PACKAGE` objekata u
`@01-database/05-packages/`. Broj source fajlova se ne koristi
jer specifikacija i body istog paketa predstavljaju jedan objekat.
```

---

Grupisati po tipu/domeni (core/util, controller, interface), ne abecedno.
Svaki source paket se navodi i kada nema detaljni Markdown fajl; tada se u
koloni `Detalji` pise `TBD`. Svrha ovog fajla je brza navigacija - ne
duplirati listu procedura/funkcija iz detaljnog fajla.
