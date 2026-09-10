---
name: nix-home-manager
description: Use for Nix, Nix flakes, Home Manager, nix-darwin, or NixOS configuration changes and validation.
---

# Nix and Home Manager Workflow

Use this skill when the request changes `.nix` files, `flake.nix`, `flake.lock`, Home Manager configuration, nix-darwin configuration, or NixOS configuration.

## Workflow

1. Read the flake outputs and the relevant machine module before editing.
2. Preserve the existing module layout and target names.
3. Format modified Nix files with `nixfmt` when it is available.
4. Run `nix flake check` after changes.
5. Run `home-manager build --flake .#<target>` only when the target is known or explicitly supplied.
6. Never run `home-manager switch`, `darwin-rebuild switch`, `nixos-rebuild switch`, or another activation command unless the user explicitly asks.

## Reporting

State the target that was validated, the checks run, and whether activation remains intentionally undone.
