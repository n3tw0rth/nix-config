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
    in
    {
      nixosConfigurations = {
        wage-potato = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nix4nvchad; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/wage-potato/configuration.nix
            { nixpkgs.overlays = [ overlay-john-fix ]; }
          ];
        };

        pwn-potato = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nix4nvchad; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/pwn-potato/configuration.nix
            { nixpkgs.overlays = [ overlay-john-fix ]; }
          ];
        };

      };
    };
}
