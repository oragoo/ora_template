# Oracle database izvori

Ovaj folder je predlozena struktura Oracle izvora i Flyway migracija. Koristiti
je samo ako projekat radi sa Oracle bazom. Ciljna shema je `{{DB_SCHEMA}}`, osim
ako projektna dokumentacija definise drugacije.

## Struktura

| Folder | Sadrzaj |
|---|---|
| `00-setup/` | Pocetno postavljanje, pomocni setup i kontrolisane infrastrukturne promjene |
| `01-synonyms/` | Sinonimi |
| `02-tables/` | Tabele, constrainti i versioned izmjene tabela |
| `03-sequences/` | Sekvence |
| `04-view/` | Pogledi |
| `05-packages/` | Paketi, samostalne procedure i funkcije |
| `06-types/` | Oracle tipovi |
| `07-triggers/` | Triggeri |
| `08-grants/` | Grantovi i druga prava |
| `09-data/` | Kontrolisani sifarnici i idempotentni podaci |

`.gitkeep` fajlovi samo cuvaju praznu strukturu u Gitu. Nisu migracije i
`99-deployment/prep4flyway.sh` ih ignorise.

## Flyway nazivi

Versioned migracije:

```text
V<YYYYMMDDHH24MI>__<kratak_opis>.sql
```

Primjer:

```text
V202611111430__create_example_table.sql
```

Versioned migraciju ne mijenjati nakon sto je commitovana i primijenjena.

Repeatable izvori:

| Tip | Format |
|---|---|
| SQL objekat ili podatak | `R__<naziv>.sql` |
| Package spec | `R__<naziv>.spc` |
| Package body | `R__<naziv>.bdy` |
| Procedura | `R__<naziv>.prc` |
| Funkcija | `R__<naziv>.fnc` |
| Trigger | `R__<naziv>.trg` |
| Type spec | `R__<naziv>.tps` |
| Type body | `R__<naziv>.tpb` |

Nazive poslije `R__` pisati malim slovima. Jedan izvorni fajl treba da
predstavlja jedan Oracle objekat ili jednu jasno ogranicenu data cjelinu.

## Prije dodavanja izvora

1. Potvrditi stvarnu shemu i zavisnosti objekta.
2. Izabrati odgovarajuci folder i R/V tip migracije.
3. Provjeriti standarde u `@00-ai/10-ai-standards/50-coding-standards/`.
4. Ne unositi tajne, produkcijske izvoze ni stvarne osjetljive podatke.
5. Dokumentovati novu strukturu ili ugovor u pogodjenom RAG dokumentu.

