---
project: "{{PROJECT_SLUG}}"
id: USER_DOC_WRITING_STANDARDS
type: standard
tags: [standard, user-docs, documentation, writing]
last_review: 2026-10-05
---

# Standardi za pisanje korisnickih uputstava

Ovaj dokument definise kako pisati i azurirati krajnja korisnicka uputstva
za projekat {{PROJECT_NAME}}. Planirana lokacija je `@00-ai/80-user-documentation/`,
sa podfolderima prema odabranoj platformi. Uputstva jos nisu kreirana.

Koristi ga kada:
- pises novo korisnicko uputstvo
- dopunjujes postojece korisnicko uputstvo
- pretvaras poslovne biljeske ili Word/PDF materijal u Markdown source of truth

Ako postoji konflikt izmedju ovog dokumenta i starijeg template-a u
`@00-ai/10-ai-standards/40-user-documentation-standards/templates/user_guide_template.md`,
prednost ima ovaj standard.

Za `type: screen_reference` ovaj dokument je krovni standard, ali obavezno
koristi i:
- `@00-ai/10-ai-standards/40-user-documentation-standards/screen_reference_writing_standards.md`
- `@00-ai/10-ai-standards/40-user-documentation-standards/templates/screen_reference_template.md`

Za `type: workflow_guide` ovaj dokument je krovni standard, ali obavezno
koristi i:
- `@00-ai/10-ai-standards/40-user-documentation-standards/workflow_guide_writing_standards.md`
- `@00-ai/10-ai-standards/40-user-documentation-standards/templates/workflow_guide_template.md`

Kad dokumentujes React (web/desktop/mobile) aplikaciju iz `<react-source>/` umjesto
APEX aplikacije, `screen_reference`/`workflow_guide` standardi i template-i
gore i dalje vaze za sadrzaj i sekcije, ali dodatno obavezno koristi:
- `@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md`
- `@00-ai/10-ai-standards/40-user-documentation-standards/templates/react_screen_reference_template.md`
- `@00-ai/10-ai-standards/40-user-documentation-standards/templates/react_workflow_guide_template.md`

---

## Svrha standarda

Korisnicka dokumentacija u ovom workspace-u nema samo ulogu end-user uputstva.
Isti Markdown fajlovi sluze i kao:
- izvor za PDF/DOCX publishing
- poslovni kontekst za AI asistente
- materijal za onboarding novih clanova tima

Zato dokument ne smije objasniti samo "sta kliknuti", nego i:
- sta funkcionalnost radi
- zasto postoji
- koja pravila sistem primjenjuje
- gdje korisnici najcesce grijese

---

## Osnovni principi

- Primarni izvor korisnickih uputstava je Markdown u `@00-ai/80-user-documentation/`.
- PDF, DOCX i drugi izvozi su izvedeni artefakti, ne primarni izvor.
- Jedan fajl treba da pokriva jednu jasnu temu: ekran, workflow, pravilo ili FAQ cjelinu.
- Organizacija ide po aplikaciji i procesu, ne po bazi, semi ili paketu.
- Jezik je srpski, latinica, u poslovno razumljivom tonu.
- Tehnicki detalji se navode samo kad pomazu korisniku da razumije posljedicu u sistemu.
- Ne prepisivati PL/SQL, tabelarne DDL detalje ni runtime implementaciju iz `@00-ai/`.
- Kad je bitno ponasanje sistema, opisuj pravilo i efekat, ne internu implementaciju.

---

## Sta svako dobro uputstvo mora da odgovori

Bez obzira na tip dokumenta, korisnicko uputstvo treba da odgovori na ova
pitanja:
- cemu funkcionalnost sluzi
- kome je namijenjena
- kada se koristi
- koje podatke ili prava korisnik mora imati unaprijed
- kako izgleda normalan tok rada
- koja poslovna pravila i validacije sistem primjenjuje
- koje su tipicne greske, izuzeci i rubni slucajevi

---

## Preporuceni frontmatter

Minimalni frontmatter treba da ostane stabilan i citljiv covjeku. Ne uvoditi
polja koja generisu nepotreban diff pri svakoj manjoj izmjeni.

