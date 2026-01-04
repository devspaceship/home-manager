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

    username = "devspaceship";
    homeDirectory = "/home/devspaceship";
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
      google-chrome
      gopls
      kitty
      lazygit
      luajitPackages.luarocks
      lua51Packages.lua
      mise
      neofetch
      neovim
      nil
      nixfmt
      nmap
      nodejs_24
      oh-my-zsh
      opencode
      pinentry-gnome3
      prismlauncher
      protonup-qt
      python313
      python313Packages.pip
      ripgrep
      rustup
      starship
      statix
      stylua
      tmux
      trash-cli
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
      ".config/aerospace/aerospace.toml" = configSymlink "aerospace/aerospace.toml";
      ".config/alacritty" = configSymlink "alacritty";
      ".config/borders/bordersrc" = configSymlink "borders/borders.sh";
      ".config/btop" = configSymlink "btop";
      ".config/gtk-3.0" = configSymlink "gtk-3.0";
      ".config/gtk-4.0" = configSymlink "gtk-4.0";
      ".config/hypr" = configSymlink "hypr";
      ".config/kitty" = configSymlink "kitty";
      ".config/nix" = configSymlink "nix";
      ".config/nix-darwin" = configSymlink "nix-darwin";
      ".config/nvim" = configSymlink "nvim";
      ".config/nvim-bak" = configSymlink "nvim-bak";
      ".config/lazygit/config.yml" = configSymlink "lazygit/config.yml";
      ".config/sketchybar/plugins" = configSymlink "sketchybar/plugins";
      ".config/sketchybar/sketchybarrc" = configSymlink "sketchybar/sketchybar.sh";
      ".config/starship.toml" = configSymlink "starship/starship.toml";
      ".config/tmux/tmux.conf" = configSymlink "tmux/tmux.conf";
      ".config/tmux/tmux.conf.local" = configSymlink "tmux/tmux.conf.local";
      ".config/waybar" = configSymlink "waybar";
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
    pinentry.package = pkgs.pinentry-gnome3;
    pinentry.program = "pinentry-gnome3";
  };
}
