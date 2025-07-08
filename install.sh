#!/bin/zsh
# This script creates symlinks from the home directory to the files in this repo.

# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Creating symlinks..."

# Create symlinks for config files
ln -sfv "$DIR/.zshrc" ~/.zshrc
ln -sfv "$DIR/.p10k.zsh" ~/.p10k.zsh

# Ensure the .oh-my-zsh/custom directory exists
mkdir -p ~/.oh-my-zsh/custom

# Symlink the custom themes and plugins
ln -sfv "$DIR/oh-my-zsh-custom/themes" ~/.oh-my-zsh/custom/themes
ln -sfv "$DIR/oh-my-zsh-custom/plugins" ~/.oh-my-zsh/custom/plugins

# Optional: Make your scripts available in your path
mkdir -p ~/bin
ln -sfv "$DIR/scripts/dockstat" ~/bin/dockstat

echo "Done. Please restart your shell or run 'source ~/.zshrc'."