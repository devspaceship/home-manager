---
description: Run the smallest relevant format, lint, type, and test checks without edits
agent: verify
---

Verify the current repository. $ARGUMENTS

Inspect the project configuration first, then run the smallest relevant checks. Do not edit files, install dependencies, update lockfiles, or use auto-fix flags.

Respond with:

## Result
<pass, fail, or insufficient evidence>

## Checks
- <command>: <pass or fail>

## Failures
<actionable output, or "None">
