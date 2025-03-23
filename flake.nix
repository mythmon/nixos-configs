{
  description = "Mythmon's NixOS configurations";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      follows = "nixos-cosmic/nixpkgs";
    };
    nixpkgs-prusa-2-9-1-pr.url = "github:NixOS/nixpkgs/15fc832bbf4e420f7922e4ddf039eb37d4d570e5";
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
    nixpkgs,
    nixpkgs-prusa-2-9-1-pr,
    nixos-cosmic,
    nix-index-database,
    alejandra,
    ...
  }: let
    system = "x86_64-linux";
    overlay-prusa-2-9-1-pr = final: prev: {
      prusa-2-9-1-pr = import nixpkgs-prusa-2-9-1-pr {
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
        ({...}: {nixpkgs.overlays = [overlay-prusa-2-9-1-pr];})
        ({...}: {nix.settings.substituters = ["https://cache.nixos.org/"];})
        ./hosts/fractal
        ./modules/standard
        ./modules/maker
        ./modules/desktops/gnome
        nixos-cosmic.nixosModules.default
        ./modules/main-user
        ./modules/1password
        ./modules/roland-bridge-cast
        ./modules/music
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
        ({...}: {nixpkgs.overlays = [];})
        ./hosts/graphite
        ./modules/standard
        ./modules/desktops/gnome
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
