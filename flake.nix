{
  description = "home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quien.url = "github:retlehs/quien";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        # Packages broken on unstable can be pulled from the stable
        # release instead, e.g. `pkgs.stable.sketchybar`.
        (final: prev: {
          stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv.hostPlatform) system;
          };
          quien = inputs.quien.packages.${prev.stdenv.hostPlatform.system}.quien;
          # The nightly test suite is broken as of 2026-07; skip it.
          neovim = prev.neovim.overrideAttrs (_: {
            doCheck = false;
          });
        })
      ];
      mkHomeConfiguration =
        {
          system,
          machine,
        }:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          platformModules = if pkgs.stdenv.isDarwin then [ ./modules/darwin.nix ] else [ ];
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./common.nix
            ./modules/languages.nix
            ./machines/${machine}.nix
          ]
          ++ platformModules;
        };
    in
    {
      nixosConfigurations = {
        home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./dotfiles/nixos/configuration.nix ];
        };
      };

      homeConfigurations = {
        home = mkHomeConfiguration {
          system = "x86_64-linux";
          machine = "home";
        };

        laptop = mkHomeConfiguration {
          system = "aarch64-darwin";
          machine = "laptop";
        };

        work = mkHomeConfiguration {
          system = "aarch64-darwin";
          machine = "work";
        };
      };
    };
}
