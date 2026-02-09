{ pkgs, ... }:
{
  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      # Bash
      bash
      # C
      gcc
      # Go
      go
      gopls
      # Lua
      luajitPackages.luarocks
      stylua
      # Make
      gnumake
      mbake
      # Nix
      nil
      nixfmt
      statix
      # TypeScript
      # bun
      # nodejs_25
      # Python
      python313
      python313Packages.pip
      # Rust
      rustup
    ];
  };
}
