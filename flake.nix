{
  description = "Mythmon's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    alejandra,
    ...
  }: let
    system = "x86_64-linux";
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    formatter.${system} = alejandra.defaultPackage.${system};

    nixosConfigurations.fractal = nixpkgs.lib.nixosSystem rec {
      inherit system;
      specialArgs = inputs;
      modules = [
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
        ./hosts/fractal
        ./modules/standard
        ./modules/main-user
        ./modules/roland-bridge-cast
        {environment.systemPackages = [alejandra.defaultPackage.${system}];}
      ];
    };
  };
}
