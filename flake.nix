{
  description = "Mythmon's NixOS configurations";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs-stable,
    nixpkgs,
    nix-index-database,
    home-manager,
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
        ({
          config,
          pkgs,
          ...
        }: {nixpkgs.overlays = [overlay-stable];})
        ./hosts/fractal
        ./modules/standard
        ./modules/xfce
        ./modules/main-user
        ./modules/roland-bridge-cast
        ./modules/minecraft
        ./modules/steam
        {environment.systemPackages = [alejandra.defaultPackage.${system}];}
        nix-index-database.nixosModules.nix-index
        {programs.command-not-found.enable = false;}
      ];
    };
  };
}
