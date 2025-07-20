# ===================================================================
# Zsh Configuration - Managed by Dotfiles
# ===================================================================

# -------------------------------------------------------------------
# Powerlevel10k Instant Prompt
# This must stay at the top to ensure fast shell startup.
# -------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------------------------------------------
# Oh My Zsh Configuration
# -------------------------------------------------------------------
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the name of the theme.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Define the plugins to load.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh.
source $ZSH/oh-my-zsh.sh

# -------------------------------------------------------------------
# Powerlevel10k Configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# -------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===================================================================
# Custom Server Dashboard
# ===================================================================

# This function gathers system information that fastfetch can't get
# on its own and displays it with a custom, themed configuration.
server_dashboard() {
  # --- Get Last Login Info ---
  # First, check if the 'last' command exists to prevent errors.
  if command -v last &> /dev/null; then
    local last_login_info
    last_login_info=$(last -n 2 | head -n 1 | awk '{print $4, $5, $6, "from", $3}')
  else
    local last_login_info="`last` command not found"
  fi

  # --- Get Pending Updates Info ---
  local updates_file="/var/lib/update-notifier/updates-available"
  local updates_count
  if [ -f "$updates_file" ]; then
    updates_count=$(grep -c '^[A-Za-z]' "$updates_file")
    if [ "$updates_count" -gt 0 ]; then
      updates_count_text="$updates_count upgradable"
    else
      updates_count_text="System is up to date"
    fi
  else
    updates_count_text="n/a"
  fi

  # --- Display the Dashboard ---
  # We use simple keys for the flags (--c-LastLogin) and construct the
  # full display string with the icon here.
  fastfetch \
    --logo-color-1 blue \
    --structure "default,LastLogin,Updates" \
    --c-LastLogin "󰦯 Last Login| $last_login_info" \
    --c-Updates "󰏔 Updates| $updates_count_text"
}

# -------------------------------------------------------------------
# Zsh Initialization Logic
#
# This block ensures that the dashboard only runs for interactive
# login shells, which resolves the Powerlevel10k "console output" warning.
# -------------------------------------------------------------------
if [[ -o interactive ]]; then
  touch ~/.hushlogin
  server_dashboard
fi
