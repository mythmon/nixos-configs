{
  pkgs,
  home-manager,
  ...
}: let
  login = "mythmon";
in {
  imports = [home-manager.nixosModules.default];

  users.users.${login} = {
    description = "Michael Cooper";
    extraGroups = ["networkmanager" "wheel"];
    isNormalUser = true;
    shell = pkgs.fish;
  };

  programs.steam.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.user = login;

  home-manager = {
    useGlobalPkgs = true;

    users.${login} = {pkgs, ...}: {
      programs = {
        fish = {
          enable = true;
          interactiveShellInit = ''
            set fish_greeting # Disable greeting
          '';
          plugins = [
            {
              name = "z";
              src = pkgs.fishPlugins.z.src;
            }
          ];
        };

        gh.enable = true;

        git = {
          enable = true;
          userEmail = "mythmon@gmail.com";
          userName = "Michael Cooper";
        };

        starship = {
          enable = true;
          enableFishIntegration = true;
        };

        vim = {
          enable = true;
          settings = {
            expandtab = true;
            shiftwidth = 2;
            smartcase = true;
            tabstop = 2;
          };
        };

        vscode.enable = true;
      };

      home = {
        packages = with pkgs; [
          _1password
          _1password-gui
          discord
          fd
          fira-code-nerdfont
          firefox
          httpie
          ncdu
          ripgrep
          pavucontrol
          spotify
          gnomeExtensions.tactile
          gnomeExtensions.appindicator
        ];
        sessionVariables = {
          EDITOR = "vim";
          NIXOS_OZONE_WL = "1";
          VISUAL = "code --wait";
        };
        stateVersion = "23.11";
      };

      dconf.settings = {
        "org/gnome/desktop/interface".enable-hot-corners = false;
        "org/gnome/desktop/wm/preferences".num-workspaces = 1;
        "org/gnome/mutter".edge-tiling = false;
      };

      services = {
        syncthing = {
          enable = true;
          tray.enable = true;
        };
      };
    };
  };
}
