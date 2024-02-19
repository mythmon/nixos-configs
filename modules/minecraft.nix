{ pkgs, home-manager, login, system, ... }:

{
  home-manager.users.${login} = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        atlauncher
      ];
    };
  };
}
