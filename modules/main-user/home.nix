# home-manager user config
{
  pkgs,
  config,
  ...
}: let
  cfg = config.main-user;
in {
  home-manager.users.${cfg.userName} = {
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
          alias units="echo 'You mean numbat'; and numbat"
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
          default = "ddg";
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
          merge.conflictstyle = "zdiff3";
          rerere.enable = true;
          init.defaultBranch = "main";
          "credential \"https://github.com\"".helper = helper;
          "credential \"https://gist.github.com\"".helper = helper;

          user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIbDQ447YU9E/9dGLzcgqXCDpMCxK8Wqt2K9EvapBL/J";
          gpg.format = "ssh";
          "gpg \"ssh\"".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
          commit.gpgsign = true;
        };
      };

      jujutsu = {
        enable = true;
        settings = {
          git = {
            sign-on-push = true;
          };
          signing = {
            behavior = "drop";
            backend = "ssh";
            key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIbDQ447YU9E/9dGLzcgqXCDpMCxK8Wqt2K9EvapBL/J";
            backends.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
          };
          ui = {
            default-command = "log";
            pager = "less -FRX";
          };
          user = {
            name = "Michael Cooper";
            email = "mythmon@gmail.com";
          };
        };
      };

      mcfly = {
        enable = false;
        enableFishIntegration = true;
        fzf.enable = true;
      };

      starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          git_branch.disabled = true;
          custom.git_branch = {
            when = true;
            command = "jj root --ignore-working-copy > /dev/null 2>&1 || starship module git_branch";
            description = "Only show git_branch if we're not in a jj repository";
          };
        };
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
    };

    home = {
      packages = with pkgs; [
        alejandra
        btop
        cameractrls-gtk4
        ddcui
        ddcutil
        ddccontrol
        discord
        eza
        fd
        file
        ghostty
        gimp
        htop
        httpie
        imagemagick
        imv
        inkscape
        jq
        just
        krita
        moreutils
        ncdu
        nil
        nixd
        numbat
        obsidian
        pavucontrol
        pwvucontrol
        ripgrep
        rustup
        sgt-puzzles
        signal-desktop-bin
        spotify
        ungoogled-chromium
        unzip
        usbutils
        vlc
        watchexec
        zip
        zoom-us
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
  };
}
