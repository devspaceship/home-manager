{ config, pkgs, ... }:
let
  inherit (import ../lib.nix { inherit config; }) configSymlink;
in
{
  home = {
    username = "devspaceship";
    homeDirectory = "/home/devspaceship";

    packages = with pkgs; [
      bun
      nodejs_25
      brave
      google-chrome
      kitty
      lldb_22
      minikube
      podman-desktop
      podman-tui
      prismlauncher
      protonup-qt
      rustup
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
}
