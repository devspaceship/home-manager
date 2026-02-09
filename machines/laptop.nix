{ config, pkgs, ... }:
{
  home = {
    username = "devspaceship";
    homeDirectory = "/Users/devspaceship";

    packages = with pkgs; [
      # <tmp>
      bun
      nodejs_25
      # </tmp>
    ];
  };
}
