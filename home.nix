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
    pkgs.bat
    pkgs.cmatrix
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.go
    pkgs.gopls
    pkgs.htop
    pkgs.lazygit
    pkgs.neofetch
    pkgs.neovim
    pkgs.nmap
    pkgs.python313
    pkgs.ripgrep
    pkgs.tree
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
    ".gitconfig" = configSymlink "git/conf";
    ".zshrc" = configSymlink "zsh/zshrc";
    ".config/alacritty" = configSymlink "alacritty";
    ".config/htop/htoprc" = configSymlink "htop/htoprc";
    ".config/nix" = configSymlink "nix";
    ".config/nix-darwin" = configSymlink "nix-darwin";
    ".config/nvim" = configSymlink "nvim";
    ".config/nvim-bak" = configSymlink "nvim-bak";
    ".config/rio" = configSymlink "rio";
    ".config/starship.toml" = configSymlink "starship/starship.toml";
    ".config/tmux/tmux.conf" = configSymlink "tmux/tmux.conf";
    ".config/tmux/tmux.conf.local" = configSymlink "tmux/tmux.conf.local";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

