# Enable the XFCE desktop environment
{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.pulseaudio = true;

  services = {
    displayManager.defaultSession = "xfce";
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
  };

  home-manager.users.${config.main-user.userName} = {
    home.packages = with pkgs; [
      xfce.xfce4-whiskermenu-plugin
    ];
  };
}
