# serverDotFiles

Opinionated dotfiles and shell bootstrap used across my systems  
(servers and workstations).

This repository is the **single source of truth (SSOT)** for:
- Zsh configuration
- Aliases, functions, exports
- tmux configuration
- Custom helper scripts

The installer logic is intentionally simple and safe to re-run.

---

## What This Repo Does

### SSOT (authoritative state)
These directories define my actual environment:

```

zsh/ → aliases, exports, functions  
tmux/ → tmux config + TPM  
cbin/ → custom helper scripts

```

These are shared **unchanged** across:
- Debian/Ubuntu servers
- Arch Linux workstation
- Any future Linux systems

---

## Bootstrap Model

The repo uses a **two-layer bootstrap**:

```

bootstrap.sh  
├── debian/packages.sh (apt-based systems)  
├── arch/packages.sh (pacman-based systems)  
└── install.sh (OS-agnostic user setup)

````

### Responsibilities
- **packages.sh**  
  Installs system packages (OS-specific)
- **install.sh**  
  Installs Oh My Zsh, plugins, and symlinks dotfiles
- **bootstrap.sh**  
  Detects OS and runs the correct flow

---

## Installation (Recommended)

### 1. Clone the repository

```bash
git clone https://github.com/ghimireaacs/serverDotFiles.git ~/serverDotFiles
cd ~/serverDotFiles
````

### 2. Run bootstrap

```bash
./bootstrap.sh
```

This will:

- Install required system packages
    
- Install Oh My Zsh + Powerlevel10k
    
- Install Zsh plugins
    
- Symlink `zsh/`, `tmux/`, and `cbin/`
    
- Set Zsh as the default shell
    

### 3. Log out and log back in

Required for shell change to take effect.

---

## Zsh Details

- Framework: **Oh My Zsh**
    
- Theme: **Powerlevel10k**
    
- Plugins:
    
    - zsh-autosuggestions
        
    - zsh-syntax-highlighting
        
    - fzf integration
        

Powerlevel10k configuration wizard will run on first login  
(re-run anytime with `p10k configure`).

---

## tmux

tmux is fully managed by this repo.

- Config is symlinked automatically
    
- TPM (tmux plugin manager) is included
    
- Prefix: **Ctrl + Space**
    

After first launch:

```
Prefix + I
```

to install plugins.

---

## Re-running & Safety

- Scripts are **idempotent**
    
- Existing files are backed up with `.bak`
    
- Safe to re-run on existing systems
    
- No destructive actions
    

---

## What This Repo Does NOT Do

- Does not manage desktop environments
    
- Does not install GUI applications
    
- Does not manage system services
    
- Does not enforce OS-specific behavior in dotfiles
    

---

## Notes

- Installer scripts are transport mechanisms
    
- Actual configuration lives in `zsh/`, `tmux/`, `cbin/`
    
- Servers and workstations intentionally share the same shell state
    

---

## License

Personal use. Adapt as needed.
