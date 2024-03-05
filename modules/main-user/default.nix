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
    username = lib.mkOption {
      default = "mythmon";
      description = ''
        username of the main user
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.username} = {
      description = "Michael Cooper";
      extraGroups = ["networkmanager" "wheel" "docker"];
      isNormalUser = true;
      shell = pkgs.fish;
    };

    programs.steam.enable = true;

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.user = cfg.username;

    home-manager = {
      useGlobalPkgs = true;
      users.${cfg.username} = import ./home.nix;
    };
  };
}
