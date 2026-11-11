---
project: "{{PROJECT_SLUG}}"
id: SCREEN_REFERENCE_WRITING_STANDARDS
type: standard
tags: [standard, user-docs, screens, documentation, writing]
last_review: 2026-10-05
---

# Standardi za pisanje screen reference dokumenata

Primjena za {{PROJECT_NAME}}: APEX dio ovog dokumenta vazi samo ako se koristi APEX.
App/Page ID-jevi i primjeri su ilustrativni; source exporti se smjestaju u
`@02-apex/applications/`. Konkretna APEX aplikacija postoji tek kada je njen export dodat u `@02-apex/applications/`.

Ovaj dokument definise kako pisati `screen_reference` dokumente za APEX
aplikacije u `@00-ai/80-user-documentation/apex/`, ako se koristi APEX.
Ova lokacija je planirana; korisnicka dokumentacija jos nije kreirana. Isti obrazac sadrzaja vazi i za React
aplikacije, ako se za {{PROJECT_NAME}} odabere React (vidi
`react_user_docs_writing_standards.md`).

`screen_reference` nije puno korisnicko uputstvo. To je strukturisan opis
jednog ekrana, tab-a, forme, izvjestaja ili dijaloga: sta stranica radi, sta
korisnik na njoj vidi i koje akcije na njoj moze da izvrsi.

Koristi ga kada:
- dokumentujes jedan konkretan ekran ili tab
- pripremas osnovu za kasnije puno korisnicko uputstvo
- pravis bazu za tooltip/help tekstove i AI knowledge base
- treba da zabiljezis potvrdeno ponasanje UI-a bez sirenja na cijeli workflow

Ako postoji konflikt izmedju ovog dokumenta i opsteg standarda u
`@00-ai/10-ai-standards/40-user-documentation-standards/user_doc_writing_standards.md`,
za `type: screen_reference` prednost ima ovaj dokument. Frontmatter i opsta
workspace pravila i dalje se uzimaju iz opsteg standarda.

Ovaj dokument pokriva **APEX** ekrane (naziv fajla i izvor istine su vezani
za APEX page ID i `@02-apex/applications/`). Za React (web/desktop/mobile)
aplikacije iz `<react-source>/` koristi sadrzaj/sekcije/stil odavde, ali naming i
izvor istine iz
`@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md`.

---

## Granica prema drugim tipovima dokumenata

Koristi:
- `screen_reference`
  - za jedan ekran i ono sto se na njemu vidi i radi
- `user_guide`
  - za sire objasnjenje jedne funkcionalnosti ili teme
- `workflow_guide`
  - za end-to-end proces koji prelazi vise ekrana ili aplikacija

Ako korisnik trazi "opis stranice", "opis ekrana" ili "sta stranica radi i sta
se na njoj moze uraditi", podrazumijevani izbor je `screen_reference`.

---

## Osnovni principi

- Opisuj samo ono sto je stvarno vidjeno, testirano ili potvrdeno.
- Ne zakljucuj detaljno ponasanje samo na osnovu naziva dugmeta, polja ili statusa.
- Koristi nazive elemenata tacno onako kako ih korisnik vidi na ekranu.
- Tehnicka implementacija ne ulazi u glavni tekst osim ako korisniku objasnjava
  poslovni efekat ili ogranicenje.
- Ako nesto nije poznato, izdvoji ga u `## Pitanja za tim`.

---

## Dokaz i granice tvrdnji

AI smije koristiti informacije iz:
- trenutno prikazanog ekrana
- prethodno provjerenih ekrana
- objasnjenja korisnika ili domain eksperta
- dokumentovanog i potvrdenog poslovnog pravila
- stvarno izvrsenih i posmatranih akcija

AI ne smije izmisljati:
- sadrzaj neotvorenih ekrana
- znacenje polja koje nije jasno
- poslovna pravila koja nisu potvrdena
- rezultat dugmeta koje nije isprobano ili objasnjeno
- obaveznost polja ako nije vidljiva ili potvrdena
- zavisnosti medju podacima koje nisu potvrdene

Ako je najvjerovatnija interpretacija ipak potrebna za dalji rad, zapisi je kao
pitanje, ne kao cinjenicu.

---

## Preporuceni frontmatter

