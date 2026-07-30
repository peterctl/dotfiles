# vim:set ft=tmux:
# Custom catppuccin VRAM (GPU memory) module. catppuccin ships no module for
# this, so it mirrors its `cpu.conf`: theme-colored, load-based, calling
# tmux-cpu's `gram_*` scripts via `#(...)` so it works inside the width gates.
# The load-based color drives the ICON background (yellow normally, red under
# high load), leaving the text on the normal module surface.

%hidden MODULE_NAME="vram"

set -ogq @gram_low_bg_color    "#{E:@thm_yellow}"
set -ogq @gram_medium_bg_color "#{E:@thm_yellow}"
set -ogq @gram_high_bg_color   "#{E:@thm_red}"
set -ogq @gram_low_fg_color    "#{E:@thm_crust}"
set -ogq @gram_medium_fg_color "#{E:@thm_crust}"
set -ogq @gram_high_fg_color   "#{E:@thm_crust}"

set -ogq  "@catppuccin_${MODULE_NAME}_icon" " "
set -ogq  "@catppuccin_${MODULE_NAME}_text" "#(#{TMUX_DIR}/scripts/usage_text.sh gram)"
set -ogq  "@catppuccin_status_${MODULE_NAME}_icon_fg" "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/gram_fg_color.sh)}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_icon_bg" "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/gram_bg_color.sh)}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_text_fg" "#{E:@thm_fg}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_text_bg" "#{E:@catppuccin_status_module_text_bg}"

source -F "/home/peterctl/.tmux/plugins/tmux/utils/status_module.conf"
