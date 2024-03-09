# Enable the KDE Desktop Environment.
{
  config,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "plasma";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    desktopManager.plasma6.enable = true;
  };
  programs.dconf.enable = true;
}
