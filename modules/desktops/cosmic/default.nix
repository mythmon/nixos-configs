# Enable the Cosmic Desktop Environment.
{pkgs, ...}: {
  nix.settings = {
    substituters = ["https://cosmic.cachix.org"];
    trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
  };

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };

  # https://github.com/lilyinstarlight/nixos-cosmic/issues/220
  systemd.user.services.gnome-keyring = {
    preStart = ''
      ${pkgs.dbus}/bin/dbus-update-activation-environment --all
    '';
  };
}
