## ZSH, Oh-My-Zsh and Powerlevel10k Installation

### Install git and zsh

`sudo apt update && sudo apt install git zsh -y`

### Install Oh My Zsh

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Clone your dotfiles repository:

`git clone https://github.com/ghimireaacs/serverDotFiles.git ~/dotfiles`

### Run your installation script:

`~/serverDotFiles/install.sh`

### Set Zsh as the default shell and log out/in.

`chsh -s $(which zsh)`
