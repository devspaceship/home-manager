{ config, pkgs, ... }:
let
  configSymlink = fileName: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/${fileName}";
  };

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

    services.gpg-agent = {
      pinentry.package = pkgs.pinentry-gnome3;
      pinentry.program = "pinentry-gnome3";
    };
  };
}
