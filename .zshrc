# ===================================================================
# Zsh Configuration
# ===================================================================

## P10k Instant Prompt (must be first for speed)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===================================================================
# Custom Configuration Loader
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

# --- Part 1: Load Pre-requisite Configurations ---
# We load exports and configs first so frameworks can use their variables.
source_dir "exports"
source_dir "configs"

# --- Part 2: Initialize Frameworks ---
# Now load Oh My Zsh, which will correctly use the ZSH_THEME set in Part 1.
if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  source "$HOME/.oh-my-zsh/oh-my-zsh.sh"
fi

# Initialize Powerlevel10k Theme.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Part 3: Load Custom Overrides ---
# We load aliases and functions last to ensure they override any framework defaults.
source_dir "aliases"
source_dir "functions"

# Unset helper to keep the shell environment clean.
unset -f source_dir

## Optional: System Info on Login
# if [[ -o interactive ]]; then
#   touch ~/.hushlogin
#   fastfetch
# fi
