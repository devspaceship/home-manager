# Investigate a Dependabot Alert

Determine whether the repository's `main` branch is actually exposed, not just whether GitHub raised an alert.

## Resolve the alert

- For a GitHub Dependabot alert URL, extract the owner, repository, and alert number.
- For a bare alert number, infer the repository from the Git origin remote.
- Otherwise use the supplied alert text or JSON.
- When the repository and alert number are known, try to fetch details with a read-only `gh api` request, subject to permissions.
- If access fails, continue with pasted details when available. Otherwise ask for usable alert details. Private repositories may require the user to run `gh auth refresh -h github.com -s security_events`; do not start an interactive authentication flow yourself.

## Inspect the baseline

1. Resolve `origin/main`, falling back to `main`. If neither exists locally, return `Insufficient evidence`. State the ref and commit used and that remote-tracking refs may be stale; do not silently fetch or change branches.
2. Audit that baseline, not the current working tree, unless the user explicitly requests local changes.
3. Inspect files using `git ls-tree -r --name-only <ref>`, `git show <ref>:<path>`, and `git grep <pattern> <ref> -- <paths>`. Do not check out the branch or alter local work.
4. Confirm the relevant manifests, lockfiles, resolved versions, affected advisory range, direct or transitive dependencies, and runtime, development, test, or build context.
5. Establish whether the affected functionality is reachable and whether platform, runtime, configuration, or attacker prerequisites apply. Build-only dependencies can still expose CI or developer environments.
6. Call out mismatches between the alert's repository, branch, or manifest and the inspected baseline. Do not run a working-tree dependency scanner and present it as evidence about another ref.

## Verdict

Use exactly one:

- **Vulnerable**: The baseline contains an affected version and evidence supports the relevant exposure conditions.
- **Not vulnerable**: Evidence shows the package is absent, resolved outside the affected range, or the advisory's required conditions do not apply.
- **Possibly vulnerable**: An affected version is present but reachability or required exposure conditions remain unclear.
- **Insufficient evidence**: Alert details or repository evidence are inadequate to assess exposure.

An alert alone is not proof of exposure. Failure to find a code reference is not enough to establish `Not vulnerable`.

## Output

Report `Verdict`, `Why`, `Evidence`, and `Recommended action`. Include the baseline ref and commit, relevant paths and resolved versions, advisory sources, exposure conditions, and any missing evidence. Recommend a concrete next step without changing dependencies or dismissing the alert.