```yaml
---
id: USER_{{DOC_ID_PREFIX}}_ZAKAZIVANJE_TERMINA
type: user_guide
app: {{PROJECT_SLUG}}
module: termini
audience: [recepcija, ljekar]
tags: [termin, unos, zakazivanje]
status: draft
owner: poslovna_podrska
last_review: 2026-05-22
outputs: [pdf, docx]
schemas: [<SCHEMA>]  # opciono; stvarna shema tek treba biti potvrdjena
reviewer: <opcionalno>
version: <opcionalno>
---
```

---

## Frontmatter pravila

### Obavezna polja

| Polje | Obavezno | Svrha |
|---|---|---|
| `id` | DA | Stabilan identifikator dokumenta |
| `type` | DA | Tip dokumenta, npr. `user_guide`, `faq`, `glossary`, `app_overview` |
| `app` | DA | Aplikacija ili `cross-app` |
| `module` | DA | Poslovna cjelina / proces |
| `audience` | DA | Ciljne korisnicke uloge |
| `tags` | DA | Laksa pretraga i grupisanje |
| `status` | DA | `scaffold`, `draft`, `review`, `final`, `deprecated` |
| `owner` | DA | Vlasnik dokumenta / tim |
| `last_review` | DA | Datum zadnje stvarne urednicke provjere |
| `outputs` | DA | Predvidjeni izvozi, npr. `pdf`, `docx` |

### Opcionalna polja

| Polje | Kada koristiti |
|---|---|
| `schemas` | Kad je korisno znati koje poslovne sheme stoje iza funkcionalnosti |
| `reviewer` | Kad dokument ima imenovanog domain reviewera |
| `version` | Kad se dokument vodi kroz formalne verzije za publishing |

### Polja koja ne treba uvoditi kao obavezna

- `generated_on`
  - stvara nepotreban churn; git istorija i `last_review` vec pokrivaju trag izmjene
- `language`
  - nije potrebno dok je cijeli `user_docs` prostor jednojezik
- `ai_usage.*`
  - korisno samo ako stvarno postoji automatizovani pipeline koji to cita
- `recommended_chunking`
  - ne treba gurati u svaki dokument bez dokaza da ga tooling stvarno koristi

---

## Tipovi korisnickih dokumenata

Preporuceni `type` vrijednosti:

| Type | Kada koristiti |
|---|---|
| `user_guide` | Standardno uputstvo za ekran ili proces |
| `workflow_guide` | Visekoracni proces koji prelazi jedan ekran ili modul |
| `screen_reference` | Referentni opis jednog ekrana, tab-a ili forme |
| `faq` | Cesta pitanja i tipicne greske |
| `glossary` | Pojmovnik |
| `app_overview` | Pregled aplikacije za krajnje korisnike |

---

## Kada koristiti `screen_reference`

Koristi `screen_reference` kada dokument nije puno korisnicko uputstvo, nego
opis jednog konkretnog ekrana, tab-a, forme ili dijaloga:
- sta stranica radi
- sta korisnik na njoj vidi
- sta korisnik na njoj moze da pokrene, unese ili izmijeni

Ne koristi `screen_reference` kao zamjenu za siri procesni dokument. Ako tema
pokriva vise ekrana, poslovni tok od pocetka do kraja ili siri skup pravila,
koristi `user_guide` ili `workflow_guide`.

Detaljna pravila i template za ovaj tip dokumenta nalaze se u:
- `@00-ai/10-ai-standards/40-user-documentation-standards/screen_reference_writing_standards.md`
- `@00-ai/10-ai-standards/40-user-documentation-standards/templates/screen_reference_template.md`

---

## Kada koristiti `workflow_guide`

Koristi `workflow_guide` kada dokument opisuje jedan zaokruzen poslovni
proces od pocetka do kraja, koji prelazi vise ekrana ili vise aplikacija:
- redoslijed rada kroz vise ekrana
- ko sta radi i ko sta smije u tom procesu
- odluke koje korisnik mora donijeti, a koje se ne vide iz softvera

