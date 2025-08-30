

**Prefix:** `Ctrl` + `Space`

#### Core Commands

| Keystroke                   | Action                             |
| --------------------------- | ---------------------------------- |
| **General**                 |                                    |
| `Prefix` + `r`              | Reload tmux config                 |
| `Prefix` + `d`              | Detach from current session        |
| `Prefix` + `?`              | List all keybindings               |
| **Sessions**                |                                    |
| `Prefix` + `o`              | Open session manager (`sessionx`)  |
| `Prefix` + `s`              | Show interactive session list      |
| `Prefix` + `(` / `)`        | Switch to previous/next session    |
| `Prefix` + `$`              | Rename current session             |
| **Windows**                 | _(like browser tabs)_              |
| `Prefix` + `c`              | Create a new window                |
| `Prefix` + `,`              | Rename current window              |
| `Prefix` + `w`              | Show interactive window list       |
| `Prefix` + `&`              | Kill current window                |
| `Prefix` + `p` / `n`        | Go to previous/next window         |
| `Prefix` + `0-9`            | Go to window by number             |
| `Prefix` + `Ctrl`+`h` / `l` | Go to previous/next window         |
| **Panes**                   | _(splits within a window)_         |
| `Prefix` + &#124;              | Split Vertically (Left/Right)      |
| `Prefix` + `-`              | Split horizontally (top/bottom)    |
| `Prefix` + `h`/`j`/`k`/`l`  | Navigate panes using Vim keys      |
| `Prefix` + `H`/`J`/`K`/`L`  | Resize panes (hold `Prefix` + tap) |
| `Prefix` + `z`              | Zoom/unzoom current pane           |
| `Prefix` + `x`              | Kill current pane                  |
| `Prefix` + `{` / `}`        | Move current pane left/right       |

---

#### Plugins & Copy Mode

|Keystroke|Action|
|---|---|
|`Prefix` + `[`|Enter Copy Mode (for scrolling/copying)|
|`v`, then `y`|In Copy Mode: start selection, then yank (copy)|
|`Prefix` + `]`|Paste from tmux buffer|
|`Prefix` + `p`|Open floating terminal (`floax`)|
|`Ctrl` + `y`|Create new window with zoxide (no `Prefix`)|
|`Prefix` + `u`|Show URL list from pane (`tmux-fzf-url`)|
|`Prefix` + `Space`|Enter selection mode (`tmux-thumbs`)|

---

#### Shell Commands

_(Run these in your terminal, outside of tmux)_

|Command|Action|
|---|---|
|`tmux ls`|**List** all running tmux sessions.|
|`tmux a -t <name>`|**Attach** to a specific session.|
