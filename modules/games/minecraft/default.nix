{
  config,
  pkgs,
  ...
}: let
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
    version = "1.27.4";
    src = pkgs.fetchurl {
      url = "https://piston.feed-the-beast.com/app/ftb-app-linux-${version}-x86_64.AppImage";
      hash = "sha256-qgFCqPsRPYzTgCfVZNcH3P3IlY02wkeZF9aj3XULFKA=";
    };
    contents = pkgs.appimageTools.extractType2 {inherit pname version src;};
  in
    pkgs.appimageTools.wrapType2 {
      inherit pname version src;

      extraInstallCommands = ''
        install -D -m 444 "${contents}/ftb-app.desktop" "$out/share/applications/ftb-app.desktop"
        install -D -m 444 "${contents}/ftb-app.png" "$out/share/pixmaps/ftb-app.png"
        substituteInPlace "$out/share/applications/ftb-app.desktop" \
          --replace-fail "Exec=AppRun --no-sandbox %U" "Exec=${pname}"
      '';
    };
in {
  nixpkgs.overlays = [
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
