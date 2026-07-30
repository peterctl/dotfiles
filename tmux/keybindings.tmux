# Keep scroll position when selecting with the mouse.
unbind -T copy-mode MouseDragEnd1Pane
unbind -T copy-mode-vi MouseDragEnd1Pane

# Use vim style keybindings
set -g mode-keys vi

# Add C-space as an alternative prefix.
set -g prefix2 C-space
bind-key C-space send-prefix -2

# Bind double prefix to send the prefix keys.
bind C-b send-keys C-b
bind C-space send-keys C-space

# Shortcut to clear both the scrollback buffer and the screen.
bind C-k send-keys C-u \; send-keys C-k \; send-keys C-l \; clear-history

# Use C-b b to go to the previously selected window
bind -r b last-window

# Let next and previous window bindings be repeatable.
bind -r n select-window -n
bind -r p select-window -p

# Allow navigating panes using vim's hjkl keys.
unbind-key l
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R

# Add vim-like keybindings for pane splitting, and
# make new panes start on the current path.
bind v split-window -h -c '#{pane_current_path}'
bind s split-window -v -c '#{pane_current_path}'

# Bind `C-s` to replace the default `s` binding because we remapped it.
bind C-s choose-tree -Zs
