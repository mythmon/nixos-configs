{
  pkgs,
  home-manager,
  config,
  system,
  lib,
  ...
}: let
  overlay-atlauncher-version = self: super: {
    atlauncher = super.atlauncher.overrideAttrs (oldAttrs: rec {
      version = "3.4.35.9";
      src = super.fetchurl {
        url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${version}/ATLauncher-${version}.jar";
        hash = "sha256-Y2MGhzq4IbtjEG+CER+FWU8CY+hn5ehjMOcP02zIsR4=";
      };
    });
  };
  overlay-atlauncher-steam-run = self: super: {
    atlauncher = super.atlauncher.overrideAttrs (oldAttrs: rec {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.steam-run];
      desktopItems = [
        (super.makeDesktopItem {
          categories = ["Game"];
          desktopName = "ATLauncher (steam-run)";
          exec = "steam-run atlauncher";
          icon = "atlauncher";
          name = "atlauncher";
        })
      ];
    });
  };
in {
  nixpkgs.overlays = [
    overlay-atlauncher-version
    overlay-atlauncher-steam-run
  ];
  home-manager.users.${config.main-user.userName} = {pkgs, ...}: {
    home = {
      packages = with pkgs; [
        atlauncher
      ];
    };
  };
}
