---

name: review
description: Review code changes for actionable bugs, regressions, security defects, and missing tests. Use when asked to review a diff, commit, branch, or pull request.
---

# Review Changes

Find defects introduced by the change, not opportunities to rewrite unrelated code. Review only; do not edit files or mutate external records.

## Scope and evidence

1. Establish the requested repository, change set, and baseline. If none is specified, review staged and unstaged tracked changes and inspect relevant untracked source files without adding them to Git.
2. For a branch or pull request, identify the intended base and compare from the merge base. State the baseline used; do not silently substitute a different branch or assume local refs are fresh.
3. Read relevant project instructions, changed files, callers, and existing tests. Check the behavior in context rather than relying only on diff fragments.
4. Prioritize correctness, behavioral regressions, security defects, and missing coverage for changed behavior. Ignore style and formatting unless requested or necessary to explain a defect.
5. Support each finding with a concrete triggering condition and consequence. Separate confirmed defects from uncertainties; do not invent findings to fill a quota.
6. Respect the selected agent's execution permissions. If tests cannot be run, inspect them and report the verification gap rather than attempting a workaround.

## Output

- Findings first, ordered by severity. Include a short title, file and line references, triggering conditions, consequence, and supporting evidence.
- Keep suggested fixes focused; do not apply them.
- If there are no findings, say so explicitly.
- Summarize the reviewed scope, checks performed, and remaining testing gaps. Missing tests alone are not proof of a behavioral defect.
