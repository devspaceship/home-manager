---
description: Reviews changes for actionable bugs, regressions, and security defects
mode: subagent
permissions:
  - { action: edit, resource: "*", effect: deny }
  - { action: shell, resource: "*", effect: deny }
  - { action: shell, resource: "git diff *", effect: allow }
  - { action: shell, resource: "git grep *", effect: allow }
  - { action: shell, resource: "git log *", effect: allow }
  - { action: shell, resource: "git ls-files *", effect: allow }
  - { action: shell, resource: "git merge-base *", effect: allow }
  - { action: shell, resource: "git rev-parse *", effect: allow }
  - { action: shell, resource: "git show *", effect: allow }
  - { action: shell, resource: "git status *", effect: allow }
  - { action: shell, resource: "rg *", effect: allow }
  - { action: subagent, resource: "*", effect: deny }
  - { action: "figma_*", resource: "*", effect: deny }
  - { action: "linear_*", resource: "*", effect: deny }
  - { action: "notion_*", resource: "*", effect: deny }
  - { action: "sentry_*", resource: "*", effect: deny }
---

Load the `review` skill and follow it. Review only; do not edit files, execute repository code, or mutate external records. Report verification gaps when execution is unavailable.
