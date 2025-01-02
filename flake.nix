{
  description = "Mythmon's NixOS configurations";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      follows = "nixos-cosmic/nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixos-cosmic/nixpkgs";
    };
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = inputs @ {
    self,
    nixpkgs-stable,
    nixpkgs,
    nixos-cosmic,
    nix-index-database,
    alejandra,
    ...
  }: let
    system = "x86_64-linux";
    overlay-stable = final: prev: {
      stable = import nixpkgs-stable {
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
        ({...}: {nixpkgs.overlays = [overlay-stable];})
        ./hosts/fractal
        ./modules/standard
        ./modules/desktops/cosmic
        nixos-cosmic.nixosModules.default
        ./modules/main-user
        ./modules/1password
        ./modules/roland-bridge-cast
        ./modules/games/minecraft
        ./modules/games/picotron
        ./modules/games/steam
        {environment.systemPackages = [alejandra.defaultPackage.${system}];}
        nix-index-database.nixosModules.nix-index
        {programs.command-not-found.enable = false;}
      ];
    };

    nixosConfigurations.graphite = nixpkgs.lib.nixosSystem rec {
      inherit system;
      specialArgs = inputs;
      modules = [
        ({...}: {nixpkgs.overlays = [overlay-stable];})
        ./hosts/graphite
        ./modules/standard
        ./modules/desktops/cosmic
        nixos-cosmic.nixosModules.default
        ./modules/main-user
        ./modules/roland-bridge-cast
        ./modules/observable
        ./modules/1password
        {environment.systemPackages = [alejandra.defaultPackage.${system}];}
        nix-index-database.nixosModules.nix-index
        {programs.command-not-found.enable = false;}
      ];
    };
  };
}
