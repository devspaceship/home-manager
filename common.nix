{ config, pkgs, ... }:
let
  inherit (import ./lib.nix { inherit config; }) configSymlink;
in
{
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      bat
      btop
      cmatrix
      fastfetch
      fd
      file
      fzf
      gh
      # gimp2
      git
      hex
      just
      jq
      kubectl
      lazygit
      lsof
      neovim
      nerd-fonts.fira-code
      nmap
      pre-commit
      ripgrep
      skim
      starship
      tldr
      tmux
      tree
      tree-sitter
      ueberzugpp
      unzip
      wget
      xz
      yazi
      # zathura
      zellij
      zsh
      # Nushell
      carapace
      fnm
      nushell
    ];

    file = {
      ".gitconfig" = configSymlink "git/conf";
      ".zsh_helpers" = configSymlink "zsh/zsh_helpers";
      ".zprofile" = configSymlink "zsh/zprofile";
      ".zshrc" = configSymlink "zsh/zshrc";
      ".config/nushell/config.nu" = configSymlink "nushell/config.nu";
      ".config/nushell/env.nu" = configSymlink "nushell/env.nu";
      ".config/btop/btop.conf" = configSymlink "btop/btop.conf";
      ".config/kitty" = configSymlink "kitty";
      ".config/nvim" = configSymlink "nvim";
      ".claude/settings.json" = configSymlink "claude/settings.json";
      ".config/opencode/agents" = configSymlink "opencode/agents";
      ".config/opencode/opencode.jsonc" = configSymlink "opencode/opencode.jsonc";
      ".config/opencode/tui.jsonc" = configSymlink "opencode/tui.jsonc";
      ".config/lazygit/config.yml" = configSymlink "lazygit/config.yml";
      ".config/starship.toml" = configSymlink "starship/starship.toml";
      ".config/tmux/tmux.conf" = configSymlink "tmux/tmux.conf";
      ".config/tmux/tmux.conf.local" = configSymlink "tmux/tmux.conf.local";
      ".config/zellij" = configSymlink "zellij";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
}
