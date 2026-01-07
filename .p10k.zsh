# Powerlevel10k profile selector
# Chooses prompt profile based on execution context

P10K_DIR="$HOME/zsh/p10k"

is_server=false

# SSH session
[[ -n "$SSH_CONNECTION" ]] && is_server=true

# WSL detection
grep -qi microsoft /proc/version 2>/dev/null && is_server=true

# No graphical session
[[ -z "$WAYLAND_DISPLAY" && -z "$DISPLAY" ]] && is_server=true

if $is_server; then
  source "$P10K_DIR/server.zsh"
elif [[ -f "$P10K_DIR/workstation.zsh" ]]; then
  source "$P10K_DIR/workstation.zsh"
else
  source "$P10K_DIR/server.zsh"
fi
