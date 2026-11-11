---
project: "{{PROJECT_SLUG}}"
id: RAG_TEMPLATE_SYNONYMS_CATALOG
type: template
tags: [rag, template, oracle, synonyms, catalog]
last_review: 2026-10-05
---

# Template RAG kataloga sinonima (synonyms.md)

Ako postoji konflikt izmedju ovog template-a i
`@00-ai/10-ai-standards/30-technical-documentation-standards/oracle_synonyms_catalog_rag_writing_standards.md`,
prednost ima standard.

Naziv fajla: `@00-ai/40-technical-documentation/01-database/01-oracle/<schema>/synonyms.md`

Ovaj fajl je navigacioni katalog - source u
`@01-database/01-synonyms/` ostaje autoritativan.
DB objekti su direktno u `@01-database/` podfolderima po tipu objekta.
Shema se utvrdjuje iz DDL-a; nema numerisanih foldera po shemama.

```yaml
---
id: <SCHEMA>_SYNONYMS
type: schema_doc
schema: <SCHEMA>
tags: [<schema_malo>, synonyms, index]
last_review: YYYY-MM-DD
---
```

```markdown
# <SCHEMA> - Katalog sinonima

## Izvor istine

`@01-database/01-synonyms/`

---

## Kako koristiti katalog

Katalog predstavlja pregled svih trenutno postojecih lokalnih sinonima i
njihovih ciljnih objekata. Za detalje definicije provjeriti SQL source.
Konkretna mjesta upotrebe, kada su potrebna, utvrditi pretragom repozitorija.

---

## Konvencije i opsta pravila

- Lokalni sinonim predstavlja tehnicku vezu prema ciljnom objektu, ali ne
  dokazuje aktivnu runtime upotrebu.
- Sve sinonime brojati prema vlasnickoj shemi ciljnog objekta.
- Kriticne API sinonime odvojiti od ostalih sinonima bez dupliciranja reda.
- Ciljni objekat zapisati u DDL obliku, po pravilu
  `<VLASNICKA_SCHEMA>.<OBJECT_NAME>`.
- Remote ili nepotpuno kvalifikovane ciljeve voditi u grupi `Ostali ciljevi`
  i objasniti u sekciji `## Napomena` kada vlasnik nije potvrdjen.
- Public synonym-e i grantove provjeravati odvojeno u
  `@01-database/08-grants/`.

---

## Grupe zavisnosti

| Ciljna shema | Broj sinonima |
|---|---:|
| `<VLASNICKA_SCHEMA>` | <BROJ> |

---

## Kriticni API sinonimi

| Sinonim | Ciljni objekat | Izvor |
|---|---|---|
| `<SCHEMA_API>` | `<VLASNICKA_SCHEMA>.<API_OR_INTERFACE_PACKAGE>` | `@01-database/01-synonyms/<source_fajl>.sql` |

---

## Ostali sinonimi

### <VLASNICKA_SCHEMA>

| Sinonim | Ciljni objekat | Izvor |
|---|---|---|
| `<SYNONYM_NAME>` | `<VLASNICKA_SCHEMA>.<OBJECT_NAME>` | `@01-database/01-synonyms/<source_fajl>.sql` |

---

## Napomena

Nema evidentiranih problema, gresaka ili neusaglasenosti.

---

## Odrzavanje

- Novi sinonim dodati odmah nakon dodavanja u trenutni source.
- Promjenu naziva, ciljnog objekta, grupe ili source putanje azurirati u
  postojecem redu.
- Nakon svake promjene azurirati broj u `## Grupe zavisnosti`.
- Uklonjeni sinonim ukloniti nakon potvrde trenutnog source-a.
- Otkriveni ili rijeseni problem azurirati u sekciji `## Napomena`.
- Prije brisanja ili preusmjeravanja sinonima pretraziti reference u kodu.
- `last_review` azurirati nakon stvarne sadrzajne provjere.
```

---

U `## Grupe zavisnosti` navesti broj svih sinonima po ciljnoj shemi.
`## Kriticni API sinonimi` sadrzi cross-schema sinonime prema API i
interface paketima drugih shema, potvrdjene DDL-om i obrascem `*_API`,
`*_API_PKG` ili `*_INTERFACE_PKG`. Sve preostale sinonime navesti u
`## Ostali sinonimi` i grupisati po ciljnoj shemi.

Ako nema kriticnih API sinonima, umjesto tabele navesti:
`Nema evidentiranih kriticnih API sinonima.`

Svaki trenutno postojeci sinonim mora imati tacno jedan detaljni red sa
DDL-potvrdjenim ciljnim objektom i direktnom putanjom do source fajla. Ne
duplicirati kriticni API sinonim medju ostalim sinonimima. Detaljne tabele
koriste samo kolone `Sinonim`, `Ciljni objekat` i `Izvor`.

U sekciji `## Napomena` zamijeniti tekst o nepostojanju problema konkretnim
zapisima kada katalog ima potencijalni problem, gresku ili neusaglasenost.
Navoditi samo trenutno stanje, bez vodjenja changelog-a.
