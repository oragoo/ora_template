---
project: "{{PROJECT_SLUG}}"
id: REACT_USER_DOCS_WRITING_STANDARDS
type: standard
tags: [standard, user-docs, react, screen-reference, workflow-guide, documentation, writing]
last_review: 2026-10-05
---

# Standardi za korisnicku dokumentaciju React aplikacija

Ovaj dokument opisuje **razlike** u odnosu na postojece standarde kad se
`screen_reference` ili `workflow_guide` dokument pise za React (web/desktop/
mobile) aplikaciju iz `<react-source>/`, umjesto za APEX aplikaciju.

Ako se React odabere, planirana lokacija korisnickih uputstava je
`@00-ai/80-user-documentation/react/`. `<react-source>` je placeholder za
buducu lokaciju aplikacijskog koda. Aplikacija i uputstva jos ne postoje.

Ne duplira sadrzaj postojecih standarda. Krovni dokumenti ostaju:
- `@00-ai/10-ai-standards/40-user-documentation-standards/user_doc_writing_standards.md`
  - opsta pravila, frontmatter, tipovi dokumenata
- `@00-ai/10-ai-standards/40-user-documentation-standards/screen_reference_writing_standards.md`
  - sadrzaj, sekcije i stil pisanja za `screen_reference`
- `@00-ai/10-ai-standards/40-user-documentation-standards/workflow_guide_writing_standards.md`
  - sadrzaj, sekcije i stil pisanja za `workflow_guide`

Za React aplikaciju koristi **oba** dokumenta (opsti + ovaj), isto kao sto se
za APEX koristi opsti standard zajedno sa APEX-specificnim. Ako postoji
konflikt oko naming-a ili izvora istine, za React prednost ima ovaj dokument;
za sadrzaj/sekcije/stil prednost i dalje ima opsti standard.

Tehnicki kontekst (koji API modul aplikacija koristi, arhitektura,
mapiranje ekran<->webservis) definisan je u
`@00-ai/10-ai-standards/50-coding-standards/react_app_development_standard.md` sekcija "Dokumentacija" i dokumentuje se
u `@00-ai/40-technical-documentation/02-webapp/01-react/<app>/`. Ovaj standard pokriva samo korisnicku
(krajnji-korisnik) stranu dokumentacije.

---

## Sta ostaje identicno kao kod APEX-a

Sve iz oba postojeca standarda vrijedi bez izmjene:

- svih pet/sedam obaveznih sekcija (`Svrha`, `Funkcionalni opis`, `Polja,
  dugmad i akcije`, `Postupci`, `Pitanja za tim` za screen_reference; tabela
  ekrana, `Kada se koristi`, `Uloge u procesu`, `Tok`, `Odluke koje covjek
  mora donijeti`, `Sta kad podje naopako`, `Pitanja za tim`, `Izvor znanja` za
  workflow_guide)
- princip "opisuj samo ono sto je stvarno vidjeno/testirano/potvrdjeno"
- zabrana izmisljanja neotvorenih ekrana, znacenja polja, poslovnih pravila
- AI ne izvrsava samostalno akcije koje mijenjaju stanje (`Sacuvaj`,
  `Potvrdi`, `Obrisi`, `Posalji`, ...)
- stil pisanja (srpski, latinica, kratke recenice, bez `vjerovatno`/
  `pretpostavlja se`)
- `Business rules` sadrzi samo potvrdjena pravila; nepotvrdjeno ide u
  `Pitanja za tim`
- kontrolna lista prije statusa `review`

Jedino se mijenja: **kako se ekran identifikuje i gdje se trazi izvor istine**
- jer React nema APEX page ID ni APEX export SQL fajl.

---

## screen_reference za React

### Naziv fajla i identifikator ekrana

APEX koristi `page_<ID>.md` jer Application Builder automatski dodjeljuje i
garantuje jedinstven broj stranice. React tu garanciju nema (v.
`@00-ai/10-ai-standards/50-coding-standards/react_app_development_standard.md` sekcija "Ekrani i API ugovori" - isti razlog
zbog kojeg React ekrani i webservisi ne dobijaju numericki sufiks).

