{ config, pkgs, ... }:
let
  inherit (import ../lib.nix { inherit config; }) configSymlink;
in
{
  home = {
    username = "devspaceship";
    homeDirectory = "/home/devspaceship";

    packages = with pkgs; [
      google-chrome
      pinentry-gnome3
      prismlauncher
      protonup-qt
    ];

    file = {
      ".config/hypr" = configSymlink "hypr";
      ".config/waybar" = configSymlink "waybar";
    };
  };

  services.gpg-agent = {
    pinentry.package = pkgs.pinentry-gnome3;
    pinentry.program = "pinentry-gnome3";
  };
}
