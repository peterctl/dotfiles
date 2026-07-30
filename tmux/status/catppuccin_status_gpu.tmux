# vim:set ft=tmux:
# Custom catppuccin GPU-usage module. catppuccin ships no gpu.conf, so this
# mirrors its `cpu.conf`: theme-colored, load-based, calling tmux-cpu's `gpu_*`
# scripts via `#(...)` so it works inside the width gates. The load-based color
# drives the ICON background (yellow normally, red under high load), leaving the
# text on the normal module surface.

%hidden MODULE_NAME="gpu"

set -ogq @gpu_low_bg_color    "#{E:@thm_yellow}"
set -ogq @gpu_medium_bg_color "#{E:@thm_yellow}"
set -ogq @gpu_high_bg_color   "#{E:@thm_red}"
set -ogq @gpu_low_fg_color    "#{E:@thm_crust}"
set -ogq @gpu_medium_fg_color "#{E:@thm_crust}"
set -ogq @gpu_high_fg_color   "#{E:@thm_crust}"

set -ogq  "@catppuccin_${MODULE_NAME}_icon" "󰢮 "
set -ogq  "@catppuccin_${MODULE_NAME}_text" "#{E:#(#{TMUX_DIR}/scripts/usage_text.sh gpu)}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_icon_fg" "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/gpu_fg_color.sh)}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_icon_bg" "#{E:#(#{TMUX_PLUGINS}/tmux-cpu/scripts/gpu_bg_color.sh)}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_text_fg" "#{E:@thm_fg}"
set -ogq  "@catppuccin_status_${MODULE_NAME}_text_bg" "#{E:@catppuccin_status_module_text_bg}"

source -F "#{TMUX_PLUGINS}/tmux/utils/status_module.conf"
