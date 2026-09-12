---
name: commit
description: Create focused Git commits from the current working tree. Use when the user asks to commit, organize changes into commits, or prepare a branch for review.
compatibility: Codex and OpenCode
---

# Commit Changes

Create reviewable commits without absorbing unrelated work or publishing anything beyond the user's request.

## Inspect and scope

1. Start with the repository status, branch, and relevant diffs. Treat unfamiliar existing changes as user work.
2. Split changes by their independent purpose. Keep source, tests, documentation, and configuration together only when they deliver one coherent change.
3. Do not include generated files, credentials, or unrelated formatting changes unless they are intentional and required.

## Choose the title convention

1. Inspect recent non-merge commit titles, newest first. Ignore merge, revert, and other special commits when determining the convention.
2. Treat a title with a recognized Conventional Commit type—such as `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, or `test`—followed by an optional parenthesized scope and `: ` as Conventional Commits. Treat an otherwise scoped `scope: description` title as Scoped Commits.
3. In a mixed history, use the first unambiguous convention found while scanning newest to oldest. If no recent title establishes either convention, use Scoped Commits.
4. For Scoped Commits, use `scope: description`, where the scope names the affected subsystem, area, or module. For Conventional Commits, use `<type>[optional scope][!]: description`; retain the repository's established types, scopes, and casing.

## Stage and commit

1. Stage explicit paths or hunks; do not use blanket staging such as `git add .` or `git add -A`.
2. Review each staged diff before committing. Run the most relevant available validation when the change warrants it.
3. Write a concise, imperative title that describes the outcome and follows the selected convention. Add a body or trailers only when useful or required by the project.
4. Create separate commits when distinct changes can be reviewed, reverted, or released independently.

## Boundaries

- A request to prepare or organize commits does not authorize creating them; ask before the first commit if the user did not explicitly request one.
- Do not amend, rebase, force-push, push, tag, publish, change Git configuration, or discard changes unless the user explicitly asks.
- Report the commit hash, message, included files, and validation performed. State any uncommitted changes left behind.
