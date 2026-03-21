#!/usr/bin/env bash
set -euo pipefail

sudo apt update

sudo apt install -y \
  git \
  curl \
  zsh \
  fzf \
  ripgrep \
  bat \
  entr \
  tmux

# On Ubuntu, bat installs as 'batcat' to avoid conflict with another 'bat' package.
# Symlink it to ~/.local/bin/bat so aliases and scripts work uniformly.
mkdir -p "$HOME/.local/bin"
if [[ ! -e "$HOME/.local/bin/bat" ]]; then
  ln -s /usr/bin/batcat "$HOME/.local/bin/bat"
fi

# Ubuntu's apt zoxide package is outdated. Install from the official upstream installer.
# Installs the latest version to ~/.local/bin/zoxide.
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