```yaml
---
id: USER_<APP>_SCREEN_PAGE_<ID>
type: screen_reference
app: <app-ili-cross-app>
module: <modul-ili-proces>
audience: [<uloga1>, <uloga2>]
tags: [<tag1>, <tag2>]
status: draft
owner: <vlasnik-dokumenta>
last_review: 2026-08-13
outputs: [pdf, docx]
schemas: [<SCHEMA1>, <SCHEMA2>]        # opciono
reviewer: <reviewer>                   # opciono
version: <verzija>                     # opciono
---
```

`<ID>` u `id` polju je isti zero-padded APEX ID stranice koji se koristi u
nazivu fajla (npr. `USER_{{DOC_ID_PREFIX}}_SCREEN_PAGE_00033` za `page_00033.md`). Ne
dodavati opisni nastavak u `id` polje (vise se ne koristi obrazac
`USER_{{DOC_ID_PREFIX}}_SCREEN_PAGE33_<TEMA>`).

---

## Preporuceni plan prije pisanja dokumenta

Prije nego sto pocnes pisati `screen_reference`, preporuceno je da napravis
kratak plan rada. Plan ne treba pisati kroz konkretne nazive trenutnih stranica
iz jednog primjera, nego kao apstraktan niz koraka koji vazi za svaki ekran koji
se dokumentuje.

Prakticne ulazne tacke za taj plan su:
- aplikacije i APEX exporti se po pravilu traze u `@02-apex/applications/`
- tehnicka dokumentacija i RAG dopuna se po pravilu traze u `@00-ai/`

Preporuceni redoslijed:

1. Odredi obim dokumentovanja.
   - Provjeri da li dokumentujes jedan ekran, listu, modal, tab ili vise
     odvojenih UI cjelina.
   - Ako postoje dva stvarno odvojena ekrana, npr. pregled lista i posebna
     modalna forma, dokumentuj ih kao odvojene `screen_reference` dokumente,
     ne kao jedan veliki `user_guide`.

2. Odredi lokaciju i nazive fajlova.
   - Za APEX aplikacije, dokumente smjestaj u odgovarajuci aplikativni folder
     u `@00-ai/80-user-documentation/apex/`, npr.
     `@00-ai/80-user-documentation/apex/f<app>_<naziv>/screens/`.
   - Za React aplikacije (trenutno bez postojeceg workspace-a u repou), vidi
     predlog lokacije u `react_user_docs_writing_standards.md`.
   - Naziv fajla NIJE proizvoljan opis teme niti parafraza naziva stranice -
     mora biti IDENTICAN nazivu izvornog APEX fajla stranice.
   - Format: `page_<ID>.md`, gdje je `<ID>` tacno onoliko cifara koliko ima
     izvorni fajl `@02-apex/applications/f<app>/application/pages/page_<ID>.sql`
     (APEX ID stranice, zero-padded na 5 cifara - npr. stranica 33 -> izvor
     `page_00033.sql` -> dokument `page_00033.md`; stranica 2 -> `page_00002.sql`
     -> `page_00002.md`; stranica 8000 -> `page_08000.sql` -> `page_08000.md`).
     Nema dodatnog opisnog nastavka u nazivu fajla.
   - Opisni/poslovni naziv stranice (ono sto je nekad islo u naziv fajla, npr.
     "zakazivanje_termina") vise se NE koristi u nazivu fajla - ide
     iskljucivo u H1 naslov dokumenta i u napomenu "Naziv stranice i izvorni
     fajl" opisanu nize u ovom standardu.

3. Potvrdi source of truth za UI.
   - Primarni izvor treba da bude stvarni ekran, APEX export, provjereni UI
     artifact ili drugi direktni izvor strukture stranice.
   - Kod APEX aplikacija, podrazumijevana lokacija za UI izvor je
     `@02-apex/applications/`.
   - Prije pisanja potvrdi najmanje: naziv ekrana, regione, kolone, polja,
     dugmad, navigaciju i poznate tokove otvaranja povezanih ekrana.

4. Dopuni plan tehnickom dokumentacijom kada je potrebna.
   - Ako sam UI ne objasnjava dovoljno poslovni smisao, validacije, ogranicenja
     ili statusni tok, koristi dopunski tehnicki izvor.
   - Dopusteni dopunski izvori su npr. RAG dokumentacija, package dokumenti,
     dokumentacija tabela, provjereni view-evi ili drugi potvrdeni interni
     artefakti.
   - Podrazumijevana lokacija za ovu dopunu je `@00-ai/`.
   - Tehnicka dokumentacija sluzi da pojasni potvrdeni poslovni kontekst, a ne
     da zamijeni stvarni UI kao primarni izvor.

