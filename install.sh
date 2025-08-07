#!/bin/zsh
#
# A robust script to set up the Zsh environment. It:
# 1. Installs all necessary packages and command-line tools.
# 2. Installs Oh My Zsh plugins and the Powerlevel10k theme.
# 3. Creates safe symbolic links for all dotfiles, with backups.

# Get the absolute path of the directory where the script is located.
DOTFILES_DIR=${0:a:h}

# --- Define paths for plugins and themes ---
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
# --- zoxide Installation ---
echo "-> Installing zoxide..."
# Temporarily add the destination to the PATH to silence the installer's warning.
export PATH="$HOME/.local/bin:$PATH"
# Now, run the installer.
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
# ------------------------------------------------------------------------------
# 2. Install Oh My Zsh plugins and theme
# ------------------------------------------------------------------------------
echo ""
echo "Installing Oh My Zsh theme and plugins..."

# Ensure the custom theme and plugin directories exist
echo "  -> Ensuring custom directories exist..."
mkdir -p "$THEMES_DIR"
mkdir -p "$PLUGINS_DIR"

# Install Powerlevel10k Theme
if [ ! -d "$THEMES_DIR/powerlevel10k" ]; then
  echo "  -> Cloning Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEMES_DIR/powerlevel10k"
else
  echo "  ✔ Powerlevel10k theme already installed."
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

echo ""
echo "✅ Done. Please restart your shell for all changes to take effect."
# ------------------------------------------------------------------------------
