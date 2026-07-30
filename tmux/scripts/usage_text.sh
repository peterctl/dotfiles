#!/usr/bin/env bash
#
# Emit a catppuccin-styled usage percentage for a tmux-cpu metric, adding a
# bold + red text cue when the metric is in its "high" load band.
#
# Usage: usage_text.sh <metric>
#   <metric> is a tmux-cpu prefix: cpu | ram | gpu | gram
#
# The metric's percentage and high threshold come from tmux-cpu's own scripts
# and options (@<metric>_high_thresh, default 80). Colors come from the active
# catppuccin theme (@thm_red / @thm_fg), so this follows flavor changes.
#
# Output is a tmux format fragment: "#[fg=<hex>]#[bold] NN.N%#[nobold]" on high
# load, or " NN.N%" otherwise. The caller places it as a module's text.

set -euo pipefail

metric="${1:?usage: usage_text.sh <cpu|ram|gpu|gram>}"

# Resolve the tmux-cpu scripts dir the same way the tmux config does.
plugins="$(tmux show-environment -g TMUX_PLUGINS 2>/dev/null | cut -d= -f2)"
plugins="${plugins:-$HOME/.tmux/plugins}"
plugins="${plugins%/}"
scripts="${plugins}/tmux-cpu/scripts"

pct="$("${scripts}/${metric}_percentage.sh")"  # e.g. "27.3%" (or "No GPU")
num="${pct%\%}"  # strip trailing %

# Non-numeric (e.g. "No GPU") -> just pass the text through unstyled.
case "$num" in
  ''|*[!0-9.]*) printf ' %s' "$pct"; exit 0 ;;
esac

thresh="$(tmux show-option -gqv "@${metric}_high_thresh")"
thresh="${thresh:-80}"

if awk "BEGIN{exit !(${num} >= ${thresh})}"; then
  red="$(tmux display-message -p '#{E:@thm_red}')"
  printf '#[fg=%s]#[bold] %s#[nobold]' "$red" "$pct"
else
  printf ' %s' "$pct"
fi
