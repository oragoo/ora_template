# {{PROJECT_NAME}} - smjernice za rad na projektu

## Projektni identitet

- Naziv: `{{PROJECT_NAME}}`
- Slug: `{{PROJECT_SLUG}}`
- Repozitorijum: `{{REPOSITORY_NAME}}`
- DB shema, ako se koristi Oracle: `{{DB_SCHEMA}}`

## Trenutno stanje

Ovo je pocetna osnova projekta. Poslovni obim, arhitektura, aplikacijski stack,
runtime okruzenja i nacin isporuke nisu definisani dok se ne dokumentuju iz
provjerenih izvora.

## Obavezni pocetni kontekst

Prije izmjena procitati:

1. `README.md`;
2. ovaj dokument;
3. `00-ai/_index.md`;
4. standard i izvorni kod relevantan za konkretan zadatak.

## Smjernice za rad

- Projektnu dokumentaciju i komunikaciju pisati na srpskom jeziku, latinicom.
- Nazive u kodu pisati na engleskom i pratiti konvencije odabranog stacka.
- Cinjenice zasnivati na pregledanom izvoru; pretpostavke jasno oznaciti.
- Izmjene drzati usmjerenim na konkretan zadatak, bez nepovezanih refaktorisanja.
- Birati jednostavna rjesenja i uvoditi zavisnosti samo uz jasnu potrebu.
- Vazne odluke, ogranicenja i pretpostavke zapisati u dokumentaciju.
- Ne predstavljati planirane foldere, servise ili integracije kao postojece.
- Nakon izmjene navesti sta je uradjeno, kako je provjereno i sta ostaje otvoreno.

## Standardi

Ulazna tacka je `00-ai/10-ai-standards/_index.md`. Primjenjivati samo standarde
koji odgovaraju stvarno odabranim tehnologijama. Oracle, Flyway, APEX i React
pravila nisu dokaz da projekat koristi te tehnologije.

## Izvorni folderi

- Oracle/Flyway izvori, ako se koriste: `01-database/`.
- Oracle APEX aplikacije, ako se koriste: `02-apex/applications/`.
- Deployment alati i skripte: `99-deployment/`.

Postojanje praznog template foldera nije dokaz da je tehnologija uvedena.

## Git

- Polazna grana je `main`.
- Radne grane imenovati opisno, npr. `feat/customer-search`,
  `fix/request-validation` ili `docs/architecture`.
- Prije izmjene pregledati status i ne prepisivati tudje lokalne izmjene.
- Ne mijenjati istoriju niti brisati podatke bez eksplicitnog dogovora.
- Commit poruke treba kratko da opisuju jednu povezanu cjelinu.

## Podaci i tajne

- Ne unositi stvarne osjetljive ili produkcijske podatke u kod, testove ili dokumentaciju.
- Koristiti sinteticne testne podatke.
- Tajne cuvati van repozitorijuma.
- Ne upisivati osjetljive podatke u logove, screenshotove ili poruke o greskama.

## Provjera

Build, lint i test komande dodati tek kada budu uvedene i provjerene. Za svaku
izmjenu pokrenuti najuzu relevantnu provjeru, pregledati diff i ne tvrditi da je
provjera izvrsena ako nije mogla biti pokrenuta.

