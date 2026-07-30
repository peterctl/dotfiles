# vim:set ft=tmux:
# Override catppuccin RAM module. theme-colored, load-based, calling
# tmux-cpu's `ram_*` scripts via `#(...)` so it works inside the width gates.
# The load-based color drives the icon background (yellow normally, red under
# high load), leaving the text on the normal module surface.

set -g @ram_low_bg_color    "#{E:@thm_yellow}"
set -g @ram_medium_bg_color "#{E:@thm_yellow}"
set -g @ram_high_bg_color   "#{E:@thm_red}"
set -g @ram_low_fg_color    "#{E:@thm_crust}"
set -g @ram_medium_fg_color "#{E:@thm_crust}"
set -g @ram_high_fg_color   "#{E:@thm_crust}"

set -g @catppuccin_ram_text "#{E:#(#{TMUX_DIR}/scripts/usage_text.sh ram)}"
set -g @catppuccin_status_ram_icon_fg "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/ram_fg_color.sh)}"
set -g @catppuccin_status_ram_icon_bg "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/ram_bg_color.sh)}"
set -g @catppuccin_status_ram_text_fg "#{E:@thm_fg}"
set -g @catppuccin_status_ram_text_bg "#{E:@catppuccin_status_module_text_bg}"

source-file -F "#{TMUX_PLUGINS}/tmux/status/ram.conf"

