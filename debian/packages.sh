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

# Ubuntu often has old eza/zoxide
# optional: install from upstream or skip
