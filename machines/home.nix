{ config, pkgs, ... }:
let inherit (import ../lib.nix { inherit config; }) configSymlink;
in {
  home = {
    username = "devspaceship";
    homeDirectory = "/home/devspaceship";

    packages = with pkgs; [
      brave
      google-chrome
      minikube
      pinentry-gnome3
      podman-desktop
      podman-tui
      prismlauncher
      protonup-qt
      yubikey-manager
    ];

    file = {
      ".config/dunst" = configSymlink "dunst";
      ".config/gtk-3.0" = configSymlink "gtk-3.0";
      ".config/gtk-4.0" = configSymlink "gtk-4.0";
      ".config/hypr" = configSymlink "hypr";
      ".config/waybar" = configSymlink "waybar";
    };
  };

  services.gpg-agent = {
    pinentry.package = pkgs.pinentry-gnome3;
    pinentry.program = "pinentry-gnome3";
  };
}
