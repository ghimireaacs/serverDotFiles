#!/bin/zsh
#
# A robust script to create symbolic links for dotfiles.
# It checks for existing files/links, creates backups, and ensures
# parent directories exist before creating a symlink.

# Get the absolute path of the directory where the script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# ------------------------------------------------------------------------------
# Centralized list of files to link.
#
# Format:
#   "path/to/source/in/dotfiles"  "$HOME/path/to/destination"
# ------------------------------------------------------------------------------
typeset -A files_to_link
files_to_link=(
  "$DOTFILES_DIR/.zshrc"      "$HOME/.zshrc"
  "$DOTFILES_DIR/.p10k.zsh"    "$HOME/.p10k.zsh"
  # Add other files here. For example:
  # "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
  # "$DOTFILES_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
)

# --- Function to create a symlink with pre-checks and backups ---
create_symlink() {
  local source_path=$1
  local destination_path=$2

  # Ensure the parent directory of the destination exists
  local destination_dir
  destination_dir=$(dirname "$destination_path")
  if [[ ! -d "$destination_dir" ]]; then
    echo "  -> Creating parent directory: $destination_dir"
    mkdir -p "$destination_dir"
  fi

  # Handle existing file or link at the destination
  if [[ -e "$destination_path" || -L "$destination_path" ]]; then
    # If it's already a symlink pointing to the correct source, we're done
    if [[ -L "$destination_path" && "$(readlink "$destination_path")" == "$source_path" ]]; then
      echo "  ✔ Link already correct: $(basename "$destination_path")"
      return 0
    else
      # Otherwise, back up the existing file/link
      local backup_path="$destination_path.bak"
      echo "  -> Backing up existing file to: $backup_path"
      mv -f "$destination_path" "$backup_path"
    fi
  fi

  # Create the new symlink
  echo "  -> Linking $(basename "$destination_path")"
  ln -s "$source_path" "$destination_path"
}

# --- Main script execution ---
echo "Creating symbolic links..."

for source in "${(@k)files_to_link}"; do
  destination=${files_to_link[$source]}

  # Check if the source file actually exists before trying to link it
  if [[ -e "$source" ]]; then
    create_symlink "$source" "$destination"
  else
    echo "  ✖ Source file not found, skipping: $source"
  fi
done

echo ""
echo "✅ Dotfiles linking complete."