#!/bin/zsh
#
# A robust script to set up the Zsh environment. It:
# 1. Installs all necessary packages and command-line tools.
# 2. Installs the Oh My Zsh framework, plugins, and Powerlevel10k theme.
# 3. Creates safe symbolic links for all dotfiles, with backups.
# 4. Sets Zsh as the default shell.

# Get the absolute path of the directory where the script is located.
DOTFILES_DIR=${0:a:h}

# --- Define paths ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
THEMES_DIR="$ZSH_CUSTOM/themes"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

# ------------------------------------------------------------------------------
# 1. Install Prerequisites & Command-Line Tools
# ------------------------------------------------------------------------------
echo ""
echo "Installing prerequisites and command-line tools..."

# Update package list and install dependencies from apt
sudo apt update && sudo apt install -y \
  git \
  curl \
  zsh \
  fzf \
  ripgrep \
  bat \
  eza \
  entr

# Install zoxide using its official script for the latest version
echo "-> Installing zoxide..."
export PATH="$HOME/.local/bin:$PATH" # Temporarily add to PATH to silence warning
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# ------------------------------------------------------------------------------
# 2. Install Oh My Zsh and Plugins/Theme
# ------------------------------------------------------------------------------
echo ""
echo "Installing Oh My Zsh..."

# Install Oh My Zsh Framework
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  -> Oh My Zsh not found. Installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "  ✔ Oh My Zsh is already installed."
fi

echo "Installing Oh My Zsh theme and plugins..."
mkdir -p "$THEMES_DIR" "$PLUGINS_DIR" # Ensure custom directories exist

# --- FIXED: Install Powerlevel10k Theme ---
P10K_DIR="$THEMES_DIR/powerlevel10k"
if [ -d "$P10K_DIR" ] && [ -n "$(ls -A $P10K_DIR)" ]; then
  echo "  ✔ Powerlevel10k theme already installed and not empty."
else
  echo "  -> Cloning Powerlevel10k theme..."
  # Remove potentially empty directory before cloning
  rm -rf "$P10K_DIR"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  if [ $? -ne 0 ]; then
    echo "  ✖ Failed to clone Powerlevel10k. Please check your internet connection and git installation." >&2
    exit 1
  fi
fi

# Install zsh-autosuggestions Plugin
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "  -> Cloning zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
else
  echo "  ✔ zsh-autosuggestions plugin already installed."
fi

# Install zsh-syntax-highlighting Plugin
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "  -> Cloning zsh-syntax-highlighting plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
else
  echo "  ✔ zsh-syntax-highlighting plugin already installed."
fi

# ------------------------------------------------------------------------------
# 3. Create symbolic links for configuration files
# ------------------------------------------------------------------------------
typeset -A items_to_link
items_to_link=(
  "$DOTFILES_DIR/.zshrc"      "$HOME/.zshrc"
  "$DOTFILES_DIR/.p10k.zsh"   "$HOME/.p10k.zsh"
  "$DOTFILES_DIR/zsh"        "$HOME/zsh"
  "$DOTFILES_DIR/cbin"       "$HOME/cbin"
)

# --- Function to create a symlink with pre-checks and backups ---
create_symlink() {
  local source_path=$1
  local destination_path=$2
  local destination_dir=$(dirname "$destination_path")
  if [[ ! -d "$destination_dir" ]]; then
    echo "  -> Creating parent directory: $destination_dir"
    mkdir -p "$destination_dir"
  fi
  if [[ -e "$destination_path" || -L "$destination_path" ]]; then
    if [[ -L "$destination_path" && "$(readlink "$destination_path")" == "$source_path" ]]; then
      echo "  ✔ Link already correct: $(basename "$destination_path")"
      return 0
    else
      local backup_path="$destination_path.bak"
      echo "  -> Backing up existing item to: $backup_path"
      mv -f "$destination_path" "$backup_path"
    fi
  fi
  echo "  -> Linking $(basename "$destination_path")"
  ln -s "$source_path" "$destination_path"
}

# --- Main script execution for symlinking ---
echo ""
echo "Creating symbolic links for config files..."

for source in "${(@k)items_to_link}"; do
  destination=${items_to_link[$source]}
  if [[ -e "$source" || -L "$source" ]]; then
    create_symlink "$source" "$destination"
  else
    echo "  ✖ Source not found, skipping: $source"
  fi
done

# ------------------------------------------------------------------------------
# 4. Set Zsh as the default shell
# ------------------------------------------------------------------------------
if [[ "$SHELL" != *"/zsh"* ]]; then
  echo ""
  echo "Setting Zsh as the default shell. You may be prompted for your password."
  sudo chsh -s $(which zsh) $USER
else
  echo ""
  echo "Zsh is already the default shell."
fi

echo ""
echo "✅ Done. Please log out and log back in for all changes to take effect."
# ------------------------------------------------------------------------------
