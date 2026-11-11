---
project: "{{PROJECT_SLUG}}"
id: WORKFLOW_GUIDE_WRITING_STANDARDS
type: standard
tags: [standard, user-docs, workflow, documentation, writing]
last_review: 2026-10-05
---

# Standardi za pisanje workflow guide dokumenata

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; `<apex-source>` treba zamijeniti
stvarnom lokacijom izvoza. APEX aplikacija jos nije dodana u repozitorijum.

Ovaj dokument definise kako pisati `workflow_guide` dokumente za APEX
aplikacije u `@00-ai/80-user-documentation/apex/`, ako se koristi APEX.
Ova lokacija je planirana; korisnicka dokumentacija jos nije kreirana.

`workflow_guide` opisuje jedan zaokruzen poslovni proces od pocetka do kraja,
kroz onoliko ekrana koliko je stvarno potrebno. Ne opisuje polja, dugmad ni
regione pojedinacnog ekrana - to je posao `screen_reference` dokumenta i ne
ponavlja se.

Koristi ga kada:
- opisujes kompletan poslovni proces koji prelazi vise ekrana ili vise
  aplikacija
- korisnika ne zanima pojedinacni ekran nego "kako da zavrsim ovaj posao"
- vec postoje `screen_reference` dokumenti za pojedinacne ekrane, a
  nedostaje veza koja objasnjava redoslijed i poslovnu logiku izmedju njih

Ako postoji konflikt izmedju ovog dokumenta i opsteg standarda u
`@00-ai/10-ai-standards/40-user-documentation-standards/user_doc_writing_standards.md`,
za `type: workflow_guide` prednost ima ovaj dokument. Frontmatter i opsta
workspace pravila i dalje se uzimaju iz opsteg standarda.

Ovaj dokument pokriva **APEX** procese (`screens` polje i `Tok` koraci
referenciraju APEX page ID). Za React (web/desktop/mobile) aplikacije iz
`<react-source>/` koristi sadrzaj/sekcije odavde, ali naming razlike iz
`@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md`.

---

## Granica prema drugim tipovima dokumenata

| Tip | Pitanje na koje odgovara |
|---|---|
| `screen_reference` | Sta je na ovom ekranu i sta se na njemu moze uraditi? |
| `user_guide` | Kako radi jedna funkcionalnost? |
| `workflow_guide` | Kako da uradim ovaj posao? |

Test: ako se opis moze napisati bez pominjanja bar dva ekrana, to nije
workflow - onda je u pitanju `screen_reference` ili `user_guide`.

Ne ponavljaj sadrzaj `screen_reference` dokumenata. Ako se u workflow-u
nabrajaju polja ili dugmad ekrana, workflow je pogresno napisan - na ekran se
upucuje (linkom na njegov `screen_reference` dokument ili nazivom), ne
opisuje se ponovo.

---

## Lokacija i naziv fajla

- Lokacija: `@00-ai/80-user-documentation/apex/f<NNN>_<naziv>/workflows/`
- Naziv fajla: engleski, mala slova, podvlaka umjesto razmaka - npr. `forum.md`,
  `appointment_booking.md`, `planner.md`
- Sadrzaj dokumenta: srpski, latinica
- Jedan fajl po logickoj cjelini procesa, ne po pojedinacnom zadatku ili
  tiketu

---

## Preporuceni frontmatter

```yaml
---
id: USER_<APP>_WORKFLOW_<NAZIV>
type: workflow_guide
app: <app>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
screens: ["00002", "00003", "00004", "00026"]
status: draft
owner: <vlasnik>
last_review: <datum>
outputs: [pdf, docx]
---
```

Pravila za polje `screens`:
- navodi APEX ID-jeve svih stranica obuhvacenih ovim procesom, istim
  zero-padded formatom kao u nazivu `screen_reference` fajla (`page_<ID>.md`)
- vrijednosti MORAJU biti kvotovane kao stringovi (`"00002"`, ne `00002`) -
  nekvotovan broj sa vodecom nulom YAML moze protumaciti kao oktalni broj ili
  izgubiti vodecu nulu, cime se gubi veza sa stvarnim ID-jem stranice
- ovo polje je za workflow ono sto je `Izvorni fajl` za `screen_reference` -
  masinski trag ka izvoru, ne slobodan opis

---

## Obavezna struktura

Odmah ispod H1 naslova, prije prve sekcije, obavezna je tabela obuhvacenih
ekrana:

```markdown
| Ekran | Uloga u procesu |
|---|---|
| `page_00012` | pregled i ulaz u posao |
| `page_00034` | unos |
```

Svaki `workflow_guide` mora imati najmanje:
- tabelu obuhvacenih ekrana (ispod H1)
- `## Kada se koristi`
- `## Uloge u procesu`
- `## Tok`
- `## Odluke koje covjek mora donijeti`
- `## Sta kad podje naopako`
- `## Pitanja za tim`
- `## Izvor znanja`

Preporucene sekcije:
- `## Preduslovi`
- `## Varijante i izuzeci`
- `## Povezani procesi`

---

