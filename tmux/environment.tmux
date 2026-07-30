set-environment -gF TMUX_DIR "#{d:current_file}"

# Resolve the tmux-cpu scripts dir once (TPM path, with fallback) so the cpu/ram
# modules can call the plugin scripts directly instead of relying on tmux-cpu's
# status-right token substitution (which is incompatible with width gates).
run 'p="$(tmux show-environment -g TMUX_PLUGIN_MANAGER_PATH 2>/dev/null | cut -d= -f2)"; \
     p="${p:-$HOME/.tmux/plugins/}"; \
     tmux set-environment -g TMUX_PLUGINS "${p%/}"'

# Detect a usable GPU once (static per machine) so the gpu/vram modules can hide
# themselves on machines without one.
run 'if command -v nvidia-smi >/dev/null 2>&1 || command -v cuda-smi >/dev/null 2>&1; \
     then tmux set -g @gpu_present 1; else tmux set -g @gpu_present 0; fi'
