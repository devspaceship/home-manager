---
description: Determine whether a Dependabot alert is actually relevant to this repo
agent: audit
---

Analyze the Dependabot alert identified by `$ARGUMENTS`.

Your job is to decide whether the repository's `main` branch is actually vulnerable, not just whether GitHub raised an alert.

Audit the repository as it exists on `main`, not as it exists in the current working tree.
Ignore staged and unstaged dependency changes in the current checkout unless the user explicitly asks to audit local changes.

Treat the input like this:
- If it is a GitHub Dependabot alert URL, extract `owner`, `repo`, and `alert_number`.
- If it is a bare alert number, infer `owner/repo` from the git `origin` remote.
- Otherwise treat it as pasted alert text or JSON.

If you can resolve `owner/repo/alert_number`, try to fetch the alert details with `gh api`.
If that fails because the GitHub CLI token lacks the required scope or the repository is inaccessible, continue with pasted alert details if they were provided.
If there are no usable alert details, stop and ask for either:
- the full alert URL
- the alert number for the current repo
- pasted alert details

Mention that `gh auth refresh -h github.com -s security_events` may be required for private repositories.

Before inspecting files, resolve the baseline ref in this order:
- `origin/main`
- `main`

If neither ref exists locally, return `Insufficient evidence` and explain that the main branch ref is unavailable locally.

When auditing manifests, lockfiles, and code usage, inspect the baseline ref instead of the working tree.
Prefer git-based inspection of that ref, for example:
- `git ls-tree -r --name-only <ref>` to enumerate files on the baseline
- `git show <ref>:path/to/file` to read manifests, lockfiles, and source files from the baseline
- `git grep <pattern> <ref> -- <paths>` when you need to check usage on the baseline

When inspecting the repository, verify the alert against the actual codebase:
- Find the relevant manifest and lockfile(s).
- Confirm whether the vulnerable package is present and which version is actually resolved.
- Distinguish direct from transitive dependencies.
- Distinguish runtime dependencies from dev, test, or build-only dependencies.
- Check whether the affected package is actually used in code paths that matter.
- Note platform, runtime, or configuration assumptions that affect exploitability.
- If the alert refers to a different repo, manifest path, or branch than the local checkout, call that out clearly.

Do not assume the repo is vulnerable just because the package appears in a manifest or because GitHub raised the alert.

Use these verdicts exactly:
- Vulnerable
- Not vulnerable
- Possibly vulnerable
- Insufficient evidence

Only say `Vulnerable` when the audited baseline ref clearly contains an affected version in a relevant context.
Say `Not vulnerable` when the package is absent, resolved outside the vulnerable range, or clearly irrelevant to this repo with evidence.
Say `Possibly vulnerable` when the vulnerable version is present but real exposure is unclear.
Say `Insufficient evidence` when the alert details or repo context are not enough to decide.

Respond in this format:

## Verdict
<one of the four verdicts>

## Why
<short explanation>

## Evidence
- Baseline ref: <ref used>
- <specific file paths, versions, or alert details>
- <specific file paths, versions, or alert details>

## Recommended action
- <concrete next step>
- <optional second step>
