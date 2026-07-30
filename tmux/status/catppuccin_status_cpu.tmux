# vim:set ft=tmux:
# Override catppuccin CPU-usage module. Theme-colored, load-based, calling
# tmux-cpu's `cpu_*` scripts via `#(...)` so it works inside the width gates.
# The load-based color drives the ICON background (yellow normally, red under
# high load), leaving the text on the normal module surface.

%hidden MODULE_NAME="gpu"

set -g @cpu_low_bg_color    "#{E:@thm_yellow}"
set -g @cpu_medium_bg_color "#{E:@thm_yellow}"
set -g @cpu_high_bg_color   "#{E:@thm_red}"
set -g @cpu_low_fg_color    "#{E:@thm_crust}"
set -g @cpu_medium_fg_color "#{E:@thm_crust}"
set -g @cpu_high_fg_color   "#{E:@thm_crust}"

set -g @catppuccin_cpu_text "#{E:#(#{TMUX_DIR}/scripts/usage_text.sh cpu)}"
set -g @catppuccin_status_cpu_icon_fg "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/cpu_fg_color.sh)}"
set -g @catppuccin_status_cpu_icon_bg "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/cpu_bg_color.sh)}"
set -g @catppuccin_status_cpu_text_fg "#{E:@thm_fg}"
set -g @catppuccin_status_cpu_text_bg "#{E:@catppuccin_status_module_text_bg}"

source-file -F "#{TMUX_PLUGINS}/tmux/status/cpu.conf"
