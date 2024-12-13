{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.main-user;
in {
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
      extraGroups = ["networkmanager" "wheel" "docker" "dialout"];
      isNormalUser = true;
      shell = pkgs.fish;
    };

    # Enable automatic login for the user.
    services.displayManager.autoLogin.user = cfg.userName;

    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      users.${cfg.userName} = import ./home.nix;
    };
  };
}
