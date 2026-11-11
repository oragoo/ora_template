---
project: "{{PROJECT_SLUG}}"
id: "{{DOC_ID_PREFIX}}_AI_INDEX"
type: index
tags: [index, workspace, rag]
last_review: YYYY-MM-DD
---

# {{PROJECT_NAME}} - AI i RAG dokumentacija

Ovaj dokument je ulazna tacka u projektnu dokumentaciju. Sadrzaj mora opisivati
samo stanje potvrdjeno iz izvornog koda, konfiguracije, odluka ili zahtjeva.

## Projektni kontekst

- Repozitorijum: `{{REPOSITORY_NAME}}`
- Poslovna namjena: `<dopuniti>`
- Korisnici i uloge: `<dopuniti>`
- Tehnoloski stack: `<dopuniti>`
- Izvorni kod aplikacije: `<dopuniti>`
- Baza i sheme: `<dopuniti ili navesti da se ne koriste>`
- Okruzenja i isporuka: `<dopuniti>`

## Mapa dokumentacije

| Putanja | Namjena |
|---|---|
| `@00-ai/10-ai-standards/` | Standardi i predlosci |
| `@00-ai/20-client-requirements/` | Potvrdjeni klijentski zahtjevi |
| `@00-ai/30-development-tasks/` | Developer, AI i drugi razvojni zadaci |
| `@00-ai/40-technical-documentation/` | Tehnicka RAG dokumentacija |
| `@00-ai/80-user-documentation/` | Korisnicka dokumentacija |
| `@00-ai/90-custom-files/` | Pomocni kontekst koji nije izvor istine |

## Pravila odrzavanja

- Standard birati preko `@00-ai/10-ai-standards/_index.md`.
- Novi dokument zasnivati na provjerenom izvoru i odgovarajucem predlosku.
- Putanju koja jos ne postoji ne navoditi kao pregledan izvor.
- Pri promjeni ugovora, toka, strukture ili ponasanja azurirati pogodjenu dokumentaciju.
- Pomocni fajlovi ne zamjenjuju stvarni izvorni kod ili sluzbenu konfiguraciju.

