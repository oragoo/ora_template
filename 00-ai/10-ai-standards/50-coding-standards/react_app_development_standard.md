---
project: "{{PROJECT_SLUG}}"
id: REACT_APP_DEV_STANDARD
type: standard
tags: [standard, react, frontend, api, {{PROJECT_SLUG}}]
last_review: 2026-10-05
---

# Standard razvoja React aplikacija za {{PROJECT_NAME}}

## Status i primjena

Ovaj standard se primjenjuje ako React bude odabran za korisnicki interfejs
{{PROJECT_NAME}} projekta. React aplikacija, API ugovor, autentifikacija, deployment i
lokacija izvornog koda jos nisu definisani u repozitorijumu.

`<react-source>` je placeholder za buduci root aplikacije. Ne kreirati
aplikaciju, posebne DB sheme, REST module ili registre aplikacijskih brojeva
samo zato sto se pojavljuju u primjeru standarda. Odluke zapisati uz prvi
konkretan zadatak. Opste smjernice: `@AGENTS.md` i `@00-ai/_index.md`.

---

## Organizacija koda

Odgovornosti razdvojiti u okviru stvarne aplikacije:

| Cjelina | Odgovornost |
|---|---|
| Stranice i komponente | Prikaz, navigacija i korisnicke akcije |
| Hooks i stanje | Koordinacija podataka i lokalno UI stanje |
| Servisi | Pozivi potvrdenih API operacija i mapiranje odgovora |
| API klijent | Transport, timeout i zajednicka obrada gresaka |
| Tipovi i validacija | Ugovori podataka i provjere unosa |
| Platformski adapteri | Samo razlike potrebne za odabranu platformu |

Ne uvoditi foldere, biblioteke ili slojeve bez stvarne potrebe. Poslovna
pravila koja stite podatke moraju biti provjerena na serveru, cak i kada
klijent vec validira unos. UI ne sadrzi direktan SQL ni tajne za pristup bazi.

Komponente, hooks i servise imenovati prema poslovnoj funkciji, npr.
`AppointmentListPage.tsx`, `useAppointments.ts`, `appointmentService.ts`.
Ovo su ilustracije, a ne postojeci fajlovi. Identifikatori u kodu su na
engleskom; korisnicki tekstovi prate dogovoreni jezik projekta.

---

## Ekrani i API ugovori

Prije povezivanja ekrana sa stvarnim upisom dokumentovati:

- stvarnu operaciju, HTTP metodu i rutu;
- ulazne i izlazne podatke, validacije i format greske;
- identitet korisnika i dozvoljeni obim podataka;
- stranicenje, filtriranje i sortiranje za liste;
- pravila konkurentnih izmjena, ponavljanja zahtjeva i transakcija.

Ne izmisljati API rute ili DB procedure da bi prototip izgledao povezan.
Mock podaci moraju biti sinteticni i jasno oznaceni u razvojnom kontekstu.
Ako se odabere Oracle/ORDS, mapu od rute do paketa potvrditi iz source koda;
standard ne pretpostavlja posebnu API shemu, sinonim ili wrapper paket.
DB objekti ostaju u odgovarajucim `@01-database/` podfolderima.

Ekrane identifikovati stabilnim semantickim nazivom. Primjer:
`AppointmentListPage` -> `appointment-list`, ruta `/appointments`.
Ne dodjeljivati izmisljene APEX ili sistemske brojeve React ekranima.

---

## Stanje i korisnicko iskustvo

- Razlikovati ucitavanje, prazan rezultat, uspjeh, gresku i nedostatak prava.
- Nakon upisa osvjeziti relevantne podatke, bez nepotrebnog resetovanja ekrana.
- Validaciju prikazati uz odgovarajuce polje i sacuvati ispravno unesene vrijednosti.
- Sprijeciti slucajno visestruko slanje istog upisa; pravilo potvrditi i na serveru.
- Prekid zahtjeva, gubitak mreze i istovremenu izmjenu obraditi predvidljivo.
- Kontrole moraju imati jasne oznake, upotrebljiv fokus i rad sa tastaturom.
- Tehnicke poruke prevesti u korisniku razumljiv opis; ne prikazivati interne
  SQL greske ili osjetljive detalje.

---

## Identitet i podaci pacijenata

Autentifikacija, korisnicke uloge i granice pristupa ambulantama definisu se
prije povezivanja sa stvarnim podacima. Sakriveno dugme nije provjera prava;
server provjerava svako citanje i izmjenu.

- U browser ili mobilni bundle ne unositi DB lozinke, servisne tajne ili
  privilegovane tokene.
- Podatke pacijenata i nalaze ne upisivati u konzolu, analitiku, poruke o
  greskama ili razvojne fixture fajlove.
- Nacin cuvanja sesije i eventualni lokalni cache definisati za odabranu
  platformu; ne uvoditi offline kopije medicinskih podataka po pretpostavci.
- Desktop i mobilna aplikacija nisu potvrdeni zahtjevi. Posebne transportne
  slojeve i pristup bazi razmatrati tek kroz konkretan zahtjev i arhitekturu.

---

## Transakcije i greske

Za upise navesti ko upravlja transakcijom, kada se promjena smatra uspjesnom
i sta klijent radi ako ishod zahtjeva nije poznat. Automatski retry upisa
koristiti samo uz potvrdenu idempotentnost operacije.

Logovanje vezati za dogovoreni projektni mehanizam kada bude uveden.
Ne pretpostavljati postojeci logger paket. Tehnicki identifikator zahtjeva
moze olaksati dijagnostiku bez ukljucivanja podataka pacijenta.

---

## Provjera i isporuka

Komande za instalaciju, razvoj, build, lint i testove dokumentovati u
aplikacijskom `README.md` nakon izbora alata. Ne navoditi ih kao postojece
dok konfiguracija nije dodana.

Provjere usmjeriti na stvarne rizike: validaciju, dozvole, glavni tok upisa,
konflikte i greske transporta. CI dodati kada postoje odgovarajuce komande.
Okruzenja, URL-ove, upravljanje tajnama i nacin isporuke dokumentovati iz
potvrdene konfiguracije. Git rad prati `@AGENTS.md`.

---

## Dokumentacija

Planirana lokacija tehnicke dokumentacije React aplikacije je
`@00-ai/40-technical-documentation/02-webapp/01-react/<app>/`.
Kreirati samo dokumente za koje postoji sadrzaj i potreba:

| Fajl | Sadrzaj |
|---|---|
| `overview.md` | Namjena, platforma, vlasnik i obim aplikacije |
| `architecture.md` | Potvrdjena struktura i granice odgovornosti |
| `api_contract.md` | API operacije, podaci, greske i dozvole |
| `screens.md` | Popis ekrana, izvorni fajlovi, rute i API pozivi |
| `decisions.md` | Dogovorene tehnicke odluke i razlozi |
| `deployment.md` | Potvrdjen nacin isporuke i konfiguracije |

Korisnicka dokumentacija planirana je u
`@00-ai/80-user-documentation/react/<app>/`, prema
`@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md`.

README uz aplikaciju sadrzi operativne komande i upucuje na tehnicku
dokumentaciju u `00-ai/`. Ne predstavljati planirane dokumente kao postojece.
