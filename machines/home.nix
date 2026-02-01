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
      polkit_gnome
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

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      Type = "simple";
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
