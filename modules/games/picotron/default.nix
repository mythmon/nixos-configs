{
  config,
  lib,
  pkgs,
  ...
}: let
  pname = "picotron";
  version = "0.1.1d";
  arch = "x64_64";
  _arch = "amd64";
  zip_name = "${pname}_${version}_${_arch}.zip";

  desktopItem = pkgs.makeDesktopItem {
    name = "picotron";
    exec = "picotron";
    desktopName = "Picotron";
    categories = ["Development"];
    icon = "picotron";
  };

  picotron = pkgs.stdenv.mkDerivation {
    inherit pname version arch;

    meta = {
      description = "A fantasy workstation";
      longDescription = ''
        Picotron is a Fantasy Workstation: a self-contained creative environment
        built for imaginary hardware. Create cute Lua apps that can be run
        inside Picotron as windowed userland processes, shared as cartridge
        files, or exported to stand-alone HTML apps.
      '';
      homepage = "https://www.lexaloffle.com/picotron.php";
      license = lib.licenses.unfree;
      platforms = ["x86_64-linux"];
      maintainers = [];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };

    nativeBuildInputs = [pkgs.unzip pkgs.autoPatchelfHook];

    src = pkgs.requireFile {
      message = ''
        We cannot download the full version automatically, as you require a license.
        Once you have bought a license, you need to add your downloaded version to
        the nix store.  You can do this by using
        "nix-prefetch-url file://\$PWD/${zip_name}" in the directory where you saved it.
      '';
      name = zip_name;
      sha256 = "sha256-9Hl3m48s5NOvdBdqWDlRhnrpvCsy5JbAR0CWjvMxZ4U=";
    };

    installPhase = ''
      install -Dm555 -t $out/opt/picotron ./picotron ./picotron.dat
      install -Dm444 ${desktopItem}/share/applications/picotron.desktop $out/share/applications/picotron.desktop
      install -Dm444 ./lexaloffle-picotron.png $out/share/pixmaps/picotron.png
      mkdir -p $out/bin
      ln -s $out/opt/picotron/picotron $out/bin/picotron
    '';

    # https://www.lexaloffle.com/bbs/?tid=141116
    runtimeDependencies = with pkgs; [
      xorg.libXrandr # for renderer
      libGL # for renderer
      alsa-lib # for audio
      udev # for gamepads
      wget # for downloading carts
    ];
  };
in {
  home-manager.users.${config.main-user.userName} = {...}: {
    home = {
      packages = [picotron];
    };
  };
}
