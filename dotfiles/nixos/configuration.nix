{ ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/audio.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/programs.nix
    ./modules/security.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
