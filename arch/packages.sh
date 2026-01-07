#!/usr/bin/env bash
set -euo pipefail

sudo pacman -Syu --needed \
  git \
  curl \
  zsh \
  fzf \
  ripgrep \
  bat \
  eza \
  entr \
  zoxide \
  tmux
