{ pkgs, home-manager, ... }:

let
  login = "mythmon";
in {
  imports = [
    home-manager.nixosModules.default
  ];

  users.users.${login} = {
    description = "Michael Cooper";
    extraGroups = [ "networkmanager" "wheel" ];
    isNormalUser = true;
    shell = pkgs.fish;
  };

  programs.steam.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.user = login;

  home-manager = {
    useGlobalPkgs = true;

    users.${login} = { pkgs, ... }: {
      programs = {
        fish = {
          enable = true;
          interactiveShellInit = ''
            set fish_greeting # Disable greeting
          '';
          plugins = [
            { name = "z"; src = pkgs.fishPlugins.z.src; }
          ];
        };

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
          atlauncher
          discord 
          fd
          firefox
          httpie
          ncdu
          ripgrep
          pavucontrol
          spotify
        ];
        sessionVariables = {
          EDITOR="vim";
          NIXOS_OZONE_WL = "1";
          VISUAL="code --wait";
        };
        stateVersion = "23.11";
      };
    };
  };
}
