{ config, pkgs, ... }:
let
  inherit (import ../lib.nix { inherit config; }) configSymlink;
in
{
  home.packages = with pkgs; [
    jankyborders
    sketchybar
    pinentry_mac
  ];

  home.file = {
    ".config/aerospace/aerospace.toml" = configSymlink "aerospace/aerospace.toml";
    ".config/borders/bordersrc" = configSymlink "borders/borders.sh";
    ".config/nix-darwin" = configSymlink "nix-darwin";
    ".config/sketchybar/plugins" = configSymlink "sketchybar/plugins";
    ".config/sketchybar/sketchybarrc" = configSymlink "sketchybar/sketchybar.sh";
  };

  services.gpg-agent = {
    pinentry.package = pkgs.pinentry_mac;
    pinentry.program = "pinentry-mac";
  };
}
