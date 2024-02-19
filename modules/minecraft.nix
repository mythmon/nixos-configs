{ pkgs, home-manager, nix-alien, login, system, ... }:

{
  environment.systemPackages = [ nix-alien.packages.${system}.nix-alien ];
  programs.nix-ld.enable = true;

  home-manager.users.${login} = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        atlauncher
        minecraft
        zulu17
      ];
    };
  };
}
