---
project: "{{PROJECT_SLUG}}"
id: CODING_STANDARDS_INDEX
type: index
tags: [index, standards, coding, plsql, flyway, naming, deployment, react]
last_review: 2026-10-06
---

# Coding Standards - Index

## Svrha

Ovaj folder sadrzi sve standarde za pisanje i isporuku samog koda u repou -
PL/SQL (header, komentari, naming, Flyway konvencije, deployment) i React
(web/desktop/mobile) aplikacije.

---

## Dokumenti

| Dokument | Sadrzaj |
|---|---|
| `@00-ai/10-ai-standards/50-coding-standards/coding_standards.md` | PL/SQL coding standard - header format, `Izmjene` changelog, isporuka izmjene kao cijele rutine, sazeto/suzdrzano sadrzajno komentarisanje paketa |
| `@00-ai/10-ai-standards/50-coding-standards/naming_conventions.md` | Konvencija imenovanja Oracle DB objekata (paketi, view-ovi - controller/core/util/ws/interface) |
| `@00-ai/10-ai-standards/50-coding-standards/flyway_conventions.md` | Format i pravila za Flyway R i V skripte |
| `@00-ai/10-ai-standards/50-coding-standards/deployment_standards.md` | Provjera R objekata prije `CREATE OR REPLACE`, ukljucujuci poglede; veza sa Flyway workflowom i deployment uputstvom |
| `@00-ai/10-ai-standards/50-coding-standards/react_app_development_standard.md` | Uslovni standard razvoja React aplikacija; lokacija koda i API ugovor definisu se nakon izbora stacka |

---

## Pravilo izbora

- Pises ili komentarises PL/SQL paket/proceduru -> `coding_standards.md`
- Imenujes novi Oracle DB objekat (paket, view) -> `naming_conventions.md`
- Pises Flyway R ili V skriptu -> `flyway_conventions.md`
- Deplojujes R skriptu na DEV bazu -> `deployment_standards.md` (obavezna provjera prije `CREATE OR REPLACE`)
- Podesavas runner, okruzenje ili workflow -> koristi stvarnu deployment
  dokumentaciju i konfiguraciju projekta; template ne pretpostavlja njihovu putanju
- Radis na React (web/desktop/mobile) aplikaciji -> `react_app_development_standard.md`
