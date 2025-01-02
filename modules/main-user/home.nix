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
      delta.enable = true;
      enable = true;
      ignores = [".direnv"];
      userEmail = "mythmon@gmail.com";
      userName = "Michael Cooper";

      extraConfig = let
        op_path = "/run/wrappers/bin/op";
        helper = "!${op_path} plugin run -- gh auth git-credential";
      in {
        # autocrlf = "input";
        merge.conflictstyle = "zdiff3";
        rerere.enable = true;
        init.defaultBranch = "main";
        "credential \"https://github.com\"".helper = helper;
        "credential \"https://gist.github.com\"".helper = helper;
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
      extensions = ["nix" "toml" "elixir" "make" "html" "dockerfile" "git_firefly"];
      userSettings = {
        autosave = "on_focus_change";
        auto_update = false;
        base_keymap = "VSCode";
        buffer_font_size = 16;
        cursor_blink = false;
        format_on_save = "off";
        languages.Rust.tab_size = 4;
        preview_tabs.enabled = false;
        scrollbar.show = "always";
        show_inline_completions = true;
        theme = {
          mode = "dark";
          light = "One Light";
          dark = "One Dark";
        };
        tab_bar.show_nav_history_buttons = false;
        tab_size = 2;
        tabs.git_status = true;
        terminal = {
          dock = "right";
          option_as_meta = true;
          copy_on_select = true;
          env.EDITOR = "vim";
        };
        ui_font_size = 16;
        use_autoclose = false;
        use_auto_surround = false;
        vim.use_smartcase_find = true;
        vim_mode = true;
        wrap_guides = [80 100 120];
      };
    };
  };

  home = {
    packages = with pkgs; [
      _1password-cli
      alejandra
      btop
      discord
      eza
      fd
      file
      nerd-fonts.fira-code
      gimp
      htop
      httpie
      imagemagick
      imv
      jq
      just
      krita
      ncdu
      nil
      nixd
      obsidian
      parallel
      pavucontrol
      pwvucontrol
      prusa-slicer
      ripgrep
      rustup
      signal-desktop
      spotify
      ungoogled-chromium
      units
      unzip
      vlc
      watchexec
      zed-editor
      zip
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
