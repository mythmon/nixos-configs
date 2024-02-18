{ pkgs, home-manager, login, ... }:

{
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
