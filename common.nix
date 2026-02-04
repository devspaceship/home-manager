{ config, pkgs, ... }:
let inherit (import ./lib.nix { inherit config; }) configSymlink;
in {
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      bat
      btop
      cmatrix
      fd
      fzf
      gh
      gimp2
      git
      gnupg
      go-task
      just
      jq
      kitty
      kubectl
      lazygit
      neofetch
      neovim
      nerd-fonts.fira-code
      nmap
      oh-my-zsh
      opencode
      ripgrep
      starship
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
      ".config/btop/btop.conf" = configSymlink "btop/btop.conf";
      ".config/kitty" = configSymlink "kitty";
      ".config/nix" = configSymlink "nix";
      ".config/nvim" = configSymlink "nvim";
      ".config/opencode/opencode.jsonc" =
        configSymlink "opencode/opencode.jsonc";
      ".config/lazygit/config.yml" = configSymlink "lazygit/config.yml";
      ".config/starship.toml" = configSymlink "starship/starship.toml";
      ".config/tmux/tmux.conf" = configSymlink "tmux/tmux.conf";
      ".config/tmux/tmux.conf.local" = configSymlink "tmux/tmux.conf.local";
    };

    sessionVariables = { EDITOR = "nvim"; };
  };

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };
}
