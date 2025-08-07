# ===================================================================
# Zsh Configuration
# ===================================================================

## P10k Instant Prompt (must be first for speed)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===================================================================
# Initialize Frameworks
# Frameworks are loaded first to set up all the defaults.
# ===================================================================

## Oh My Zsh - Sourced before custom files so we can override its settings.
# Note: OMZ settings are now defined in ~/zsh/configs/oh-my-zsh.zsh
#
# FIX: Check if Oh My Zsh exists before trying to source it.
# This prevents errors on a fresh installation.
if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  source "$HOME/.oh-my-zsh/oh-my-zsh.sh"
fi

## Powerlevel10k Theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===================================================================
# Load Custom Configuration Files
# Loaded LAST to ensure they override any framework defaults.
# ===================================================================

# Helper to source all files from a directory.
source_dir() {
  local dir_path="$HOME/zsh/$1"
  if [ -d "$dir_path" ]; then
    for file in "$dir_path"/*(N); do
      source "$file"
    done
  fi
}

# Load configs in order: exports -> configs -> aliases -> functions
source_dir "exports"
source_dir "configs"
source_dir "aliases"
source_dir "functions"

# Unset helper to keep the shell environment clean.
unset -f source_dir

## Optional: System Info on Login
# if [[ -o interactive ]]; then
#   touch ~/.hushlogin
#   fastfetch
# fi
