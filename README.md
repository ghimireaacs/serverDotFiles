# My Zsh Dotfiles

> A clean, modular, and powerful Zsh configuration managed by this repository.

This setup provides a fast, beautiful, and highly functional command-line experience using Oh My Zsh, Powerlevel10k, and a suite of modern command-line tools.

## 💡 Features

- **Modular Structure:** All custom settings are neatly organized in the `~/zsh` directory (`aliases`, `functions`, `exports`, `configs`).
- **Oh My Zsh:** Utilizes the popular Zsh framework for plugin and theme management.
- **Powerlevel10k Theme:** A fast, flexible, and beautiful prompt with instant feedback.
- **Helpful Plugins:** Comes with `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `fzf` pre-configured.
- **Modern Tools:** Integrates powerful replacements for classic commands:
  - **`exa`**: A modern replacement for `ls` with icons and better defaults.
  - **`bat`**: A `cat` clone with syntax highlighting and Git integration.
  - **`ripgrep` (`rg`)**: A blazing fast recursive search tool that respects your `.gitignore`.
  - **`zoxide`**: An intelligent `cd` command that learns your habits.
  - **`fzf`**: A command-line fuzzy finder for interactive filtering (e.g., `Ctrl+R` history search).

---

## 🚀 Installation

Follow these steps to set up the configuration on a new Debian-based system (like Ubuntu).

### 1. Install `git` and `curl`

Your system needs `git` and `curl` to download the necessary files.

```bash
sudo apt update && sudo apt install git curl -y
```

### 2\. Install Oh My Zsh

Next, install the Oh My Zsh framework. The `--unattended` flag prevents it from changing your shell, as we'll do that manually.

```bash
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))" "" --unattended
```

### 3\. Clone and Run the Installer

Clone this repository and run the main `install.sh` script. This single script handles everything else:

- Installs all required tools (`exa`, `bat`, `fzf`, etc.).
- Installs the Powerlevel10k theme and Zsh plugins.
- Creates symbolic links for all configuration files.

<!-- end list -->

```bash
git clone [https://github.com/ghimireaacs/serverDotFiles.git](https://github.com/ghimireaacs/serverDotFiles.git) ~/dotfiles
cd ~/dotfiles
./install.sh
```

### 4\. Set Zsh as Default Shell

Finally, change your default login shell to Zsh. You will be prompted for your password.

```bash
chsh -s $(which zsh)
```

---

## 🎉 Post-Installation

To complete the installation, you must **log out and log back in** for the new shell to become active.

The first time you start Zsh, the **Powerlevel10k configuration wizard** will run automatically. Follow its prompts to customize the appearance of your shell. You can re-run it anytime by typing `p10k configure`.
