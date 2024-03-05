{
  pkgs,
  home-manager,
  config,
  system,
  ...
}: {
  home-manager.users.${config.main-user.username} = {pkgs, ...}: {
    home = {
      packages = with pkgs; [
        atlauncher
      ];
    };
  };
}
