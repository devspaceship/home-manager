home_manager := "~/.config/home-manager"

[private]
default:
    @just --list

[private]
update:
    nix flake update --flake {{ home_manager }} \
    	--extra-experimental-features 'nix-command flakes'

[private]
install-nixos:
    sudo nixos-rebuild switch --flake {{ home_manager }}#home --impure

[private]
install-home-manager:
    echo "DEVSPACE = ${DEVSPACE}"
    home-manager switch --flake {{ home_manager }}#${DEVSPACE}

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
