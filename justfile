home_manager := "~/.config/home-manager"

# Include existing tracked and new non-ignored Nix files, skipping unstaged deletions.
nix_files := '''git ls-files -z --cached --others --exclude-standard -- '*.nix' | while IFS= read -r -d '' file; do if [ -f "$file" ]; then printf '%s\0' "$file"; fi; done'''
nix_validation_flags := "--extra-experimental-features 'nix-command flakes' --no-update-lock-file"

[private]
default:
    @just --list --unsorted

# Format all Nix files.
fmt:
    #!/usr/bin/env bash
    set -euo pipefail
    {{ nix_files }} | xargs -0 nixfmt

# Check formatting and enforce zero Statix and nil warnings without changing files.
lint:
    #!/usr/bin/env bash
    set -euo pipefail
    {{ nix_files }} | xargs -0 nixfmt --check
    {{ nix_files }} | xargs -0 -n 1 statix check
    {{ nix_files }} | xargs -0 nil diagnostics --deny-warnings --

# Evaluate the DEVSPACE Home Manager activation derivation without building it.
eval:
    @: "${DEVSPACE:?Set DEVSPACE to a homeConfigurations target (home, laptop, or work)}"
    nix eval {{ nix_validation_flags }} \
        ".#homeConfigurations.\"${DEVSPACE}\".activationPackage.drvPath"

# Run static checks and evaluate the current Home Manager target; never activate it.
check: lint eval

# Optional: build the DEVSPACE activation package without creating a result link.
build:
    @: "${DEVSPACE:?Set DEVSPACE to a homeConfigurations target (home, laptop, or work)}"
    nix build {{ nix_validation_flags }} --no-link \
        ".#homeConfigurations.\"${DEVSPACE}\".activationPackage"

[private]
update:
    nix flake update --flake {{ home_manager }} \
    	--extra-experimental-features 'nix-command flakes'

[private]
install-nixos:
    sudo nixos-rebuild switch --flake {{ home_manager }}#home

[private]
install-home-manager:
    echo "DEVSPACE = ${DEVSPACE}"
    home-manager switch -b bak --flake {{ home_manager }}#${DEVSPACE} \
    	--extra-experimental-features 'nix-command flakes'

# Update flake lock and upgrade home-manager
[macos]
upgrade: update install-home-manager

# Update flake lock and upgrade nixos and home-manager
[linux]
upgrade: update install-nixos install-home-manager

# Update flake lock and upgrade nixos
[linux]
upgrade-nixos: update install-nixos

# Update flake lock and upgrade home-manager
[linux]
upgrade-home-manager: update install-home-manager

# Keep the last three generations of each user profile and collect garbage
gc:
    nix-env --profile ~/.local/state/nix/profiles/home-manager --delete-generations +3
    nix-env --profile ~/.local/state/nix/profiles/profile --delete-generations +3
    nix store gc
