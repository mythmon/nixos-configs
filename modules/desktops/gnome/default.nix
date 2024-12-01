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

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-calendar
    gnome-contacts
    gnome-maps
    gnome-weather
    gnome-connections
    simple-scan
    totem
  ];

  home-manager.users.${config.main-user.userName} = {
    home = {
      packages = with pkgs; [
        dconf-editor
        gnomeExtensions.appindicator
        gnomeExtensions.tactile
        gnomeExtensions.caffeine
      ];
    };

    dconf.settings = {
      "org/gnome/desktop/interface".enable-hot-corners = false;
      "org/gnome/desktop/wm/preferences".num-workspaces = 1;
      "org/gnome/mutter".edge-tiling = false;
      "org/gnome/desktop/background" = let
        wallpaper-url = "file://${../../assets/gruvbox-dark-rainbow-2560x1440.png}";
      in {
        picture-uri = wallpaper-url;
        picture-uri-dark = wallpaper-url;
      };
      "org/gnome/shell".favorite-apps = with pkgs; [
        firefox.desktopItem.name
        discord.desktopItem.name
        "code.desktop"
        "org.gnome.Console.desktop"
        "spotify.desktop"
        "org.gnome.Nautilus.desktop"
        "steam.desktop"
      ];
      "org/gnome/shell" = {
        enabled-extensions = [
          "tactile@lundal.io"
          "appindicatorsupport@rgcjonas.gmail.com"
          "caffeine@patapon.info"
        ];
        disabled-extensions = [];
        disable-user-extensions = false;
      };
      "org/gnome/mutter/keybindings" = {
        switch-monitor = ["XF86Display"];
      };
    };
  };
}
