{
  description = "Mythmon's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
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
    home-manager,
    alejandra,
    ...
  }: {
    formatter.x86_64-linux = alejandra.defaultPackage.x86_64-linux;

    nixosConfigurations.fractal = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        ./hosts/fractal
        ./modules/standard
        ./modules/main-user
        ./modules/roland-bridge-cast
        {environment.systemPackages = [alejandra.defaultPackage.${system}];}
        {
          _module.args = {
            login = "mythmon";
          };
        }
      ];
    };
  };
}
