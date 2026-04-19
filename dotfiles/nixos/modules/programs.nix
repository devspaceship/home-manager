{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  programs.seahorse.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "devspaceship" ];
  };

  services.printing.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  services.gnome.gnome-keyring.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
}
