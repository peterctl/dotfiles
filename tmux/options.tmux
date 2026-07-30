# Make Tmux report focus events to terminal applications.
set -g focus-events on

# Make panes and windows start numbering from 1 so they are more intuitive to
# access from keyboard shortcuts.
set -g base-index 1
setw -g pane-base-index 1

# Enable mouse support.
set -g mouse on

# Fix an issue with neovim taking longer to execute ESC. See:
# https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
set -sg escape-time 10  # milliseconds

# TERM information and true color support
set -as terminal-features ",*:RGB"
set -ga terminal-overrides ",${TERM}:Tc"
