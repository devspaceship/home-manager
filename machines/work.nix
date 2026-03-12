{ config, pkgs, ... }:
{
  home = {
    username = "thomas";
    homeDirectory = "/Users/thomas";

    packages = with pkgs; [
      act
    ];
  };
}
