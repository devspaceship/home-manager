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
      # Java
      # jdk
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
      # nodejs_25
      # bun
      # biome
      # Python
      python313
      python313Packages.pip
      uv
      # Rust
      # rustup
      # Typst
      typst
    ];
  };
}
