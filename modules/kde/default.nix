# Enable the KDE Desktop Environment.
{
  config,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "plasmax11";
      sddm = {
        enable = true;
        wayland.enable = false;
      };
    };
    desktopManager.plasma6.enable = true;
  };
  programs.dconf.enable = true;
}
