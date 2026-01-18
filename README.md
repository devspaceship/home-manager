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
6. Apply the configuration: `task upgrade`

## Usage

```txt
❯ task
task: Available tasks for this project:
* install:       Install the flake
* update:        Update the flake lock
* upgrade:       Update the flake lock and install the flake
```
