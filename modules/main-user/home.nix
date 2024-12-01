# home-manager user config
{pkgs, ...}: {
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

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

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

    zed-editor = {
      enable = true;
      userSettings = {
        autosave = "on_focus_change";
        auto_update = false;
        base_keymap = "VSCode";

        languages.Rust.tab_size = 4;

        vim_mode = true;
        ui_font_size = 16;
        buffer_font_size = 16;
        theme = {
          mode = "system";
          light = "One Light";
          dark = "One Dark";
        };
        tab_size = 2;
      };
    };
  };

  home = {
    packages = with pkgs; [
      _1password-cli
      _1password-gui
      alejandra
      btop
      discord
      fd
      fira-code-nerdfont
      gimp
      htop
      httpie
      jq
      imagemagick
      imv
      krita
      ncdu
      nixd
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
      zed-editor
    ];
    sessionVariables = {
      EDITOR = "vim";
      NIXOS_OZONE_WL = "1";
    };
    stateVersion = "23.11";
  };

  services = {
    syncthing = {
      enable = true;
    };
  };
}
