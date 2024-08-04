{
  config,
  lib,
  pkgs,
  ...
}: let
  worldofgoo2 = let
    pname = "WorldOfGoo2";
    version = "12329.171";
    arch = "x86_64";

    exec = "World_of_Goo_2-${arch}.${version}.AppImage";

    desktopItem = pkgs.makeDesktopItem {
      desktopName = "World of Goo 2";
      genericName = "World of Goo 2";
      categories = ["Game"];
      exec = "steam-run ${exec}";
      icon = "2dboy-worldofgoo2";
      name = "worldofgoo2";
    };

    helpMsg = ''
      We cannot download the full version automatically, as you require a license.
      Once you have bought a license, you need to add your downloaded version to
      the nix store.  You can do this by using
      "nix-prefetch-url file://\$PWD/${exec}" in the directory where you saved it.
    '';

    src = pkgs.requireFile {
      message = helpMsg;
      name = exec;
      sha256 = "1jibv9amqpc9955pxcjqnhwlynvr6ci4179g5ah5mppppmx9vlzx";
    };

    sourceRoot = pname;

    meta = with lib; {
      description = "Physics based puzzle game";
      longDescription = ''
        Build bridges, grow towers, terraform terrain, and fuel flying machines in the stunning followup to the multi-award winning World of Goo.
      '';
      homepage = "https://worldofgoo2.com";
      license = licenses.unfree;
      platforms = ["x86_64-linux"];
      maintainers = [];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };

    contents = pkgs.appimageTools.extract {inherit pname version src;};

    libPath = lib.makeLibraryPath [
      pkgs.libcurl-gnutls
    ];
  in
    pkgs.appimageTools.wrapType2 {
      inherit pname version src meta helpMsg;

      nativeBuildInputs = [pkgs.steam-run];

      extraInstallCommands = ''
        mkdir -p $out/bin $out/share/applications  $out/share/pixmaps
        cp ${desktopItem}/share/applications/worldofgoo2.desktop \
          $out/share/applications/worldofgoo2.desktop
        cp ${contents}/WorldOfGoo2.png $out/share/pixmaps/2dboy-worldofgoo2.png
      '';
    };
in {
  home-manager.users.${config.main-user.userName} = {pkgs, ...}: {
    home = {
      packages = [
        worldofgoo2
      ];
    };
  };
}
