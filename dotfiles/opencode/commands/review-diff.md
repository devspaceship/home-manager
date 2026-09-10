---
description: Review the current Git diff for bugs, regressions, and missing tests
agent: review
---

Review the staged and unstaged Git diff in the current repository. $ARGUMENTS

Prioritize correctness, behavioral regressions, security risks, and missing tests. Do not edit files. Ignore formatting-only changes unless they hide a defect.

Report findings first, ordered by severity. Include file and line references. If there are no findings, say so explicitly and name any testing gaps.
