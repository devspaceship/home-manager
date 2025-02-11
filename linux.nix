{ config, pkgs, ... }:
{
  nixGL = {
    packages = pkgs.nixgl;
    defaultWrapper = "mesa";
    offloadWrapper = "nvidiaPrime";
    installScripts = [ "mesa" "nvidiaPrime" ];
  };

  home.homeDirectory = "/home/devspaceship";
  home.packages = [
    pkgs.nixgl
    (config.lib.nixGL.wrap pkgs.kitty)
  ];
}

