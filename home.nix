{ config, pkgs, ... }:
let
  configSymlink = fileName: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/${fileName}";
  };

in
{
  home.username = "devspaceship";
  # home.homeDirectory = "/home/devspaceship";
  home.homeDirectory = "/Users/devspaceship";
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.cmatrix
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.go
    pkgs.gopls
    pkgs.htop
    pkgs.lazygit
    pkgs.neovim
    pkgs.nmap
    pkgs.ripgrep
    pkgs.tree
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
    ".zshrc" = configSymlink "zsh/zshrc";
    ".config/alacritty" = configSymlink "alacritty";
    ".config/htop/htoprc" = configSymlink "htop/htoprc";
    ".config/nix" = configSymlink "nix";
    ".config/nix-darwin" = configSymlink "nix-darwin";
    ".config/nvim" = configSymlink "nvim";
    ".config/nvim-bak" = configSymlink "nvim-bak";
    ".config/rio" = configSymlink "rio";
    ".config/starship.toml" = configSymlink "starship/starship.toml";
    ".config/tmux" = configSymlink "tmux";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

