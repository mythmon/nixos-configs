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

        export OP_PLUGIN_ALIASES_SOURCED=1
        alias gh="op plugin run -- gh"
      '';
      plugins = [
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
      ];
    };

    firefox = {
      enable = true;
      profiles.default.search = {
        default = "DuckDuckGo";
        force = true;
      };
      nativeMessagingHosts = with pkgs; [
        gnome-browser-connector
      ];
    };

    fzf.enable = true;

    gh.enable = true;

    git = {
      diff-so-fancy.enable = true;
      enable = true;
      ignores = [".direnv"];
      userEmail = "mythmon@gmail.com";
      userName = "Michael Cooper";

      extraConfig = {
        merge.conflictstyle = "diff3";
        rerere.enable = true;
        init.defaultBranch = "main";
      };
    };

    mcfly = {
      enable = true;
      enableFishIntegration = true;
      fzf.enable = true;
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
          vadimcn.vscode-lldb
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
      alejandra
      blender
      btop
      discord
      fd
      fira-code-nerdfont
      gimp
      htop
      httpie
      jq
      imagemagick
      krita
      ncdu
      parallel
      pavucontrol
      prusa-slicer
      ripgrep
      rustup
      signal-desktop
      spotify
      ungoogled-chromium
      units
      vlc
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
