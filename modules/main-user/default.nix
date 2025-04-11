{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.main-user;
in {
  imports = [
    ./home.nix
    ./zed.nix
  ];

  options.main-user = {
    enable = lib.mkEnableOption "enable main-user module";
    userName = lib.mkOption {
      default = "mythmon";
      description = ''
        username of the main user
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      description = "Michael Cooper";
      extraGroups = ["networkmanager" "wheel" "docker" "dialout" "i2c"];
      isNormalUser = true;
      shell = pkgs.fish;
    };

    # Enable automatic login for the user.
    # Disabled because it might be causing a bug?
    #services.displayManager.autoLogin.user = cfg.userName;

    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
    };
  };
}
