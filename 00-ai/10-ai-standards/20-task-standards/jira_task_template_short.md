---
project: "{{PROJECT_SLUG}}"
id: JIRA_TASK_TEMPLATE_SHORT
type: standards
tags: [standards, jira, task, template, short]
last_review: 2026-10-05
---

# Jira Task Template Short

Koristi ovaj template kad Jira ticket treba ostati kratak i citljiv programeru, a AI detalji idu u poseban `.md` attachment.

```md
# Task: <jasan naziv zadatka>

## AI Instructions
- Primary AI handoff file: `@00-ai/30-development-tasks/02-ai-tasks/<task_file>.md`
- Coding agent must first load and follow this file
- Do not implement from this Jira description alone

## Business Context
- Domena / modul: <...>
- Problem: <...>

## Goal
<sta treba postici>

## Scope
- U scope-u:
  - <...>
- Van scope-a:
  - <...>

## Constraints
- <poslovno ili tehnicko ogranicenje>
- <ako izmjena utice na dokumentovano ponasanje/ekran, navedi obavezu AI attachment-a da azurira pogodjenu dokumentaciju, integrisano u postojeci opis>

## Acceptance Criteria
- <...>
- <...>

## Validation
- <...>
- <...>

```

## Kada koristiti

- Jedan ili dva fajla
- Jasna i mala izmjena bez sire analize
- Nizak rizik od regresije
