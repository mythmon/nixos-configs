{
  config,
  home-manager,
  lib,
  pkgs,
  system,
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
  ftb-electron = let
    pname = "ftb-electron";
    version = "1.25.11";
    src = pkgs.fetchurl {
      url = "https://piston.feed-the-beast.com/app/ftb-app-${version}-x86_64.AppImage";
      hash = "sha256-mxcqcQA6plQtoKtJ/nIPMRU/iar4pmLGneGE0F/E/fY=";
    };
    contents = pkgs.appimageTools.extractType2 {inherit pname version src;};
  in
    pkgs.appimageTools.wrapType2 {
      inherit pname version src;

      extraInstallCommands = ''
        install -D -m 444 "${contents}/ftb-app.desktop" "$out/share/applications/ftb-app.desktop"
        install -D -m 444 "${contents}/ftb-app.png" "$out/share/pixmaps/ftb-app.png"
        #substitueInPlace "$out/share/applications/ftb-app.desktop" --replace "Exec=.*" "Exec=${contents}/ftb-app"
      '';
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
        ftb-electron
      ];
    };
  };
}
