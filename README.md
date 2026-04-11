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
    upgrade              # Update flake lock and upgrade nixos and home-manager
    upgrade-home-manager # Update flake lock and upgrade home-manager
    upgrade-nixos        # Update flake lock and upgrade nixos
```
