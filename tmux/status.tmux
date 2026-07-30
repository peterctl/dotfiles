# Point the catppuccin cpu/ram modules at the plugin scripts via #(...) so they
# render at run time and work inside the width-conditional gates below. These
# overrides must be set before re-sourcing the modules (catppuccin uses -ogq,
# i.e. only-if-unset), so our values win. The load-based color drives the ICON
# background (yellow normally, red under high load), leaving the text on the
# normal module surface.

source-file -F "#{d:current_file}/status/catppuccin_status_cpu.tmux"
source-file -F "#{d:current_file}/status/catppuccin_status_gpu.tmux"
source-file -F "#{d:current_file}/status/catppuccin_status_ram.tmux"
source-file -F "#{d:current_file}/status/catppuccin_status_vram.tmux"

set -g status-interval 5
set -g status-right-length 100
set -g status-left "#[default]"

# Status right modules. Modules are progressively hidden as the terminal narrows
# so the right side never gets clipped:
#   - cpu + ram + gpu + vram drop when width < 160
#   - host + app drop when width < 100
#   - session is always shown
set -g  status-right "#{?#{e|>=:#{client_width},100},#{E:@catppuccin_status_application},}"
set -ag status-right "#{?#{e|>=:#{client_width},160},#{E:@catppuccin_status_cpu},}"
set -ag status-right "#{?#{e|>=:#{client_width},160},#{E:@catppuccin_status_ram},}"
set -ag status-right "#{?#{&&:#{==:#{@gpu_present},1},#{e|>=:#{client_width},160}},#{E:@catppuccin_status_gpu},}"
set -ag status-right "#{?#{&&:#{==:#{@gpu_present},1},#{e|>=:#{client_width},160}},#{E:@catppuccin_status_vram},}"
set -ag status-right "#{?#{e|>=:#{client_width},100},#{E:@catppuccin_status_host},}"
set -ag status-right "#{E:@catppuccin_status_session}"
