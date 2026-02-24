# Personal Dotfiles

Modular dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level directory is a stow package whose contents mirror `$HOME`.

## Design principles

- **XDG Base Directory Specification** -- all config lives under `~/.config`,
  data under `~/.local/share`, cache under `~/.cache`, and scripts under
  `~/.local/bin`. Zsh's `ZDOTDIR` is redirected to `$XDG_CONFIG_HOME/zsh`
  so `$HOME` stays clean.
- **Composable** -- `conf.d` drop-in directories let a separate stow repo
  layer on machine-specific or work-specific config without touching this repo.
- **`--no-folding`** -- stow is configured (via `stow/.stowrc`) to never
  replace a real directory with a symlink, so multiple stow repos can coexist
  in the same target directories.

## Quickstart

```bash
git clone <repo> ~/.dotfiles
cd ~/.dotfiles

# 1. Install stow's own config first (provides --no-folding)
stow stow

# 2. Shell
stow shell bash zsh

# 3. Editors, terminal, tmux
stow nvim vim tmux alacritty

# 4. Everything else (pick what applies to your platform)
stow bin fonts npm
```

## Platform table

|            | Arch Linux | macOS |
| ---------- | ---------- | ----- |
| alacritty  | x          | x     |
| bash       | x          | x     |
| bin        | x          | x     |
| feh        | x          |       |
| fonts      | x          |       |
| gtk        | x          |       |
| homebrew   |            | x     |
| i3         | x          |       |
| karabiner  |            | x     |
| kmonad     | x          |       |
| neofetch   | x          | x     |
| npm        | x          | x     |
| nvim       | x          | x     |
| polybar    | x          |       |
| shell      | x          | x     |
| stow       | x          | x     |
| system     | x          |       |
| systemd    | x          |       |
| tmux       | x          | x     |
| vim        | x          | x     |
| zsh        | x          | x     |

## Shell setup

Three stow packages provide shell configuration:

- **`shell`** -- shared exports and aliases sourced by both bash and zsh
- **`bash`** -- bash-specific prompt, completion settings, and `.bash_profile`/`.bashrc` shims
- **`zsh`** -- zsh-specific prompt (async), completion, history, and key bindings

```
stow shell bash zsh
```

### Shell loading order

**Zsh:**
```
~/.zshenv                          sets XDG vars, ZDOTDIR
  -> ~/.config/zsh/.zshrc
       -> sources ~/.config/shell/exports   (shared)
       -> sources ~/.config/shell/aliases   (shared)
       -> sources ~/.config/shell/vcs       (shared hg helper)
       -> sources ~/.config/zsh/conf.d/*.zsh (extensions)
```

**Bash:**
```
~/.bash_profile                    sources ~/.bashrc
  -> ~/.bashrc                     sets XDG vars
       -> ~/.config/bash/bashrc
            -> sources ~/.config/shell/exports
            -> sources ~/.config/shell/aliases
            -> sources ~/.config/shell/vcs
            -> sources ~/.config/bash/conf.d/*.bash (extensions)
```

### Prompt

Both shells use the same two-line prompt style:

```
user@hostname in directory on branch
❯
```

- `user@hostname` bold yellow, `directory` bold cyan, `branch` bold magenta
- `❯` bold green (exit 0) or bold red (non-zero)
- Directory is trimmed to the repo root inside git/hg repositories
- Git: shows branch name, or `HEAD (sha)` when detached
- Mercurial: shows active bookmark with short node, read directly from
  `.hg/dirstate` and `.hg/bookmarks.current` (no Python startup)
- Zsh computes VCS info asynchronously via `zle -F`; zsh also shows
  dirty (`*`), staged (`+`), and untracked (`?`) indicators

## Neovim

