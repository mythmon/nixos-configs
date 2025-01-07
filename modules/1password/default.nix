{
  config,
  pkgs,
  ...
}: let
  cfg = config.main-user;

  overlay-1password = self: super: {
    _1password-gui = super._1password-gui.overrideAttrs (oldAttrs: {
      postFixup = ''
        wrapProgram $out/bin/1password --set ELECTRON_OZONE_PLATFORM_HINT x11
      '';
    });
  };
in {
  nixpkgs.overlays = [
    overlay-1password
  ];

  home-manager.users.${cfg.userName} = {
    home = {
      packages = with pkgs; [
        _1password-cli
      ];
    };

    programs.ssh = {
      matchBlocks = {
        "*" = {
          extraOptions = {
            IdentityAgent = "~/.1password/agent.sock";
          };
        };
      };
    };
  };

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [cfg.userName];
    };
  };

  # Gnome keyring seems to have some trouble with 1password. Use keepassxc
  # instead, which provides a system keyring.
  environment.systemPackages = with pkgs; [keepassxc];
  services.gnome.gnome-keyring.enable = false;
}
