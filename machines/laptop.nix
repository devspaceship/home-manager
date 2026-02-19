{ config, pkgs, ... }:
{
  home = {
    username = "devspaceship";
    homeDirectory = "/Users/devspaceship";

    packages = with pkgs; [
      bun
      nodejs_25
    ];
  };
}
