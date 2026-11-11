# Oracle deployment alati

Ovaj folder sadrzi genericke pomocne skripte za Flyway/Oracle deployment.
Skripte nisu dovoljne same za sebe: workflow, runner, konekcija, prava i ciljna
okruzenja moraju biti definisani i provjereni u konkretnom projektu.

| Fajl | Namjena |
|---|---|
| `prep4flyway.sh` | Na privremenoj kopiji `01-database/` dodaje broj foldera repeatable migracijama i pretvara podrzane ekstenzije u `.sql` |
| `finalize_deployment.ps1` | Rekompajlira ciljne sheme, zatim provjerava nevalidne objekte |
| `sql/recompile_schema.sql` | Rekompajlira nevalidne objekte jedne Oracle sheme |
| `sql/check_invalids.sql` | Prijavljuje nevalidne objekte i compiler greske jedne sheme |

## Priprema Flyway kopije

Skriptu pokretati samo nad privremenom kopijom DB foldera, nikad nad izvornim
`01-database/` direktorijumom:

```bash
bash 99-deployment/prep4flyway.sh /putanja/do/privremene-kopije
```

Primjer rezultata:

```text
01-database/04-view/R__lov_entity_v.sql
-> R__04_lov_entity_v.sql

01-database/05-packages/R__entity_pkg.spc
-> R__05_entity_pkg_01_spc.sql
```

Skripta ignorise `.gitkeep`, README i fajlove koji ne prate R/V konvenciju.
Prekida rad ako bi preimenovanje pregazilo postojeci fajl.

## Zavrsna Oracle provjera

`finalize_deployment.ps1` koristi sljedece environment promjenljive:

- `FLYWAY_URL` u obliku `jdbc:oracle:thin:@<connect_identifier>`;
- `FLYWAY_USER`;
- `FLYWAY_PASSWORD`.

Potreban je SQL*Plus u `PATH`, ili se zadaje `-SqlPlusCommand`.

Provjera konfiguracije bez spajanja na bazu:

```powershell
& .\99-deployment\finalize_deployment.ps1 -Schemas @('{{DB_SCHEMA}}') -ValidateOnly
```

Rekompajliranje i provjera:

```powershell
& .\99-deployment\finalize_deployment.ps1 -Schemas @('{{DB_SCHEMA}}')
```

Za vise shema proslijediti kompletnu listu. Skripta prvo pokusava
rekompajliranje svih shema, zatim provjerava sve sheme i na kraju prijavljuje
zbirni rezultat.

## Sigurnosna pravila

- Deployment pokretati samo u eksplicitno odabranom i autorizovanom okruzenju.
- Tajne drzati u secret store-u workflow platforme, nikad u repozitorijumu.
- Prije `CREATE OR REPLACE` uporediti lokalni repeatable izvor sa definicijom u bazi.
- Ne mijenjati vec primijenjene versioned migracije radi prikrivanja checksum razlike.
- Neuspjesna zavrsna provjera ne vraca automatski vec izvrsene DDL promjene.

