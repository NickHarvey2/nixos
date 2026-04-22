{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    daemon.enable = true;
    settings = {
      keymap_mode = "vim-normal";
      theme.name = "catppuccin-frappe-blue";
    };
    themes = {
      "catppuccin-frappe-blue" = {
        theme.name = "Catppuccin Frappe";
        colors = {
          AlertInfo = "#a6d189";
          AlertWarn = "#ef9f76";
          AlertError = "#e78284";
          Annotation = "#8caaee";
          Base = "#c6d0f5";
          Guidance = "#949cbb";
          Important = "#e78284";
          Title = "#8caaee";
        };
      };
    };
  };
}