Zato je identifikator ekrana **naziv React komponente**, izveden u
kebab-case, bez sufiksa `Page`:

| Komponenta u kodu | Naziv fajla dokumenta |
|---|---|
| `AppointmentListPage.tsx` | `appointment-list.md` |
| `RescheduleAppointmentDialog.tsx` | `reschedule-appointment-dialog.md` |

Lokacija: `@00-ai/80-user-documentation/react/<app-folder>/screens/<screen-slug>.md`,
gdje je `<app-folder>` dogovoreni identifikator aplikacije (npr. `{{PROJECT_SLUG}}`),
a `<react-source>` stvarni root njenog koda.

### Frontmatter

```yaml
---
id: USER_<APP>_SCREEN_<SLUG>
type: screen_reference
app: <app-folder>              # npr. {{PROJECT_SLUG}} - isti kao <react-source>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
status: draft
owner: <vlasnik-dokumenta>
last_review: <datum>
outputs: [pdf, docx]
schemas: [<API_SCHEMA>, <SCHEMA1>]   # opciono - sheme stvarno pogodjene ovim ekranom
reviewer: <reviewer>             # opciono
version: <verzija>               # opciono
---
```

`<SLUG>` je UPPER_SNAKE_CASE verzija istog naziva kao naziv fajla - npr.
`appointment-list.md` -> `USER_{{DOC_ID_PREFIX}}_SCREEN_APPOINTMENT_LIST`.

### "Naziv ekrana i izvorni fajl" (zamjena za APEX "Naziv stranice i izvorni fajl")

Odmah ispod H1 naslova, prije `## Svrha`, umjesto APEX obrasca (`p_name` +
`page_<ID>.sql`), navesti:

```markdown
**Naziv ekrana u kodu:** `<PascalCase naziv komponente, npr. AppointmentListPage>`
**Izvorni fajl:** `<react-source>/src/pages/<...>/<Component>.tsx`
**Ruta:** `<route path, npr. /appointments>`
**API poziv:** vidi `@00-ai/40-technical-documentation/02-webapp/01-react/<app-folder>/screens.md`
```

Posljednji red je namjerna razlika od APEX obrasca - umjesto da se ovdje
prepisuje tehnicki poziv, upucuje se na vec postojeci tehnicki dokument
(`screens.md`, definisan u sekciji "Dokumentacija" tehnickog standarda) koji je izvor istine za
mapiranje ekran<->webservis. Ne duplirati tu tabelu ovdje.

### Izvor istine za UI

Za APEX je primarni izvor `@<apex-source>/`. Za React:

1. **Primarni izvor** je stvarna React komponenta (`<react-source>/src/...`)
   i/ili pokrenuta aplikacija (screenshot, live provjera) - ne pretpostavljaj
   ponasanje samo iz naziva komponente ili propova.
2. **Dopunski tehnicki izvor**, kad UI sam ne objasnjava poslovni smisao,
   validacije ili statusni tok: `@00-ai/40-technical-documentation/02-webapp/01-react/<app-folder>/` (posebno
   `screens.md` za API poziv i `api_contract.md` za ugovor/greske), ne
   generalni `@00-ai/40-technical-documentation/01-database/01-oracle/` osim ako `screens.md`/`api_contract.md`
   eksplicitno upucuje dalje na konkretnu semu.

Ostatak plana pisanja (popis potvrdjenih elemenata, planiranje sekcija,
razdvajanje scenarija u `Postupci`, otvorena pitanja u `Pitanja za tim`) je
identican `screen_reference_writing_standards.md` planu - samo se korak 2 i 3
tog plana zamjenjuju gornjim uputstvom.

### Sekcije

Iste kao APEX `screen_reference` (obavezne: napomena + `Svrha` +
`Funkcionalni opis` + `Polja, dugmad i akcije` + `Postupci` + `Pitanja za
tim`; preporucene: ostale). Bez izmjene.

---

