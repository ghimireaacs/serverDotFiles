# ===================================================================
# Zsh Configuration
# ===================================================================

## P10k Instant Prompt (must be first for speed)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===================================================================
# Load Custom Configuration Files & Initialize Frameworks
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

# Load custom configs in order. OMZ settings must be loaded before OMZ itself.
source_dir "exports"
source_dir "configs"
source_dir "aliases"
source_dir "functions"

# Unset helper to keep the shell environment clean.
unset -f source_dir

# Initialize Oh My Zsh (uses settings loaded above).
source $ZSH/oh-my-zsh.sh

# Initialize Powerlevel10k Theme.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

