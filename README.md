# Home Manager

## Requirements

- Nix
- Home Manager

## Installation

1. Clone this repository to `~/.config/home-manager`
2. `cp dotfiles/git/conf.example dotfiles/git/conf`
3. Edit `dotfiles/git/conf`
4. `cp .env.example .env`
5. Edit `.env`
6. Apply the configuration: `just upgrade`

## Usage

```txt
❯ just
Available recipes:
    build                # Optional: build the DEVSPACE activation package without creating a result link.
    check                # Run static checks and evaluate the current Home Manager target; never activate it.
    eval                 # Evaluate the DEVSPACE Home Manager activation derivation without building it.
    fmt                  # Format all Nix files.
    gc                   # Keep the last three generations of each user profile and collect garbage
    install-playwright   # Install the latest Playwright CLI and its shared skill.
    lint                 # Check formatting and enforce zero statix and nil warnings without changing files.
    upgrade              # Update flake lock and upgrade nixos and home-manager
    upgrade-home-manager # Update flake lock and upgrade home-manager
    upgrade-nixos        # Update flake lock and upgrade nixos
```