## workflow_guide za React

Za `workflow_guide` mijenja se samo **kako se referenciraju ekrani** - sve
ostalo (sekcije, `Izvor znanja`, "ne ponavljaj screen_reference sadrzaj") je
identicno `workflow_guide_writing_standards.md`.

### Lokacija i naziv fajla

- Lokacija: `@00-ai/80-user-documentation/react/<app-folder>/workflows/`
- Naziv fajla: isto pravilo kao APEX - engleski, mala slova, podvlaka (npr.
  `appointment_booking.md`)

### Frontmatter polje `screens`

```yaml
screens: ["appointment-list", "appointment-detail", "reschedule-appointment-dialog"]
```

Umjesto zero-padded APEX ID-ja, `screens` navodi **slug** iz naziva fajla
odgovarajuceg `screen_reference` dokumenta (bez `.md` nastavka). I dalje
MORAJU biti kvotovani kao stringovi (dosljedno postojecem pravilu), iako kod
React sluga nema rizika od gubitka vodece nule - kvotovanje se zadrzava radi
jednog dosljednog obrasca u oba tipa aplikacija.

### Referenciranje ekrana u `## Tok`

```markdown
3. Na ekranu **Lista termina** (`appointment-list`) ...
```

Isti obrazac kao APEX (`page_00034`), samo se broj zamjenjuje slugom.

### Kad proces prelazi APEX i React ekrane

Ako jedan `workflow_guide` obuhvata i APEX i React ekrane (npr. tok u
migraciji, ili proces koji svjesno kombinuje obje platforme), `screens` polje
sadrzi oba oblika identifikatora bez konflikta (razliciti prostori: `page_NNNNN`
nasuprot slug-u bez `page_` prefiksa). U `## Tok` koraku eksplicitno navesti
platformu kad nije ocigledna iz konteksta:

```markdown
5. Na APEX ekranu **Pregled termina** (`page_00034`) provjeravate termin.
6. Na React ekranu **Dolazak pacijenta** (`patient-arrival`) evidentirate dolazak.
   Ovo je ilustracija; stvarni tok potvrditi prije dokumentovanja.
```

---

## Pokrivenost i registar

Analogno APEX registru (`@00-ai/80-user-documentation/apex/_index.md`),
React aplikacije prati `@00-ai/80-user-documentation/react/_index.md`.

Razlika u izvoru istine za "ukupno ekrana":

- APEX: broj jedinstvenih `application/pages/page_*.sql` fajlova
- React: broj redova u `@00-ai/40-technical-documentation/02-webapp/01-react/<app-folder>/screens.md` tabeli
  (to je jedini formalni popis ekrana aplikacije - React nema ekvivalent APEX
  export fajlova po stranici)

"Dokumentovano" se i dalje racuna kao broj `screens/<slug>.md` dokumenata koji
odgovaraju redu iz te tabele. `workflow_guide` pokrivenost prati se odvojeno,
istim principom kao kod APEX-a (sekcija "Pracenje pokrivenosti stranica workflow
dokumentima" u `workflow_guide_writing_standards.md`), samo se "stranica"
cita kao "ekran iz `screens.md`".

---

## Kontrolna lista prije statusa `review` (dopuna za React)

Pored kontrolne liste iz `screen_reference_writing_standards.md`/
`workflow_guide_writing_standards.md`:

- Naziv fajla je kebab-case slug izveden iz naziva komponente, bez brojevnog
  sufiksa.
- `id` frontmatter polje koristi isti slug (UPPER_SNAKE_CASE), ne APEX
  `PAGE_<ID>` obrazac.
- Napomena ispod H1 sadrzi "Naziv ekrana u kodu", "Izvorni fajl", "Ruta" i
  referencu na `screens.md` umjesto APEX `p_name`/`page_<ID>.sql` para.
- `screens` polje u `workflow_guide` koristi slug-ove, kvotovane kao stringovi.
- Dokument nije prepisao `screens.md`/`api_contract.md` sadrzaj - samo
  referencira te fajlove.