Ne koristi `workflow_guide` da bi ponovio sadrzaj `screen_reference`
dokumenata - polja i dugmad pojedinacnog ekrana i dalje se dokumentuju samo
tamo. Test: ako se opis moze napisati bez pominjanja bar dva ekrana, to nije
workflow.

Detaljna pravila i template za ovaj tip dokumenta nalaze se u:
- `@00-ai/10-ai-standards/40-user-documentation-standards/workflow_guide_writing_standards.md`
- `@00-ai/10-ai-standards/40-user-documentation-standards/templates/workflow_guide_template.md`

---

## Obavezne i preporucene sekcije

Ne mora svaki dokument imati isti oblik, ali sljedeci minimum treba postojati.

### Obavezne sekcije za skoro svaki `user_guide`

- `## Svrha`
- `## Kome je namijenjeno`
- `## Kada se koristi`
- `## Preduslovi`
- `## Koraci` ili `## Funkcionalni opis`
- `## Business rules`
- `## Najcesce greske / FAQ`

### Preporucene sekcije

- `## Navigacija`
- `## Osnovni pojmovi`
- `## Polja i opcije`
- `## Primjeri`
- `## Informacije za dopunu`
- `## Povezani dokumenti`

Za `screen_reference` koristi dedikovani skup sekcija iz
`screen_reference_writing_standards.md`; ne forsiraj puni `user_guide` obrazac
ako korisnik trazi samo opis stranice.

### Kad koristiti `Koraci`, a kad `Funkcionalni opis`

- `## Koraci`
  - koristi za proceduralna uputstva tipa "uradi X, pa Y, pa Z"
- `## Funkcionalni opis`
  - koristi za pregled modula, tab-a, statusa, polja i poslovnog ponasanja
- ako dokument pokriva i radnju i objasnjenje, slobodno koristi obje sekcije

---

## Obrazac sekcija

### `## Svrha`

1-2 recenice:
- sta dokument pokriva
- sta korisnik dobija ili rjesava pomocu te funkcionalnosti

### `## Kome je namijenjeno`

Navedi konkretne role ili tipove korisnika:
- recepcija
- ljekar
- medicinska sestra ili tehnicar
- administrator ambulante

Ovo su primjeri publike; stvarne uloge potvrditi iz zahtjeva.

### `## Kada se koristi`

Objasni poslovni trenutak:
- prije kreiranja dokumenta
- nakon odobrenja
- kad korisnik treba korigovati postojeci zapis

### `## Navigacija`

Kad god korisnik mora znati gdje se funkcionalnost nalazi, navedi tacnu
putanju kroz meni ili naziv ekrana/tab-a.

### `## Preduslovi`

Navedi:
- potrebne role ili autorizacije
- koji sifarnici, pacijenti, ambulante ili drugi podaci moraju vec postojati
- eventualne statusne uslove

### `## Osnovni pojmovi`

Dodaj samo kad dokument uvodi termine koji nisu samorazumljivi.
Ne praviti vestacki pojmovnik ako su svi termini vec opstepoznati.

### `## Polja i opcije`

Kad dokument opisuje formu ili tab, koristi tabelu umjesto dugog proznog
opisa.

Preporuceni format:

```markdown
| Polje | Opis | Obavezno | Napomena |
|---|---|---|---|
| `Pacijent` | Osoba za koju se zakazuje termin | DA | Ilustracija; pravilo potvrditi iz aplikacije |
```

Kolona `Obavezno` koristi vrijednosti:
- `DA`
- `NE`
- `USLOVNO`

### `## Koraci`

Koraci treba da budu:
- redoslijedni
- kratki
- akcioni
- bez mijesanja vise scenarija u isti korak

Ako postoje razliciti scenariji, razdvoji ih u podnaslove.

### `## Funkcionalni opis`

Ovdje objasni:
- kako ekran ili modul radi
- koje cjeline postoje
- kako se ponasaju statusi, filteri, tabovi i akcije

### `## Business rules`

Ovo je obavezna sekcija kad dokument opisuje ponasanje sistema, a ne samo
klik-putanju.

