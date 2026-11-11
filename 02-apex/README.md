# Oracle APEX aplikacije

Ovaj folder je izvorna lokacija za Oracle APEX exporte projekta.

## Struktura

```text
02-apex/
  applications/
    f<application_id>/       # split export aplikacije
    f<application_id>.sql    # puni export, ako projekat koristi jedan fajl
```

Preporuceni oblik je split export u `applications/f<application_id>/`, jer
omogucava pregled promjena po stranici i shared komponenti. Projekat treba da
izabere jedan kanonski oblik izvoza i da ga dokumentuje; ne odrzavati split i
puni export paralelno ako nisu dio jasno definisanog procesa.

## Pravila

- Jedna aplikacija koristi stabilan izvorni Application ID i odgovarajuci naziv
  `f<application_id>`.
- Cuvati kompletan export potreban za ponovljiv import, ukljucujuci stranice,
  shared komponente i aplikacijske postavke koje pripadaju source kontroli.
- Export praviti iz potvrdenog izvornog okruzenja i commitovati kao jednu
  povezanu cjelinu.
- Ne mijenjati generisane interne ID-jeve rucno bez dokumentovanog razloga.
- Ne unositi lozinke, tokene, produkcijske URL-ove ni druge tajne u export.
- Staticke fajlove i plugin artefakte verzionisati samo ako su potrebni za
  ponovljiv import i dozvoljeni za cuvanje u repozitorijumu.
- APEX i povezane PL/SQL promjene razdvojiti po odgovornosti, ali dokumentovati
  njihove zavisnosti u zadatku i RAG dokumentaciji.

## Dokumentacija

- APEX task pravila: `@00-ai/10-ai-standards/20-task-standards/`.
- Korisnicka dokumentacija: `@00-ai/80-user-documentation/apex/`.
- Izvor stranice u RAG dokumentu navoditi iz
  `@02-apex/applications/f<application_id>/application/pages/` kada se koristi
  split export.

Tacne export/import komande, APEX/SQLcl verziju, workspace mapiranje i
deployment postupak dopuniti tek kada budu implementirani i provjereni.

