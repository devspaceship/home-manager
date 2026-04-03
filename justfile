home_manager := "~/.config/home-manager"

# List available recipes
default:
    @just --list

# Install the flake
install:
    echo "DEVSPACE = ${DEVSPACE}"
    home-manager switch --flake {{home_manager}}#${DEVSPACE}

# Update the flake lock
update:
    nix flake update --flake {{home_manager}}

# Update the flake lock and install the flake
upgrade: update install

# Update the system channel and rebuild
upgrade-system:
    sudo nix-channel --update
    sudo nixos-rebuild switch
