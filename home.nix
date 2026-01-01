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
      gcr
      gh
      git
      gnumake
      gnupg
      go
      google-chrome
      gopls
      kitty
      lazygit
      libgcc
      mise
      neofetch
      neovim
      nmap
      nodejs_24
      oh-my-zsh
      pinentry-curses
      prismlauncher
      protonup-qt
      python314
      ripgrep
      rocmPackages.llvm.clang-unwrapped
      starship
      tmux
      tree
      yazi
      zathura
      zellij
      zsh
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

      "bin/cc".source = "${pkgs.rocmPackages.llvm.clang-unwrapped}/bin/clang";
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
