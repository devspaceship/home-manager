{ config, pkgs, ... }:
let
  configSymlink = fileName: {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/dotfiles/${fileName}";
  };

in
{
  home = {
    username = "thomas";
    homeDirectory = "/Users/thomas";

    packages = with pkgs; [
      jankyborders
      sketchybar
      pinentry_mac
    ];

    file = {
      ".config/aerospace/aerospace.toml" = configSymlink "aerospace/aerospace.toml";
      ".config/borders/bordersrc" = configSymlink "borders/borders.sh";
      ".config/nix-darwin" = configSymlink "nix-darwin";
      ".config/sketchybar/plugins" = configSymlink "sketchybar/plugins";
      ".config/sketchybar/sketchybarrc" = configSymlink "sketchybar/sketchybar.sh";
    };
  };

  services.gpg-agent = {
    pinentry.package = pkgs.pinentry_mac;
    pinentry.program = "pinentry-mac";
  };
}
