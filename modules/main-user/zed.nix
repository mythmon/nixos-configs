{config, ...}: let
  cfg = config.main-user;
in {
  home-manager.users.${cfg.userName}.programs.zed-editor = {
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
      lsp.nil.autoArchive = true;
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
