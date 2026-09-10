---
description: Validate Nix and Home Manager changes without activating them
agent: verify
---

Validate Nix and Home Manager changes in the current repository. The optional target is `$ARGUMENTS`.

First inspect the flake outputs and changed Nix files. Run `nix flake check`. If a Home Manager target is supplied, also run `home-manager build --flake .#$ARGUMENTS`; otherwise do not guess a target. Do not run an activation or switch command. Do not modify files.

Report the commands run, their results, and any target that still needs to be built.
