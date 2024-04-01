# home-manager user config
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

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
      diff-so-fancy.enable = true;
      enable = true;
      userEmail = "mythmon@gmail.com";
      userName = "Michael Cooper";

      extraConfig = {
        merge.conflictstyle = "diff3";
        rerere.enable = true;
        init.defaultBranch = "main";
      };
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

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions;
        [
          mkhl.direnv
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          github.copilot
          bbenoist.nix
          kamadorueda.alejandra
          vscodevim.vim
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-auto-scroll";
            publisher = "pejmannikram";
            version = "1.2.0";
            sha256 = "sha256-n9XVvXxrYbJ02fhBcWnPFhl50t2g/qeT1rRqsWHwrmE=";
          }
        ];
    };
  };

  home = {
    packages = with pkgs; [
      _1password
      _1password-gui
      btop
      discord
      fd
      fira-code-nerdfont
      firefox
      gimp
      htop
      httpie
      krita
      ncdu
      pavucontrol
      ripgrep
      spotify
      rustup
      units
      watchexec
    ];
    sessionVariables = {
      EDITOR = "vim";
      NIXOS_OZONE_WL = "1";
      VISUAL = "code --wait";
    };
    stateVersion = "23.11";
  };

  services = {
    syncthing = {
      enable = true;
    };
  };
}
