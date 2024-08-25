{pkgs}: {
  enable = true;
  terminal = "tmux-256color";
  # Force tmux to use /tmp for sockets (WSL2 compat)
  secureSocket = false;
  shortcut = "Space";
  plugins = with pkgs.tmuxPlugins; [
    sensible
    {
      plugin = catppuccin;
      # TODO update this to only use one of the catppuccin status modules settings, both are here now as a temp patch so I don't need to worry about it again in the short term
      extraConfig = ''
        set -g @catppuccin_flavour 'frappe' # options: latte, frappe, macchiato, mocha

        set -g @catppuccin_status_modules_right "session user host battery date_time"
        set -g @catppuccin_status_modules "session user host battery date_time"
        set -g @catppuccin_window_status_enable "no"
        set -g @catppuccin_window_status_icon_enable "no"
        set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_right_separator " "
        set -g @catppuccin_window_number_position "right"
        set -g @catppuccin_window_middle_separator ""
        set -g @catppuccin_window_default_fill "none"
        set -g @catppuccin_window_current_fill "all"
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_current_text "#W"

        set -g @catppuccin_status_default "on"
        set -g @catppuccin_status_left_separator " "
        set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_fill "all"
        set -g @catppuccin_status_connect_separator "no"

        set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
      '';
    }
    battery
  ];
  extraConfig = ''
    setw -g mode-keys vi
    unbind-key -T copy-mode-vi v                             # Unbind v for block toggling
    bind-key -T copy-mode-vi 'v' send -X begin-selection     # Begin selection in copy mode.
    bind-key -T copy-mode-vi 'V' send -X select-line;        # Begin selection in copy mode.
    bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle  # Begin selection in copy mode.
    bind-key -T copy-mode-vi 'y' send -X copy-selection      # Yank selection in copy mode.

    # Set previous and next to something better
    unbind P
    unbind N
    unbind ,
    bind , previous-window
    bind . next-window
    bind n command-prompt -I'#W' 'rename-window "%%"'

    # Start windows and panes at 1, not 0
    set -g base-index 1
    setw -g pane-base-index 1

    unbind l
    bind -n M-h resize-pane -L 5
    bind -n M-j resize-pane -D 5
    bind -n M-k resize-pane -U 5
    bind -n M-l resize-pane -R 5
    bind -n M-Left resize-pane -L 5
    bind -n M-Down resize-pane -D 5
    bind -n M-Up resize-pane -U 5
    bind -n M-Right resize-pane -R 5
    bind k select-pane -U
    bind j select-pane -D
    bind h select-pane -L
    bind l select-pane -R
    bind Space last-window
    bind | split-window -h
    bind - split-window -v
  '';
}