Business rule treba da bude:
- konkretna izjava
- bez dvosmislenosti
- fokusirana na ponasanje sistema

Dobar obrazac:
- "Ako ... sistem blokira ..."
- "Ako ... sistem automatski postavlja ..."
- "Kada je status X, korisnik ne moze ..."

Ne pisati:
- "Sistem moze ..."
- "Vjerovatno ..."
- "Po pravilu bi trebalo ..."

Business rules treba da pokriju:
- obavezna polja i uslove
- validacije pri unosu ili snimanju
- statuse i tranzicije
- izuzetke i fallback ponasanje
- uticaj na druge procese ili dokumente

### `## Najcesce greske / FAQ`

Ovo nije sporedna sekcija. Vrlo je korisna i za podrsku i za AI asistenta.
U nju ulaze:
- tipicne korisnicke zabune
- poznate greske pri unosu
- kratki odgovori na pitanja iz prakse

### `## Informacije za dopunu`

Koristi kao otvoreni tracker za stvari koje jos nisu razjasnjene.

Preporuceni format:

```markdown
| Tema | Sta nedostaje | Ko treba dopuniti |
|---|---|---|
| Neradni dani | Nije potvrdjeno kako nadjacavaju sedmicnu dostupnost | poslovna podrska |
```

Ova sekcija je:
- preporucena za `scaffold`, `draft` i `review`
- opcionalna za `final`, ako nema otvorenih pitanja

---

## Primjeri, screenshots i vizuelni elementi

- Primjere izdvajaj u quote blok ili jasno odvojenu podsekciju.
- Ako se koristi screenshot, smjesti ga uz dokument ili u odgovarajuci
  `assets/` folder.
- Screenshot ne smije biti jedini nosilac informacije; kljucno pravilo mora
  postojati i tekstualno.
- Ako se UI cesto mijenja, preferiraj tekst + oznaku funkcije nad prevelikim
  oslanjanjem na screenshot.

---

## Stil pisanja

- Pisi jednostavno i direktno.
- Koristi aktiv umjesto pasiva kad god je prirodno.
- Izbjegavaj tehnicki zargon ako korisniku ne donosi vrijednost.
- Ako termin mora ostati tehnicki, odmah objasni poslovni efekat tog termina.
- Ne mijesaj internu implementaciju i korisnicki postupak u istoj recenici.
- Ne koristiti neprovjerene tvrdnje o validacijama i statusima kao cinjenice.

---

## Rubni slucajevi i validacije

Kad su poznati, eksplicitno navedi:
- sta se desava ako je obavezno polje prazno
- sta se desava ako nema potrebnog povezanog zapisa
- sta se desava ako je status pogresan za trazenu akciju
- da li sistem blokira, upozorava ili automatski koriguje unos
- koju poruku korisnik vidi, ako je poznata i stabilna

Ako poruka nije poznata, ne izmisljaj je; opisi efekat bez lazne preciznosti.

---

## Odnos prema tehnickoj dokumentaciji

- Korisnicka dokumentacija ne treba da referencira package, trigger ili tabelu
  kao primarni nacin objasnjenja.
- Dozvoljeno je navesti poslovnu shemu ili aplikaciju u frontmatteru, ali ne
  pretvarati dokument u tehnicki RAG.
- Ako postoji potreba da se jedno pravilo potvrdi iz tehnickih izvora, to se
  radi tokom pripreme dokumenta, a ne kao sadrzaj za krajnjeg korisnika.

---

## Kontrolna lista prije statusa `review`

- Frontmatter je kompletan i dosljedan.
- Dokument ima jasnu svrhu i ciljnu publiku.
- Ako opisuje ekran, navigacija i kljucna polja su jasni.
- Ako opisuje poslovnu logiku, `Business rules` sekcija nije prazna.
- Navedene su tipicne greske ili FAQ stavke iz prakse.
- Rubni slucajevi i validacije su eksplicitno navedeni kad su poznati.
- Otvorena pitanja su izdvojena u `Informacije za dopunu` umjesto sakrivena u tekstu.
- Dokument ne curi u nepotrebne tehnicke detalje.

---