Lua-based configuration using [lazy.nvim](https://github.com/folke/lazy.nvim)
as the plugin manager. Leader is `<Space>`.

Structure:

```
nvim/.config/nvim/
├── init.lua              # leader, core requires, lazy.nvim bootstrap
├── lua/config/
│   ├── options.lua       # vim.opt settings
│   ├── keymaps.lua       # global key mappings
│   └── autocmds.lua      # autocommands
├── lua/plugins/          # lazy.nvim plugin specs
│   ├── lsp.lua           # language server setup
│   ├── cmp.lua           # completion (nvim-cmp)
│   ├── telescope.lua     # fuzzy finder
│   ├── treesitter.lua    # syntax highlighting
│   ├── colorscheme.lua   # ayu theme (dark/mirage/light)
│   ├── editor.lua        # general editor plugins
│   ├── writing.lua       # prose/markdown tools
│   └── kmonad.lua        # kmonad filetype support
├── ftdetect/             # custom filetype detection
└── ftplugin/             # per-filetype settings
```

Key mappings:

| Mapping           | Action                                |
|-------------------|---------------------------------------|
| `<leader>i`       | Edit init.lua                         |
| `<leader><CR>`    | Source init.lua                        |
| `<leader>eh`      | Edit file relative to current buffer  |
| `<leader>cd`      | `:cd` to current file's directory     |
| `<leader>sp`      | Enable spell checking                 |
| `<leader>csd/m/l` | Switch colorscheme (dark/mirage/light)|

Arrow keys are disabled in normal mode.

## Tmux

Vi-style keybindings for pane navigation (`h/j/k/l`) and splitting (`v`/`s`).
Mouse and system clipboard support via `xclip`. Status bar shows session name,
user, host, and time. Windows and panes are numbered from 1.

Key bindings:

| Binding      | Action                            |
|--------------|-----------------------------------|
| `prefix a`   | Fuzzy-search windows (via `fzf`)  |
| `prefix v`   | Split horizontal                  |
| `prefix s`   | Split vertical                    |
| `prefix R`   | Reload config                     |

## sshmux

`sshmux` manages tmux sessions backed by remote SSH hosts. It uses
[Eternal Terminal](https://eternalterminal.dev/) (`et`) for resilient primary
connections and SSH ControlMaster multiplexing for fast additional pane
connections.

### Commands

| Command                   | Description                                              |
|---------------------------|----------------------------------------------------------|
| `sshmux connect [host]`   | Connect to a host (interactive `fzf` picker if omitted)  |
| `sshmux list`             | List sessions with ControlMaster status                  |
| `sshmux release [--all]`  | Close ControlMaster socket and kill tmux session          |
| `sshmux clean`            | Remove stale sessions with dead connections               |
| `sshmux help`             | Show help including recommended tmux keybindings          |

### How it works

1. `sshmux connect` establishes an SSH ControlMaster socket, creates a tmux
   session whose first window runs `et <host>`, and stores the host in the
   tmux session environment variable `SSHMUX_HOST`.
2. `sshmux-ssh` is a pane helper: it reads `SSHMUX_HOST` from the current
   session, then connects via the ControlMaster socket (fast) or falls back
   to `et`.
3. With the tmux keybindings below, new windows and splits in an sshmux
   session automatically connect to the same remote host.

### Recommended tmux keybindings

Add to `tmux.conf` (or a `conf.d` drop-in) to auto-connect new panes:

```tmux
bind c if-shell 'tmux show-env SSHMUX_HOST 2>/dev/null | grep -qv "^-"' \
    'new-window "$HOME/.local/bin/sshmux-ssh"' \
    'new-window'
bind v if-shell 'tmux show-env SSHMUX_HOST 2>/dev/null | grep -qv "^-"' \
    'split-window -h "$HOME/.local/bin/sshmux-ssh"' \
    'split-window -h'
bind s if-shell 'tmux show-env SSHMUX_HOST 2>/dev/null | grep -qv "^-"' \
    'split-window -v "$HOME/.local/bin/sshmux-ssh"' \
    'split-window -v'
```

### Dependencies

`et`, `tmux`, `fzf`, `ssh`

## Vim

Minimal XDG-compliant Vim configuration. `~/.vimrc` is a shim that sources
`$XDG_CONFIG_HOME/vim/vimrc`, which in turn loads any `conf.d/*.vim` drop-ins.
Leader is `<Space>`. Paste mode is auto-disabled on `InsertLeave`.

## Other packages

| Package    | Description |
|------------|-------------|
| `bin`      | User scripts in `~/.local/bin`: `sshmux` / `sshmux-ssh` (tmux session manager for SSH hosts), `chscheme` (color scheme switcher), `cht.sh` (cheat sheet client) |
| `fonts`    | Nerd Fonts (Hack, Roboto Mono) for terminal and editor icon support |
| `kmonad`   | [KMonad](https://github.com/kmonad/kmonad) keyboard remapping config (Caps Lock as Ctrl/Esc) |
| `systemd`  | User-level systemd service for kmonad |
| `system`   | Udev rules for kmonad (`uinput`) and ZSA keyboard flashing (`wally`). **Not stowable** -- must be copied manually to `/etc/udev/rules.d/` |
| `karabiner`| [Karabiner-Elements](https://karabiner-elements.pqrs.org/) config using [Goku](https://github.com/yqrashawn/GokuRakuJoudo) DSL (macOS key remapping) |
| `npm`      | XDG-compliant npm config (redirects cache and tmp) |
| `gtk`      | GTK 3 theme settings (Arc-Dark) |
| `i3`       | i3 window manager config with i3blocks |
| `polybar`  | Polybar status bar with weather script |
| `feh`      | Feh image viewer key/button bindings |
| `alacritty`| Alacritty terminal emulator config |
| `neofetch` | System info display config |
| `homebrew` | Global Brewfile for macOS package management |

## Local / work-specific extensions

This repo is intentionally generic. Machine-specific or work-specific
configuration lives in a **separate stow repo** (e.g. `~/.dotfiles-work`) and
is loaded automatically through `conf.d` directories and conditional includes.

### How it works

| Tool | Extension point | Pattern |
|------|----------------|---------|
| zsh  | `$XDG_CONFIG_HOME/zsh/conf.d/*.zsh` | Glob with `(N)` -- no error if empty |
| bash | `$XDG_CONFIG_HOME/bash/conf.d/*.bash` | Guarded `[ -f ]` loop |
| tmux | `$XDG_CONFIG_HOME/tmux/conf.d/*.conf` | `source-file -q` glob -- silent if empty |
| vim  | `$XDG_CONFIG_HOME/vim/conf.d/*.vim` | `glob()` + `source` loop |
| nvim | `$XDG_CONFIG_HOME/nvim/after/` | Built-in `after/` auto-load (ftdetect, ftplugin, plugin) |
| nvim | `$XDG_CONFIG_HOME/nvim/lua/plugins/*.lua` | lazy.nvim loads all modules in `lua/plugins/` |
| git  | `~/.gitconfig-work` (or any path) | `[include] path = ...` -- no-op if missing |
| PATH | `$HOME/.local/bin` | Binaries from any stow repo land here |

### Setting up a work stow repo

```bash
mkdir -p ~/.dotfiles-work
cd ~/.dotfiles-work
git init

# Example: add a zsh extension
mkdir -p zsh/.config/zsh/conf.d
cat > zsh/.config/zsh/conf.d/work.zsh <<'SH'
# work-specific shell config
SH

# Example: add a git include
mkdir -p git
cat > git/.gitconfig-work <<'INI'
[user]
    email = you@work.com
INI

# Stow everything into ~
stow -t ~ zsh git
```

Each stow package mirrors the XDG directory structure so that `stow -t ~`
places files exactly where the shell/tool expects them. The personal repo
`.gitignore` already excludes the `conf.d` directories and `nvim/after`, so
stowed symlinks from a work repo won't show up as untracked files here.

### Stow `--no-folding`

The `stow` package provides a `~/.stowrc` containing `--no-folding`. This
prevents stow from replacing real directories with a single directory symlink
("tree folding"), which would block a second stow repo from adding symlinks
into the same directory. Stow the `stow` package first when bootstrapping a
new machine so all subsequent operations pick up this setting.

## Dependencies

External tools used by each package:

| Package  | Dependencies |
|----------|-------------|
| shell    | [`fzf`](https://github.com/junegunn/fzf), [`fd`](https://github.com/sharkdp/fd) (for `FZF_DEFAULT_COMMAND`) |
| nvim     | A [Nerd Font](https://www.nerdfonts.com/) (for nvim-web-devicons), `git` (for lazy.nvim bootstrap) |
| tmux     | [`fzf`](https://github.com/junegunn/fzf), `xclip` (for clipboard on Linux) |
| bin      | [`et`](https://eternalterminal.dev/) (for `sshmux`), [`fzf`](https://github.com/junegunn/fzf) (for `sshmux`), `ssh` (for `sshmux` ControlMaster) |
| kmonad   | [`kmonad`](https://github.com/kmonad/kmonad) binary, `uinput` kernel module |
| i3       | `i3blocks`, `xbacklight` |
| polybar  | `curl` (for weather script) |

## macOS instructions

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install stow
cd ~/.dotfiles
stow homebrew
brew bundle --global
```

### Caps to Ctrl/Esc (macOS)

Install Karabiner-Elements and Goku, then stow the `karabiner` package.

## Arch Linux instructions

### Caps to Ctrl/Esc

**Option A: xcape (X11)**

```bash
pacman -S xcape
# Add to i3 config:
# exec setxkbmap -layout us -option ctrl:nocaps
# exec_always xcape -e 'Control_L=Escape'
```

**Option B: KMonad**

```bash
stow kmonad systemd
# Copy udev rules
sudo cp system/40-input.rules /etc/udev/rules.d/
sudo groupadd uinput
sudo usermod -aG input,uinput $(whoami)
sudo udevadm control --reload-rules
# Enable the service
systemctl --user enable --now kmonad.service
```
