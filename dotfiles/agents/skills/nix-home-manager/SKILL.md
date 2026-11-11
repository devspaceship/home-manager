---

name: nix-home-manager
description: Use for Nix, Nix flakes, Home Manager, nix-darwin, or NixOS configuration changes and validation.
---

# Nix and Home Manager Workflow

Use this skill when the request changes `.nix` files, `flake.nix`, `flake.lock`, Home Manager configuration, nix-darwin configuration, or NixOS configuration.

## Workflow

1. Read repository instructions, flake outputs, relevant modules, and existing validation recipes before editing. Identify the configuration type, target, and platform rather than guessing them.
2. Follow existing conventions unless changing them serves the requested work. Refactor module boundaries when justified; avoid unrelated restructuring and preserve behavior unless a behavior change is intended.
3. Do not update `flake.lock`, upgrade dependencies, or change target names incidentally. Keep validation from updating the lock file.
4. Format Nix files with `nixfmt`, then check formatting and run `statix check` and `nil diagnostics --deny-warnings`. Enforce zero warnings: fix findings rather than weakening checks. Use only narrow, documented suppressions for intentional patterns or false positives.
5. Evaluate the affected configuration's activation or system derivation when configuration changes warrant it. Static analysis does not validate the module system. `nix flake check` can supplement these checks but does not necessarily validate Home Manager outputs.
6. Builds are optional, not a routine requirement. Build when requested or when realizing dependencies is relevant to the change, such as a package override. Use `nix build --no-link` against the appropriate output to avoid creating a `result` link. Evaluation and builds do not prove that activation will succeed.
7. Never run `home-manager switch`, `darwin-rebuild switch`, `nixos-rebuild switch`, or another activation command unless the user explicitly asks. Inspect recipes before running them: upgrade/install recipes may update dependencies or activate configurations.

## This Repository

In the Home Manager repository containing `machines/`, `modules/`, and the validation `justfile`, use the recipes as the source of truth for validation commands. Run them from the repository or its worktree, not a hard-coded checkout path:

- `just fmt`: format all Nix files.
- `just lint`: check formatting, Statix, and nil with zero warnings; no edits.
- `just eval`: evaluate `homeConfigurations.${DEVSPACE}.activationPackage.drvPath` without realizing the activation package.
- `just check`: lint plus Home Manager evaluation.
- `just build`: optional activation-package build, with no output link.

The Home Manager target comes from `$DEVSPACE`. Require it to be set and verify that the matching flake output exists; do not silently choose another target. Validation refuses lock-file updates. Formatting and linting cover all tracked and new, non-ignored Nix files, including generated hardware configurations. Git-backed flakes require new imported files to be tracked before evaluation; do not silently omit them or stage unrelated user work.

These recipes evaluate only the selected Home Manager configuration. For NixOS changes, also evaluate the affected `nixosConfigurations.<target>.config.system.build.toplevel.drvPath`; for shared modules, consider the other affected outputs and platforms. Do not build a foreign-platform configuration unless a suitable builder is available.

## Reporting

State the target and platform validated, the checks run, and any checks skipped or blocked. Distinguish configuration failures from network, cache, or platform limitations; do not report blocked checks as passing. State whether a build was performed and that activation remains intentionally undone unless explicitly requested.
