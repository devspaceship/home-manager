---
name: incident-triage
description: Use for Sentry errors, production incidents, Linear bug triage, or requests to investigate an operational issue.
---

# Incident Triage

Start with evidence. Use the supplied Sentry event or issue, Linear issue, logs, traces, and repository context to establish what is known before proposing a fix.

## Workflow

1. Identify the affected service, environment, time range, impact, and current status.
2. Separate confirmed facts from hypotheses.
3. Inspect the relevant source and recent changes when the evidence identifies a code path.
4. Recommend the smallest safe next step, including an owner when one is evident.
5. Ask before creating, assigning, resolving, ignoring, or otherwise mutating a Linear or Sentry record.

## Output

Use these headings: `Summary`, `Impact`, `Evidence`, `Hypothesis`, `Next step`.

Do not describe a hypothesis as a root cause without supporting evidence.
