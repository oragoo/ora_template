---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_TRIGGERS_CATALOG
type: template
tags: [rag, template, oracle, triggers, catalog]
last_review: 2026-10-05
---

# Template RAG kataloga triggera (triggers.md)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_triggers_catalog_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/triggers.md`

Ovaj fajl je navigacioni katalog, ne kopija PL/SQL tijela - source u
`@01-database/07-triggers/` ostaje autoritativan.
DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.

```yaml
---
id: <SCHEMA>_TRIGGERS
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, triggers, index]
last_review: YYYY-MM-DD
---
```

```markdown
# <SCHEMA> - Katalog triggera

## Izvor istine

`@01-database/07-triggers/`

---

## Kako koristiti katalog

Katalog predstavlja pregled svih trenutno postojecih triggera, ciljnih
objekata i DML dogadjaja. Prije izmjene tabele provjeriti sve njene triggere. Za
implementacione detalje provjeriti trigger source.

---

## Konvencije i opsta pravila

- Naziv triggera nije dokaz ciljnog objekta, timinga ili DML dogadjaja.
- Ciljni objekat, timing i dogadjaj citati iz stvarnog DDL iskaza.
- Triggere grupisati u `Audit, PK i lifecycle triggeri`, `Instead-of
  triggeri` ili `Posebni slucajevi`.
- Pojedinacni efekat i PL/SQL tijelo ne prepisivati u katalog.

---

## Audit, PK i lifecycle triggeri

| Trigger | Ciljni objekat | Dogadjaj | Izvor |
|---|---|---|---|
| `<TRIGGER_NAME>` | `<TABLE_NAME>` | `<TIMING I DML DOGADJAJ>` | `@01-database/07-triggers/<source_fajl>.trg` |

---

## Instead-of triggeri

| Trigger | Ciljni objekat | Dogadjaj | Izvor |
|---|---|---|---|
| `<TRIGGER_NAME>` | `<VIEW_NAME>` | `INSTEAD OF <DML DOGADJAJ>` | `@01-database/07-triggers/<source_fajl>.trg` |

---

## Posebni slucajevi

| Trigger | Ciljni objekat | Dogadjaj | Izvor |
|---|---|---|---|
| `<TRIGGER_NAME>` | `<TABLE_OR_VIEW_NAME>` | `<TIMING I DML DOGADJAJ>` | `@01-database/07-triggers/<source_fajl>.trg` |

---

## Napomena

Nema evidentiranih problema, gresaka ili neusaglasenosti.

---

## Odrzavanje

- Novi trigger dodati odmah nakon dodavanja u trenutni source.
- Promjenu naziva, ciljnog objekta, dogadjaja, grupe ili source putanje
  azurirati u
  postojecem redu.
- Uklonjeni trigger ukloniti nakon potvrde trenutnog source-a.
- Otkriveni ili rijeseni problem azurirati u sekciji `## Napomena`.
- Prije izmjene tabele provjeriti sve njene triggere.
- `last_review` azurirati nakon stvarne sadrzajne provjere.
```

---

U konkretnom katalogu prikazati samo neprazne grupe. Ako trigger moze pripadati
u vise grupa, `Instead-of triggeri` ima prednost, zatim `Audit, PK i
lifecycle triggeri`, a `Posebni slucajevi` je zavrsna grupa. Unutar grupe
sortirati abecedno. Svaki trenutno postojeci trigger mora imati tacno jedan
red sa DDL-potvrdjenom tabelom i dogadjajem te direktnom putanjom do source
fajla. Tabela koristi samo kolone `Trigger`, `Ciljni objekat`, `Dogadjaj`
i `Izvor`.

U sekciji `## Napomena` zamijeniti tekst o nepostojanju problema konkretnim
zapisima kada katalog ima potencijalni problem, gresku ili neusaglasenost.
Navoditi samo trenutno stanje, bez vodjenja changelog-a.