5. Popisi potvrdene elemente po ekranu prije samog pisanja.
   - Za svaki ekran unaprijed zabiljezi sta je vec potvrdeno:
     naziv stranice, tip ekrana, regioni, kolone, forma polja, dugmad,
     navigacija, statusne akcije, modalni tok i poznato ponasanje nakon akcije.
   - Kod kompleksnih ekrana korisno je elemente grupisati po regionima ili po
     dijalozima prije nego sto se prenesu u dokument.
   - Ako ekran ima child sekcije, u planu posebno popisi sta svaka child
     sekcija radi, koje podatke ili kolone prikazuje ili odrzava, da li je
     pregledna ili editabilna i da li vodi na poseban detaljni ekran.

6. Planiraj dokument po standardnoj strukturi.
   - Kao minimum pripremi:
     `## Svrha`, `## Funkcionalni opis`, `## Polja, dugmad i akcije`,
     `## Postupci`, `## Pitanja za tim`.
   - Po potrebi dopuni i:
     `## Kome je namijenjeno`, `## Navigacija`, `## Preduslovi`,
     `## Business rules`, `## Povezani ekrani`,
     `## Uocena ponasanja i moguci problemi`, `## Najcesce greske / FAQ`.

7. U `## Postupci` unaprijed razdvoji scenarije rada.
   - Za svaki ekran planiraj odvojene scenarije kao sto su:
     pregled liste, otvaranje detalja, unos novog zapisa, izmjena postojeceg
     zapisa, brisanje, odustajanje bez snimanja ili statusna obrada.
   - Ne spajaj vise razlicitih korisnickih tokova u isti numerisani niz ako je
     korisniku preglednije da budu odvojeni.

8. U `## Pitanja za tim` ostavi samo ono sto nije potvrdeno.
   - Tu idu otvorena pitanja koja se ne vide iz UI izvora ni iz dopunske
     tehnicke dokumentacije.
   - Tipicni primjeri su: tacna putanja kroz meni, poslovna razlika izmedju dva
     slicna polja, pravilo jedinstvenosti, ogranicenja brisanja, izvor podataka
     iz integracije ili tacan rezultat statusne akcije.

Ovaj plan je preporuceni radni obrazac za sve buduce screen dokumente. Ne treba
ga kopirati sa nazivima iz prethodnog konkretnog primjera, nego ga treba
primjenjivati kao opste pravilo.

---

## Obavezna struktura

Odmah ispod H1 naslova, prije `## Svrha`, obavezno navesti kratku napomenu
"Naziv stranice i izvorni fajl" (vidi sekciju nize kako je pisati).

Svaki `screen_reference` treba da ima najmanje:
- Napomenu "Naziv stranice i izvorni fajl" (ispod H1, prije `## Svrha`)
- `## Svrha`
- `## Funkcionalni opis`
- `## Polja, dugmad i akcije`
- `## Postupci`
- `## Pitanja za tim`

Preporucene sekcije:
- `## Kome je namijenjeno`
- `## Navigacija`
- `## Preduslovi`
- `## Business rules`
- `## Povezani ekrani`
- `## Uocena ponasanja i moguci problemi`
- `## Najcesce greske / FAQ`

Ako sekcija nema sadrzaj, moze se izostaviti osim pet osnovnih sekcija.

---

## Kako pisati sekcije

### Naziv stranice i izvorni fajl

Odmah ispod H1 naslova, prije `## Svrha`, navedi dva reda:

```markdown
**Naziv stranice u izvoru:** `<p_name iz create_page bloka>`
**Izvorni fajl:** `@02-apex/applications/f<app>/application/pages/page_<ID>.sql`
```

Pravila:
- `Naziv stranice u izvoru` je doslovan `p_name` (ili `p_alias` ako `p_name`
  nije koristan) iz `wwv_flow_imp_page.create_page` bloka za tu stranicu - ne
  parafraziraj ga i ne ispravljaj.
- `Izvorni fajl` je stvarna putanja do tog `page_<ID>.sql` fajla u repou - isti
  `<ID>` (zero-padded) koji se koristi u nazivu dokumenta (`page_<ID>.md`) i u
  `id` polju frontmattera (`USER_<APP>_SCREEN_PAGE_<ID>`).
