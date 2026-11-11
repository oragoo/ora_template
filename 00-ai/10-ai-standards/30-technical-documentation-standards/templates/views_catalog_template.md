---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_VIEWS_CATALOG
type: template
tags: [rag, template, oracle, views, catalog]
last_review: 2026-10-05
---

# Template RAG kataloga pogleda (views.md)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_views_catalog_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/views.md`

Ovaj fajl je navigacioni katalog, ne kopija SQL definicija - source u
`@01-database/04-view/` ostaje autoritativan.
DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.

```yaml
---
id: <SCHEMA>_VIEWS
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, views, index]
last_review: YYYY-MM-DD
---
```

```markdown
# <SCHEMA> - Katalog pogleda

## Izvor istine

`@01-database/04-view/`

---

## Kako koristiti katalog

Katalog predstavlja pregled svih trenutno postojecih pogleda sheme. Za
implementacione detalje provjeriti SQL source. Opstu upotrebu tumaciti prema
konvenciji prefiksa. Konkretna mjesta upotrebe, kada su potrebna, utvrditi
pretragom repozitorija.

---

## Konvencije naziva i opste upotrebe

| Obrazac naziva | Opsta upotreba |
|---|---|
| `LOV_*` | Pogledi za LOV liste unutar aplikacije. |
| `Pxxxxx_*` | Kontroler pogledi za APEX stranicu `xxxxx`; koriste se samo na toj stranici. `xxxxx` je petocifreni broj stranice. |
| `EXT_*` | Pogledi koji citaju podatke iz druge sheme i zamjenjuju direktan pristup njenim tabelama; mogu ih koristiti drugi pogledi i paketi. |
| `REP_*` | Pogledi koji se koriste u izvjestajima. |
| Ostali nazivi | Pogledi bez navedenih standardnih prefiksa; vode se u grupi `Ostali pogledi`. Mogu biti `legacy`, ali odsustvo prefiksa nije dokaz `legacy` statusa. |

---

## Katalog pogleda

### <Standardna grupa, npr. Eksterni pogledi>

| Pogled | Izvor |
|---|---|
| `<VIEW_NAME>` | `@01-database/04-view/<source_fajl>.sql` |

---

## Napomena

Nema evidentiranih problema, gresaka ili neusaglasenosti.

---

## Odrzavanje

- Novi pogled dodati odmah nakon dodavanja u trenutni source.
- Promjenu naziva, standardne grupe ili source putanje azurirati u postojecem
  redu.
- Uklonjeni pogled ukloniti iz kataloga nakon potvrde trenutnog source-a.
- Pogled koji postoji, ali je `legacy`, zadrzati u katalogu.
- Otkriveni ili rijeseni problem azurirati u sekciji `## Napomena`.
- `last_review` azurirati nakon stvarne sadrzajne provjere.
```

---

Koristiti grupe `LOV pogledi`, `APEX kontroler pogledi`, `Eksterni
pogledi`, `Izvjestajni pogledi` i `Ostali pogledi`, ali u konkretnom
katalogu prikazati samo neprazne grupe. Unutar grupe sortirati abecedno. Svaki
trenutno postojeci pogled mora imati tacno jedan red sa direktnom putanjom do
konkretnog source fajla. Tabela koristi samo kolone `Pogled` i `Izvor`;
wildcard redovi i wildcard source putanje nisu dozvoljeni.

U sekciji `## Napomena` zamijeniti tekst o nepostojanju problema konkretnim
zapisima kada katalog ima potencijalni problem, gresku ili neusaglasenost.
Navoditi samo trenutno stanje, bez vodjenja changelog-a.
