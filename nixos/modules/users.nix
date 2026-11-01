{ pkgs, ... }:
{
  users.users.devspaceship = {
    isNormalUser = true;
    description = "Thomas Saint-Gérand";
    extraGroups = [
      "input"
      "libvirtd"
      "networkmanager"
      "podman"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyG0chfBt6coIm3D6DlvvsaBer7Gan/65PgUlPdmu/f"
    ];
  };
  users.defaultUserShell = pkgs.zsh;
}
