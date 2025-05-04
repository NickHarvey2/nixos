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
      extraConfig = ''
        set -g @catppuccin_flavour 'frappe' # options: latte, frappe, macchiato, mocha

        set -g @catppuccin_window_status_style "rounded"

        set -g @catppuccin_window_number_position "right"
        set -g @catppuccin_status_connect_separator "no"

        set -g @catppuccin_window_current_text_color "#{@thm_surface_1}"
        set -g @catppuccin_window_current_number_color "#{@thm_teal}"
        set -g @catppuccin_window_text_color "#{@thm_surface_0}"
        set -g @catppuccin_window_number_color "#{@thm_surface_2}"
        set -g @catppuccin_window_text "#W"
        set -g @catppuccin_window_current_text "#W"

        # there is a bug in v2.1.3 that causes window separators' colors to be inverted when the status line background is set to none (transparent)
        # https://github.com/catppuccin/tmux/issues/403
        # commenting this out until that is resolved
        # set -g @catppuccin_status_background "none"
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_status_middle_separator ""
        set -g @catppuccin_status_right_separator " "
      '';
    }
  ];
  extraConfig = ''
    set -g status-right-length 100
    set -g status-right "#{E:@catppuccin_status_session}#{E:@catppuccin_status_user}#{E:@catppuccin_status_host}#{E:@catppuccin_status_date_time}"
    set -g status-left " "

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
    bind \\ set-option status
  '';
}
