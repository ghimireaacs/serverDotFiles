#!/bin/bash
#
# A script to completely uninstall the custom Zsh environment and all its tools.

echo "This script will completely remove your custom Zsh setup."
echo "You will be prompted for your password."
read -p "Press Enter to continue or Ctrl+C to cancel."

# --- Step 1: Change Default Shell back to Bash ---
echo ""
echo "--> Step 1 of 5: Changing default shell back to Bash..."
sudo chsh -s $(which bash) $USER

# --- Step 2: Remove Custom Dotfiles and Directories ---
echo "--> Step 2 of 5: Removing dotfiles, symlinks, and custom directories..."
rm -rf ~/.zshrc ~/.p10k.zsh ~/zsh ~/cbin ~/dotfiles ~/.cache/p10k-instant-prompt*

# --- Step 3: Uninstall Oh My Zsh ---
echo "--> Step 3 of 5: Uninstalling Oh My Zsh framework..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  # The official uninstaller is interactive, so we use the unattended flag.
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/uninstall.sh)" "" --unattended
fi

# --- Step 4: Remove User-Installed Binaries ---
echo "--> Step 4 of 5: Removing locally installed binaries (zoxide)..."
rm -rf ~/.local/bin/zoxide ~/.local/share/man/man1/zoxide.1

# --- Step 5: Uninstall All System Packages ---
echo "--> Step 5 of 5: Uninstalling all related packages (zsh, fzf, bat, etc.)..."
sudo apt-get remove --purge -y zsh fzf ripgrep bat eza entr
sudo apt-get autoremove -y

echo ""
echo "✅ Uninstall complete."
echo "Please log out and log back in for all changes to take effect."