- Ovo je odvojeno od `## Watermark izvora` (koji nabraja SVE izvore koriscene
  za sadrzaj dokumenta, sa hesevima). Ova napomena postoji da odmah, na prvi
  pogled, poveze naziv fajla dokumenta sa stvarnim izvorom - ne zamjenjuje
  watermark tabelu ako je dokument dovoljno kompleksan da je ima.
- Ako poslovni/UI naziv kojim korisnici zovu ekran odstupa od naziva iz izvora
  (npr. naslov regiona na ekranu je drugaciji, ili izvor ima gramaticku gresku),
  to izricito napomeni u jednoj recenici ispod ova dva reda, npr.:
  `Napomena: naslov regiona na ekranu je "X", stvarni naziv stranice u izvoru je "Y".`

### `## Svrha`

U 1-3 recenice objasni:
- cemu ekran sluzi
- koji poslovni zadatak korisnik tu obavlja
- sta moze da pregleda, unese, promijeni ili pokrene

Pisi iz ugla korisnika, ne iz ugla tabele, paketa ili APEX implementacije.

### `## Kome je namijenjeno`

Navedi samo potvrdene role ili tipove korisnika. Ako nije poznato, ne
pretpostavljaj.

### `## Navigacija`

Navedi odakle se ekran otvara i na koji naziv menija, stranice ili taba korisnik
treba da obrati paznju, ako je to poznato.

### `## Preduslovi`

Navedi samo stvarne uslove za upotrebu ekrana:
- potrebne role ili prava
- podatke koji moraju postojati unaprijed
- statusni ili kontekstualni uslov

### `## Funkcionalni opis`

Objasni glavne cjeline ekrana:
- regione, tabove, grideve, filtere, dijaloge i toolbar akcije
- sta korisnik u kojoj cjelini pregleda ili mijenja
- sta je read-only, a sta editabilno, ako je potvrdeno
- ako ekran ima child sekcije, za svaku objasni sta poslovno predstavlja i
  koje podatke korisnik u njoj vidi, odrzava ili otvara dalje

Ako ekran ima vise cjelina, koristi podsekcije po regionu ili po dijalogu.

### `## Polja, dugmad i akcije`

Za svaki znacajan element napravi zapis u tabeli.

Preporuceni format:

```markdown
| Element | Kratki opis | Duzi opis | Pitanje / nejasnoca |
|---|---|---|---|
| `Status` | Prikazuje trenutni status zapisa. | Pokazuje u kojoj je fazi dokument i koji skup akcija je dostupan korisniku. | Da li svi statusi imaju isti skup dozvoljenih akcija? |
```

Pravila:
- kolona `Element`
  - koristi naziv koji korisnik vidi na ekranu
- kolona `Kratki opis`
  - jedna kratka recenica pogodna za tooltip ili inline help
- kolona `Duzi opis`
  - objasnjava cemu element sluzi, kada se koristi i sta radi
- kolona `Pitanje / nejasnoca`
  - koristi `-` samo kad zaista nema otvorene nejasnoce
- ako ekran ima child sekcije
  - nije dovoljno samo navesti da sekcija postoji
  - treba opisati sta sekcija konkretno radi i koje glavne podatke, kolone ili
    tipove zapisa korisnik u njoj vidi ili odrzava
  - ako child sekcija vodi na drugi ekran ili modal, i to treba eksplicitno
    navesti

Ako je ekran kompleksan, tabelu smijes podijeliti po regionima ili dijalozima.

### `## Postupci`

Opisi glavne korisnicke postupke koji se mogu izvrsiti na toj stranici.

Pravila:
- koraci moraju pratiti stvarni redoslijed rada
- ne mijesaj vise scenarija u isti numerisani niz
- ne dodaji korake koji nisu vidjeni ili potvrdeni

Ako akcija vodi na drugi ekran, koristi format:

```markdown
Dalje na ekranu: **Naziv ekrana**
```

Ne opisuj naredni ekran dok nije otvoren i dokumentovan.

### `## Pitanja za tim`

Na kraju objedini sva otvorena pitanja.

Pitanja treba da budu:
- konkretna
- provjerljiva
- fokusirana na ponasanje sistema ili poslovno pravilo

Dobro pitanje:
- "Koji status dokument dobija nakon akcije Potvrdi?"

Lose pitanje:
- "Kako ovo radi?"

### `## Business rules`

Koristi samo za potvrdena pravila.

Ako pravilo nije potvrdeno, mora ici u `## Pitanja za tim`, ne u ovu sekciju.

