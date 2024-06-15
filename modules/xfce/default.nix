# Enable the XFCE desktop environment
{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.pulseaudio = true;

  security.pam.services.lightdm.enableGnomeKeyring = true;

  services = {
    displayManager.defaultSession = "xfce";

    gnome.gnome-keyring.enable = true;

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
      ksuperkey
      xfce.xfce4-appfinder
    ];

    xfconf.settings = {
      xfce4-desktop = {
        "backdrop/screen0/monitorDP-2/workspace0/last-image" = "${../../assets/gruvbox-dark-rainbow-2560x1440.png}";
        "backdrop/screen0/monitorDP-0/workspace0/last-image" = "${../../assets/gruvbox-dark-rainbow-1440x2560.png}";
      };
    };
  };
}
