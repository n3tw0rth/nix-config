{
  description = "lil nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad.url = "github:nix-community/nix4nvchad";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix4nvchad,
      ...
    }:
    let
      overlay-john-fix = final: prev: {
        john = prev.john.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "openwall";
            repo = "john";
            rev = old.src.rev or "f514ece8ec4ae5e38ad75aaa322eac86d73dcd76";
            hash = "sha256-zO1/KUJe3LvYCGlwVpNg5uDwPRD0ql/7anErb7tywC0=";
          };
        });
      };

      # Pin claude-code ahead of nixpkgs to the latest upstream release.
      # Only this package is overridden; the rest of nixpkgs stays on the lock.
      # To bump: change `version`, then run
      #   nix store prefetch-file "https://downloads.claude.ai/claude-code-releases/<version>/linux-x64/claude"
      # and paste the printed hash below.
      overlay-claude-latest = final: prev: {
        claude-code = prev.claude-code.overrideAttrs (old: rec {
          version = "2.1.280";
          src = prev.fetchurl {
            url = "https://downloads.claude.ai/claude-code-releases/${version}/linux-x64/claude";
            hash = "sha256-HghQPb3zwssNcG0y80CCdziNHHbvEIZz6P5CwbMikls=";
          };
        });
      };
    in
    {
      nixosConfigurations = {
        wage-potato = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nix4nvchad; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/wage-potato/configuration.nix
            { nixpkgs.overlays = [ overlay-john-fix overlay-claude-latest ]; }
          ];
        };

        pwn-potato = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nix4nvchad; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/pwn-potato/configuration.nix
            { nixpkgs.overlays = [ overlay-john-fix overlay-claude-latest ]; }
          ];
        };

      };
    };
}
