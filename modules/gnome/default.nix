# Enable the GNOME Desktop Environment.
{
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany
    gnome-calendar
    gnome-contacts
    gnome-maps
    gnome-weather
    pkgs.gnome-connections
    simple-scan
    totem
  ];

  home-manager.users.${config.main-user.userName} = {
    home = {
      packages = with pkgs; [
        gnome.dconf-editor
        gnomeExtensions.appindicator
        gnomeExtensions.tactile
      ];
    };

    dconf.settings = {
      "org/gnome/desktop/interface".enable-hot-corners = false;
      "org/gnome/desktop/wm/preferences".num-workspaces = 1;
      "org/gnome/mutter".edge-tiling = false;
    };
  };
}
