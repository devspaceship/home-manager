{ config, pkgs, ... }:
{
  home = {
    username = "devspaceship";
    homeDirectory = "/Users/devspaceship";

    packages = with pkgs; [
      awscli2
      bun
      # nodejs_25
      kanata
    ];
  };
}