### `## Povezani ekrani`

Navedi povezane ekrane samo ako je navigacija ili veza stvarno potvrdena.

Preporuceni format:

```markdown
| Akcija | Povezani ekran |
|---|---|
| `Otvori detalje` | `Detalji termina` |
```

### `## Uocena ponasanja i moguci problemi`

Koristi kad je tokom dokumentovanja primijeceno neocekivano ili sumnjivo
ponasanje.

Ne zakljucuj samostalno da je nesto bug. Koristi formulacije:
- moguce neocekivano ponasanje
- potrebno provjeriti
- moguci UX problem
- pitanje za IT

---

## Dokumentovanje akcija koje mijenjaju stanje

AI moze samostalno dokumentovati akcije koje ne mijenjaju podatke, npr.:
- citanje ekrana
- otvaranje menija ili LOV liste
- navigaciju na read-only prikaz
- pregled dostupnih opcija

AI ne treba samostalno izvrsavati akcije koje mijenjaju stanje, npr.:
- `Sacuvaj`
- `Potvrdi`
- `Obrisi`
- `Posalji`
- `Sinhronizuj`
- generisanje koje upisuje podatke

Kad treba provjeriti takvu akciju:
1. navedi korisniku koje dugme ili akciju treba pokrenuti
2. navedi sta treba posmatrati
3. dokumentuj stvarni rezultat, ne ocekivani rezultat
4. ako je nesto i dalje nejasno, dodaj pitanje za tim

---

## Utvrdjivanje stvarne navigacije

Kad dokument opisuje kako korisnik dolazi do ekrana, provjeri redom:

1. Postojeci `screen_reference` za meni, pocetnu ili dashboard stranicu.
2. APEX navigation liste u
   `@02-apex/applications/f<app>/application/shared_components/navigation/lists/`.
3. Ako se meni generise SQL upitom, provjeriti stvarni izvor liste i
   odgovarajuce seed podatke u `@01-database/09-data/`, ako postoje.

`p_group_id`/APEX Page Group sluzi za organizaciju exporta i dokumentacijskog
indeksa, ali nije dokaz stvarne klik-putanje. Navigaciju potvrdi konkretnim
linkom ili seed zapisom. Ne pretpostavljati razlicite varijante menija
ili okruzenja ako nisu potvrdjene izvorom.

## Zabranjene pretpostavke

Ne pretpostavljaj automatski da:
- crveno polje znaci obavezno
- `*` znaci obavezno ako to nije potvrdeno u tom UI obrascu
- `Sacuvaj` uvijek kreira novi slog
- `Potvrdi` uvijek zakljucava dokument
- `Aktivan = NE` znaci isto u svim procesima
- naziv statusa objasnjava sve poslovne posljedice tog statusa
- dvije liste ili klasifikacije imaju hijerarhijsku vezu bez potvrde

Ako postoji vjerovatna pretpostavka, pretvori je u pitanje.

---

## Stil pisanja

- Pisi na srpskom jeziku, latinicom i poslovno razumljivo.
- Koristi kratke i jasne recenice.
- Pisi iz perspektive korisnika.
- Izbjegavaj tehnicki zargon ako ne pomaze korisniku.
- Ne koristi formulacije poput:
  - `vjerovatno`
  - `pretpostavlja se`
  - `trebalo bi`
  - `logicno je da`
  - `najvjerovatnije`

---

## Kontrolna lista prije statusa `review`

- Naziv fajla je `page_<ID>.md` sa istim zero-padded ID-jem kao izvorni
  `page_<ID>.sql` - bez opisnog nastavka u nazivu fajla.
- `id` polje u frontmatteru je `USER_<APP>_SCREEN_PAGE_<ID>` sa istim ID-jem.
- Ispod H1 naslova, prije `## Svrha`, postoji napomena "Naziv stranice u
  izvoru" i "Izvorni fajl" sa tacnom putanjom do `page_<ID>.sql`.
- Dokument jasno opisuje jedan ekran, ne cijeli proces.
- Tvrdnje o akcijama i validacijama zasnovane su na potvrdenom ponasanju.
- Glavna polja, dugmad, regioni i dijalozi su pokriveni.
- Otvorena pitanja su izdvojena u `## Pitanja za tim`.
- Tekst ne curi u nepotrebne tehnicke detalje.
- Ako postoji `## Business rules`, u njemu su samo potvrdena pravila.
