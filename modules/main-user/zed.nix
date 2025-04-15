{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: let
  cfg = config.main-user;

  # Define default settings for Zed editor
  defaultSettings = {
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
    hide_mouse_while_typing = false; # this just flashes the cursor when enabled
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

  # Pretty-print the JSON for better readability
  defaultSettingsJson = pkgs.lib.strings.concatStrings [
    "\n"
    (builtins.readFile (pkgs.runCommand "pretty-settings.json" {} ''
      ${pkgs.jq}/bin/jq -S . > $out <<EOF
      ${builtins.toJSON defaultSettings}
      EOF
    ''))
  ];

  # Write settings file to Nix store
  defaultSettingsFile = pkgs.writeText "zed-default-settings.json" defaultSettingsJson;
in {
  home-manager.users.${cfg.userName} = {
    home.packages = [pkgs.zed-editor];
    # TODO how can we make extensions work in the mutable config approach, or
    # make the program.zed-editor approach allow mutable configs?
    # programs.zed-editor = {
    #   enable = true;
    #   extensions = ["dockerfile" "elixir" "git_firefly" "html" "make" "nix" "sql" "terraform" "toml"];
    # };

    # Always keep the immutable reference file up-to-date
    xdg.configFile."zed/settings-default.json" = {
      source = defaultSettingsFile;
      force = true;
    };

    # Add conditional file creation for mutable settings
    home.activation.zedInitialSettings = home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
      # Create Zed config directory if it doesn't exist
      run mkdir -p "$HOME/.config/zed"

      # Only create settings.json if it doesn't exist yet
      if [ ! -f "$HOME/.config/zed/settings.json" ]; then
        run cp -L ${defaultSettingsFile} "$HOME/.config/zed/settings.json"
        echo "Created initial Zed settings.json"
      fi
    '';
  };
}
