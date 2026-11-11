{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    nix-ld.enable = true;
    zsh.enable = true;

    seahorse.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "devspaceship" ];
    };
  };

  services.printing.enable = true;

  # services.ollama = {
  #   enable = true;
  #   package = pkgs.ollama-cuda;
  # };

  services.gnome.gnome-keyring.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
}