## Kako pisati sekcije

### `## Kada se koristi`

Objasni i kada se proces koristi i, podjednako vazno, kada se NE koristi -
ovdje se povlaci granica prema drugim slicnim procesima (npr. "kad radni
zadatak, a kad tema").

### `## Uloge u procesu`

Navedi ko sta radi i ko sta smije u ovom procesu. Ako proces prelazi vise
uloga ili timova, jasno razdvoji odgovornost po koraku.

### `## Tok`

Numerisani koraci. Svaki korak navodi na kom se ekranu desava, ali ne
opisuje polja tog ekrana - samo se referencira.

Format koraka:

```markdown
3. Na ekranu **Kreiranje radnog zadatka** (`page_00034`) popunjavate ...
```

Pisi redoslijedom posla, ne redoslijedom ekrana - posao cesto pocne u jednoj
aplikaciji, a zavrsi u drugoj.

### `## Odluke koje covjek mora donijeti`

Pravila koja se ne vide iz softvera: sta znaci koji stepen hitnosti, kako se
bira rok, sta mora pisati u opisu. Ovo nije `Business rules` iz
`screen_reference` standarda (potvrdjeno ponasanje sistema) - ovo je ljudska
procjena koju sistem ne provjerava niti primorava.

Ako pravilo nema izvor (ko ga je dao i kada), ne pisi ga kao cinjenicu - vidi
`## Izvor znanja`.

### `## Sta kad podje naopako`

Najcesce greske u procesu i sta se tada radi. Poznate greske softvera ne
idu ovdje kao spisak kvarova - izuzetak su greske koje bi korisnika navele da
pomisli da je on pogrijesio, njih treba objasniti.

### `## Pitanja za tim`

Isto pravilo kao u `screen_reference` standardu: konkretno, provjerljivo,
fokusirano na proces. Nepoznato ide ovdje, nikad kao pretpostavka u tekstu.

### `## Izvor znanja`

`screen_reference` prati sha256 izvornog koda kroz `## Watermark izvora`.
Workflow to ne moze, jer mu je izvor covjek, ne fajl. Umjesto toga:

```markdown
## Izvor znanja

| Sta | Ko je dao | Datum |
|---|---|---|
| pravila odlucivanja u procesu | <ime, uloga> | <datum> |
| provjera toka na aplikaciji | <ime> | <datum> |
```

Ovo je jedina zastita od zastarjelog uputstva - promjena poslovnog pravila ne
mijenja nijedan fajl u repozitorijumu, pa je nista automatski ne bi
prijavilo. Bez ove tabele dokument nema nacin da signalizira da je zastario.

---

## Pravila pisanja

- Ne ponavljaj sadrzaj `screen_reference` dokumenata.
- Pisi redoslijedom posla, ne redoslijedom ekrana.
- Ono sto se ne vidi iz softvera mora imati izvor u `## Izvor znanja`.
- Poznate greske ne idu u tekst kao spisak kvarova - izuzetak su greske koje
  bi korisnika navele da pomisli da je on pogrijesio.
- Nepoznato ide u `## Pitanja za tim`, nikad kao pretpostavka.

---

## Pracenje pokrivenosti stranica workflow dokumentima

Polje `screens` iz frontmattera svakog `workflow_guide` dokumenta je izvor
za racunanje koje `page_<ID>` stranice aplikacije JESU, a koje NISU obuhvacene
nijednim workflow-om:

- pokrivena stranica = njen ID se pojavljuje u `screens` polju najmanje jednog
  `workflow_guide` dokumenta te aplikacije
- nepokrivena stranica = ima `screen_reference` dokument (ili postoji u
  APEX exportu), ali se ne pojavljuje ni u jednom `screens` polju

Ovaj podatak se ne racuna u glavni procenat pokrivenosti stranica u
`@00-ai/80-user-documentation/apex/_index.md` (koji prati
samo `screen_reference` pokrivenost) - prati se odvojeno, po aplikaciji, u
istom `_index.md` fajlu te aplikacije gdje se nabraja i sadrzaj `workflows/`
foldera.

Nepokrivena stranica nije nuzno greska - moze biti tehnicka/framework
stranica bez poslovnog procesa. Ali ako stranica ima znacajan poslovni tok, a
nije ni u jednom workflow-u, to je kandidat da se ili doda u postojeci
workflow ili da se otvori novi.

---

## Kontrolna lista prije statusa `review`

- Naziv fajla je engleski, mala slova, podvlaka, bez proizvoljnog opisnog
  nastavka.
- `screens` polje postoji i sve vrijednosti su kvotovane kao stringovi.
- Tabela obuhvacenih ekrana postoji ispod H1 i odgovara `screens` polju.
- Dokument ne ponavlja polja/dugmad vec dokumentovana u `screen_reference`
  fajlovima - samo referencira ekran.
- `## Odluke koje covjek mora donijeti` ne sadrzi pravilo bez izvora.
- `## Izvor znanja` je popunjen za svako pravilo koje ne dolazi iz koda.
- Otvorena pitanja su izdvojena u `## Pitanja za tim`.
