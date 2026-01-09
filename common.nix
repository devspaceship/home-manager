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

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      bash
      bat
      btop
      cmatrix
      fd
      fzf
      gcc
      gh
      gimp2
      git
      gnumake
      gnupg
      go
      gopls
      kitty
      lazygit
      luajitPackages.luarocks
      neofetch
      neovim
      nerd-fonts.fira-code
      nil
      nixfmt
      nmap
      oh-my-zsh
      opencode
      pinentry-curses
      python313
      python313Packages.pip
      ripgrep
      rustup
      starship
      statix
      stylua
      tmux
      tree
      tree-sitter
      unzip
      wget
      yazi
      zathura
      zellij
      zsh
    ];

    file = {
      ".gitconfig" = configSymlink "git/conf";
      ".zsh_helpers" = configSymlink "zsh/zsh_helpers";
      ".zprofile" = configSymlink "zsh/zprofile";
      ".zshrc" = configSymlink "zsh/zshrc";
      ".config/alacritty" = configSymlink "alacritty";
      ".config/kitty" = configSymlink "kitty";
      ".config/nix" = configSymlink "nix";
      ".config/nvim" = configSymlink "nvim";
      ".config/lazygit/config.yml" = configSymlink "lazygit/config.yml";
      ".config/starship.toml" = configSymlink "starship/starship.toml";
      ".config/tmux/tmux.conf" = configSymlink "tmux/tmux.conf";
      ".config/tmux/tmux.conf.local" = configSymlink "tmux/tmux.conf.local";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentry.package = pkgs.pinentry-curses;
    pinentry.program = "pinentry-curses";
  };
}
