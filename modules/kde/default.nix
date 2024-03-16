# Enable the KDE Desktop Environment.
{
  config,
  lib,
  ...
}: {
  services = {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        defaultSession = "plasmax11";
        sddm = {
          enable = true;
          wayland.enable = false;
        };
      };
    };
  };
  programs.dconf.enable = true;
}
