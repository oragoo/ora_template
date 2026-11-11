---
project: "{{PROJECT_SLUG}}"
id: USER_DOCUMENTATION_STANDARDS_INDEX
type: index
tags: [index, standards, user-docs, documentation, writing]
last_review: 2026-10-05
---

# User Documentation Standards - Index

## Svrha

Ovaj folder sadrzi sve standarde za pisanje krajnje korisnicke dokumentacije
- opsti standard, poseban standard za `screen_reference` i `workflow_guide`
dokumente, razlike za React aplikacije, i template-e za svaki tip dokumenta.

Planirana lokacija korisnicke dokumentacije je `@00-ai/80-user-documentation/`.
Podfolderi `apex/` i `react/` koriste se samo za odabranu platformu.
Korisnicka dokumentacija jos nije kreirana; ovaj folder sadrzi pravila i predloske.

---

## Dokumenti

| Dokument | Sadrzaj |
|---|---|
| `@00-ai/10-ai-standards/40-user-documentation-standards/user_doc_writing_standards.md` | Opsti standard - struktura, frontmatter, business rules i FAQ sloj korisnickih uputstava |
| `@00-ai/10-ai-standards/40-user-documentation-standards/screen_reference_writing_standards.md` | Standard za `screen_reference` dokumente - opis jednog ekrana, forme, taba ili dijaloga |
| `@00-ai/10-ai-standards/40-user-documentation-standards/workflow_guide_writing_standards.md` | Standard za `workflow_guide` dokumente - opis viseskoracnog poslovnog procesa kroz vise ekrana |
| `@00-ai/10-ai-standards/40-user-documentation-standards/react_user_docs_writing_standards.md` | Razlike za `screen_reference`/`workflow_guide` kad se pisu za React (web/desktop/mobile) aplikacije iz `<react-source>/` umjesto APEX-a |
| `@00-ai/10-ai-standards/40-user-documentation-standards/templates/user_guide_template.md` | Osnovni template za jedno korisnicko uputstvo |
| `@00-ai/10-ai-standards/40-user-documentation-standards/templates/screen_reference_template.md` | Template za opis jednog ekrana, forme, taba ili dijaloga (APEX) |
| `@00-ai/10-ai-standards/40-user-documentation-standards/templates/workflow_guide_template.md` | Template za opis viseskoracnog poslovnog procesa (APEX) |
| `@00-ai/10-ai-standards/40-user-documentation-standards/templates/react_screen_reference_template.md` | Template za opis jednog ekrana React aplikacije |
| `@00-ai/10-ai-standards/40-user-documentation-standards/templates/react_workflow_guide_template.md` | Template za opis viseskoracnog poslovnog procesa u React aplikaciji |

---

## Pravilo izbora

- Opis jedne stranice/ekrana/taba/dijaloga -> `screen_reference` standard i template
- Viseskoracni poslovni proces kroz vise ekrana -> `workflow_guide` standard i template
- Puno, opste korisnicko uputstvo koje ne spada u gornje dvije kategorije -> `user_doc_writing_standards.md` i `user_guide_template.md`
- Aplikacija je React (`<react-source>/`), ne APEX -> dodatno provjeri `react_user_docs_writing_standards.md` za razlike u odnosu na APEX standard

---
