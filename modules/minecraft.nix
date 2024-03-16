{
  pkgs,
  home-manager,
  config,
  system,
  ...
}: let
  overlay-atlauncher = self: super: {
    atlauncher = super.atlauncher.overrideAttrs (oldAttrs: rec {
      version = "3.4.35.9";
      src = super.fetchurl {
        url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${version}/ATLauncher-${version}.jar";
        hash = "sha256-Y2MGhzq4IbtjEG+CER+FWU8CY+hn5ehjMOcP02zIsR4=";
      };
    });
  };
in {
  nixpkgs.overlays = [overlay-atlauncher];
  home-manager.users.${config.main-user.userName} = {pkgs, ...}: {
    home = {
      packages = with pkgs; [
        atlauncher
      ];
    };
  };
}
