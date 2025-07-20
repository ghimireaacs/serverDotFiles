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
# Display Server Info on Login
# ===================================================================
# This block runs fastfetch for interactive shells, which prevents
# the Powerlevel10k "console output" warning.
if [[ -o interactive ]]; then
  touch ~/.hushlogin
  fastfetch
fi
