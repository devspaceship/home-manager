{
  description = "home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      mkHomeConfiguration =
        { system, machine }:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          platformModules = if pkgs.stdenv.isDarwin then [ ./modules/darwin.nix ] else [ ];
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./common.nix
            ./machines/${machine}.nix
          ]
          ++ platformModules;
        };
    in
    {
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
