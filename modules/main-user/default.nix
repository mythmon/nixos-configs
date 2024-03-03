{
  pkgs,
  home-manager,
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
      extraGroups = ["networkmanager" "wheel"];
      isNormalUser = true;
      shell = pkgs.fish;
    };

    programs.steam.enable = true;

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.user = cfg.userName;

    home-manager = {
      useGlobalPkgs = true;
      users.${cfg.userName} = import ./home.nix;
    };
  };
}
