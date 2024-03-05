{
  pkgs,
  home-manager,
  config,
  system,
  ...
}: {
  home-manager.users.${config.main-user.userName} = {pkgs, ...}: {
    home = {
      packages = with pkgs; [
        atlauncher
      ];
    };
  };
}
