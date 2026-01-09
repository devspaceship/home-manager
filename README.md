# Home Manager

## Installation

1. Install Nix
2. Install Home Manager
3. Clone this repository to `~/.config/home-manager`
4. `cp dotfiles/git/conf.example dotfiles/git/conf`
5. Edit `dotfiles/git/conf`
6. `cp .env.example .env`
7. Edit `.env`
8. Apply the configuration: `make upgrade`

## Usage

```txt
> make
usage: make [command]
  help      Show this help message
  install   Install the flake
  update    Update the flake lock
  upgrade   Update the flake lock and install the flake
```
