# ===================================================================
# Zsh Configuration
# ===================================================================

## P10k Instant Prompt (must be first for speed)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===================================================================
# Framework Configuration & Initialization
# ===================================================================

# --- Oh My Zsh Settings (defined directly here) ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# --- Load Oh My Zsh ---
# It will use the variables defined just above.
if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  source "$HOME/.oh-my-zsh/oh-my-zsh.sh"
fi

# --- Initialize Zoxide ---
# This must come after Oh My Zsh to ensure it's loaded correctly.
eval "$(zoxide init zsh)"

# --- Load Powerlevel10k ---
# This must come after Oh My Zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===================================================================
# Load Custom Aliases & Functions
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

# --- Load Custom Files ---
# These are loaded LAST to ensure they override any framework defaults.
source_dir "exports"
source_dir "aliases"
source_dir "functions"

# Unset helper to keep the shell environment clean.
unset -f source_dir


export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export EDITOR='/opt/nvim-linux-x86_64/bin/nvim'
export KUBECONFIG=/home/ghost/.kube/config


## TESTING TITLE

if [ -n "$SSH_CONNECTION" ]; then
    # Disable Oh-My-Zsh auto title
    DISABLE_AUTO_TITLE="true"
    
    # Set title to hostname
    echo -ne "\033]0;SSH: $(hostname)\007"
    
    # Keep title on every prompt
    precmd() {
        echo -ne "\033]0;SSH: $(hostname)\007"
    }
fi
