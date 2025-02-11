{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, config, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgs; [
          curl
          git
          htop
          markdownlint-cli
          neofetch
          neovim
          nodejs_22
          pnpm
          python313
          tmux
          wget
        ];

        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.hostPlatform = "x86_64-darwin";

        security.pam.enableSudoTouchIdAuth = true;

        system.defaults = {
          dock.autohide = true;
        };

        programs.zsh.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;
      };
    in
    {
      # Build and activate darwin flake using:
      # $ darwin-rebuild switch --flake .#macos
      darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macos".pkgs;
    };
}
