Installation Steps

1. Install Prerequisites
   First, update your package list and install the necessary tools: git, curl, and zsh.

`sudo apt update && sudo apt install git curl util-linux zsh -y`

2. Install Oh My Zsh
   Next, install the Oh My Zsh framework. We use the --unattended flag to prevent it from automatically changing the shell, as we will handle that and the configuration manually.

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended`

3. Clone This Dotfiles Repository
   Clone this repository into a dotfiles directory in your home folder.

`git clone https://github.com/ghimireaacs/serverDotFiles.git ~/dotfiles`

4. Run the Installation Script
   Run the custom installation script from within the repository. This script will:

Download the required Zsh plugins (zsh-autosuggestions, zsh-syntax-highlighting).

Download the Powerlevel10k theme.

Safely create symbolic links for .zshrc and .p10k.zsh, backing up any existing files.

`~/dotfiles/install.sh`

5. Set Zsh as Default Shell
   Finally, change your default login shell to Zsh. You will be prompted for your password to authorize this change.

`chsh -s $(which zsh)`

6. Log Out and Restart
   To complete the installation, you must log out and log back in for the new shell to become active.
