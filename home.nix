{ config, pkgs, ... }:
let
  configSymlink = fileName: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/${fileName}";
  };

in
{
  # TEMP: disable broken tests
  nixpkgs.overlays = [
    (final: prev: {
      fish = prev.fish.overrideAttrs (old: {
        doCheck = false;
      });
    })
  ];
  # TEMP

  home = {

    username = "devspaceship";
    # homeDirectory = "/home/devspaceship";
    homeDirectory = "/Users/devspaceship";
    stateVersion = "24.11";

    packages = [
      pkgs.bash
      pkgs.bat
      pkgs.btop
      pkgs.cmatrix
      pkgs.fd
      pkgs.fzf
      pkgs.gh
      pkgs.git
      pkgs.go
      pkgs.gopls
      pkgs.kitty
      pkgs.lazygit
      pkgs.mise
      pkgs.neofetch
      pkgs.neovim
      pkgs.nmap
      pkgs.python314
      pkgs.ripgrep
      pkgs.starship
      pkgs.tmux
      pkgs.tree
      pkgs.yazi
      pkgs.zellij
      # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    ];

    file = {
      ".gitconfig" = configSymlink "git/conf";
      ".zsh_helpers" = configSymlink "zsh/zsh_helpers";
      ".zprofile" = configSymlink "zsh/zprofile";
      ".zshrc" = configSymlink "zsh/zshrc";
      ".config/aerospace/aerospace.toml" = configSymlink "aerospace/aerospace.toml";
      ".config/alacritty" = configSymlink "alacritty";
      ".config/borders/bordersrc" = configSymlink "borders/borders.sh";
      ".config/nix" = configSymlink "nix";
      ".config/nix-darwin" = configSymlink "nix-darwin";
      ".config/nvim" = configSymlink "nvim";
      ".config/nvim-bak" = configSymlink "nvim-bak";
      ".config/kitty" = configSymlink "kitty";
      ".config/lazygit/config.yml" = configSymlink "lazygit/config.yml";
      ".config/sketchybar/plugins" = configSymlink "sketchybar/plugins";
      ".config/sketchybar/sketchybarrc" = configSymlink "sketchybar/sketchybar.sh";
      ".config/starship.toml" = configSymlink "starship/starship.toml";
      ".config/tmux/tmux.conf" = configSymlink "tmux/tmux.conf";
      ".config/tmux/tmux.conf.local" = configSymlink "tmux/tmux.conf.local";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
