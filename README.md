
# My Zsh Dotfiles

> A clean, modular, and powerful Zsh configuration managed by this repository.

This setup provides a fast, beautiful, and highly functional command-line experience using Oh My Zsh, Powerlevel10k, and a suite of modern command-line tools.

## 💡 Features

  * **Modular Structure:** All custom settings are neatly organized in the `~/zsh` directory (`aliases`, `functions`, `exports`).
  * **Oh My Zsh:** Utilizes the popular Zsh framework for plugin and theme management.
  * **Powerlevel10k Theme:** A fast, flexible, and beautiful prompt with instant feedback.
  * **Helpful Plugins:** Comes with `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `fzf` pre-configured.
  * **Modern Tools:** Integrates powerful replacements for classic commands:
      * **`eza`**: A modern replacement for `ls` with icons and better defaults.
      * **`bat`**: A `cat` clone with syntax highlighting and Git integration.
      * **`ripgrep` (`rg`)**: A blazing fast recursive search tool that respects your `.gitignore`.
      * **`zoxide`**: An intelligent `cd` command that learns your habits.
      * **`fzf`**: A command-line fuzzy finder for interactive filtering (e.g., `Ctrl+R` history search).

-----

## 🚀 Installation

Follow these steps to set up the configuration on a new Debian-based system (like Ubuntu).

### 1\. Install Zsh

First, ensure Zsh is installed on your system.

```bash
sudo apt update && sudo apt install zsh -y
```

### 2\. Clone the Repository

Clone this repository into a `dotfiles` directory in your home folder.

```bash
git clone https://github.com/ghimireaacs/serverDotFiles.git ~/dotfiles
```

### 3\. Run the Installer

Run the main `install.sh` script from within the new directory. This single script handles everything else:

  * Installs all other required system packages and tools (`eza`, `bat`, `fzf`, etc.).
  * Installs the Oh My Zsh framework, Powerlevel10k theme, and Zsh plugins.
  * Creates symbolic links for all your configuration files.
  * Sets Zsh as your default shell.

<!-- end list -->

```bash
cd ~/dotfiles
./install.sh
```

-----

## 🎉 Post-Installation

To complete the installation, you must **log out and log back in** for the new shell to become active.

The first time you start Zsh, the **Powerlevel10k configuration wizard** will run automatically. Follow its prompts to customize the appearance of your shell. You can re-run it anytime by typing `p10k configure`.
