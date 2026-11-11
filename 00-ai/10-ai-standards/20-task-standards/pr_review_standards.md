---
project: "{{PROJECT_SLUG}}"
id: PR_REVIEW_STANDARDS
type: standards
tags: [standards, review, code-review, git, {{PROJECT_SLUG}}]
last_review: 2026-10-05
---

# Standard za pregled izmjena u projektu {{PROJECT_NAME}}

## Svrha i obim

Pregled provjerava konkretan diff, uskladjenost sa zahtjevom i rizike izmjene.
Predmet moze biti lokalna izmjena, grana ili PR. Hosting repozitorijuma, Jira
projektni kljuc i remote grane nisu unaprijed odredjeni ovim standardom.

Polazna grana projekta je `main`. Stvarnu ciljnu granu uvijek provjeriti iz
zahtjeva ili PR-a; ne pretpostavljati da remote ili dodatna razvojna grana postoji.

---

## Priprema pregleda

1. Procitati zahtjev korisnika, relevantni lokalni task i dostupni opis PR-a.
2. Provjeriti `git status --short` i postojece grane. Ne mijenjati radno stablo
   niti uklanjati lokalne izmjene tokom pregleda.
3. Potvrditi koji diff se pregleda: radno stablo, staging ili konkretna grana.
4. Ako postoji Jira referenca, koristiti stvarni puni kljuc. Ne izvoditi
   projektni prefiks iz broja tiketa ili naziva drugog projekta.
5. Nedostajuce kriterijume ili nedostupan izvor zahtjeva navesti kao ogranicenje;
   tehnicki pregled dostupnog koda moze se nastaviti.

Za Jira na ovom okruzenju koristiti konfigurisani `atlassian-mcp-server` i
prvo utvrditi dostupne Atlassian resurse. Ne pretpostavljati konkretan cloud ID,
projekat, alat ili pristup samo na osnovu predloska. Jira nije preduslov za
pregled lokalnih izmjena.

---

## Diff i ciljna grana

Za lokalne izmjene pregledati `git diff` i `git diff --cached`, ukljucujuci
sadrzaj relevantnih novih fajlova. Za granu koristiti potvrdene reference:

```text
git diff <base>...<branch>
```

Ako postoji remote i potreban je pregled prema njegovom trenutnom stanju,
osvjeziti odgovarajuce reference prije poredjenja. Ako remote nije dostupan,
navesti da je pregled uradjen prema lokalnoj referenci i kojoj reviziji.

Za pregled spremnosti grane za spajanje provjeriti i merge konflikte bez
mijenjanja radnog stabla, npr. podrzanom `git merge-tree` komandom. Navesti
stvarni rezultat provjere. Ako provjera nije izvrsena, ne tvrditi da nema
konflikta. Ne raditi merge, rebase ili objavljivanje samo radi pregleda.

---

## Sta provjeravati

### Uskladjenost sa zahtjevom

Uporediti diff sa ciljem, granicama zadatka i kriterijumima prihvatanja.
Razlikovati nedostajucu funkcionalnost, pogresno ponasanje i nepovezane izmjene.
Nepoznata poslovna pravila ne izmisljati.

### Kod i podaci

- Provjeriti stvarne pozive, zavisnosti i definicije objekata koje izmjena koristi.
- Za DB kod traziti izvore u `@01-database/`, u podfolderu odgovarajuceg tipa.
- Primijeniti relevantne standarde iz `@00-ai/10-ai-standards/50-coding-standards/_index.md`.
- Flyway pravila provjeravati samo ako se Flyway koristi.
- Provjeriti validaciju, autorizaciju, granice ambulante, transakcije i obradjene
  greske kada su relevantni za izmjenu.
- Provjeriti da diff ne uvodi stvarne podatke pacijenata ili tajne.
- APEX/React izvore i generisane artefakte procijeniti prema stvarnoj konfiguraciji;
  ne nasljedjivati izuzetke za stare exporte ili instalacijske skripte.

### Dokumentacija

Provjeriti da pogodjeni postojeci dokumenti opisuju novo ponasanje i da njihove
reference vode do stvarnih izvora. Tehnicki RAG dokumenti slijede odgovarajuci
specificni standard iz
`@00-ai/10-ai-standards/30-technical-documentation-standards/_index.md`.
Korisnicka dokumentacija slijedi
`@00-ai/10-ai-standards/40-user-documentation-standards/_index.md`.

Nedostatak dokumenta prijaviti prema kriterijumima zadatka; ne proglasavati
nepostojecu dokumentaciju azuriranom niti zahtijevati nepovezane nove dokumente.

### Provjere

Pregledati relevantne postojece testove i rezultate provjera. Pokrenuti
raspolozive provjere koje imaju smisla za izmjenu i jasno navesti ogranicenja.
Za samu dokumentaciju provjeriti putanje, primjere, frontmatter i diff.

---

## Rezultat i objavljivanje

Nalaze navesti po ozbiljnosti. Svaki nalaz opisuje konkretan problem, njegovu
posljedicu i mjesto u kodu ili dokumentu. Dodati relevantne rezultate provjera
i ogranicenja. Ako nema nalaza, to reci kratko bez tvrdnje da ne postoji rizik.

Pregled sam po sebi ne objavljuje komentar niti odobrava PR. Komentar, odobrenje,
status ili worklog mijenjati samo kada korisnik to zatrazi za jasno odredjeni
cilj. Koristiti potvrdeni servis i stvarni tiket/PR. Prije odobrenja potvrditi
da pregledana revizija i dalje odgovara reviziji koja se odobrava.
