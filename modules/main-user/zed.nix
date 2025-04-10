{config, ...}: let
  cfg = config.main-user;
in {
  home-manager.users.${cfg.userName}.programs.zed-editor = {
    enable = true;

    # package = pkgs.zed-editor.overrideAttrs (
    #   finalAttrs: prevAttrs: {
    #     version = "0.177.7";
    #     src = prevAttrs.src.override {
    #       tag = "v${finalAttrs.version}-pre";
    #       hash = "sha256-arO8yz+0jQ6ay+MzKDhIIZ2h1ssOt9ahw2yBu31Ug2Y=";
    #     };
    #     postPatch =
    #       builtins.replaceStrings [prevAttrs.version] [finalAttrs.version]
    #       prevAttrs.postPatch;
    #     cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
    #       inherit (finalAttrs) pname version src;
    #       hash = "sha256-LCGLeVIOWRlcZdcyQ7G9GUre9+dPGlZT6h8maAEyPVY=";
    #     };
    #     env =
    #       prevAttrs.env
    #       // {
    #         RELEASE_VERSION = finalAttrs.version;
    #       };
    #     patches = [
    #       ./0001-zed-generate-licenses-no-fail.patch
    #       ./0002-zed-linux-linker.patch
    #       "script/patches/use-cross-platform-livekit.patch"
    #     ];
    #   }
    # );

    extensions = ["dockerfile" "elixir" "git_firefly" "html" "make" "nix" "sql" "terraform" "toml"];
    userSettings = {
      assistant = {
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
        version = "2";
      };
      autosave = "on_focus_change";
      auto_update = false;
      base_keymap = "VSCode";
      buffer_font_size = 16;
      cursor_blink = false;
      double_click_in_multibuffer = "open";
      features.edit_prediction_provider = "zed";
      format_on_save = "off";
      languages.Rust.tab_size = 4;
      lsp = {
        nil.autoArchive = true;
        rust-analyzer.binary.path_lookup = true;
      };
      preview_tabs.enabled = false;
      scrollbar.show = "always";
      show_edit_predictions = true;
      show_whitespaces = "selection";
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
        env.EDITOR = "zeditor --wait";
      };
      ui_font_size = 16;
      use_autoclose = false;
      use_auto_surround = false;
      vim.use_smartcase_find = true;
      vim_mode = true;
      wrap_guides = [80 100 120];
    };
  };
}
