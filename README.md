# Personal Dotfiles

Uses `stow` to manage symlinks.

**Platform Table**
|	       	| Arch Linux	| Mac OSX	|
| --------- 	| --------- 	| --------- 	|
| X		| [x]		|	    	|
| alacritty	| [x]		| [x]		|
| bash		| [x]		| [x]		|
| feh		| [x]		|   		|
| fonts		| [x]		|   		|
| homebrew	| 		| [x]		|
| i3		| [x]		|   		|
| karabiner	| 	    	| [x]		|
| neofetch	| [x]		| [x]		|
| nvim		| [x]		| [x]		|
| polybar	| [x]		|   		|
| shell		| [x]		| [x]		|
| tmux		| [x]		| [x]		|
| zsh		| [x]		| [x]		|

## Shell setup

Three stow packages provide shell configuration:

- **`shell`** -- shared exports and aliases sourced by both bash and zsh
- **`bash`** -- bash-specific prompt, completion settings, and `.bash_profile`/`.bashrc` shims
- **`zsh`** -- zsh-specific prompt (async), completion, history, and key bindings

```
stow shell bash zsh
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
- Mercurial: shows active bookmark with short node, read directly from `.hg/dirstate` and `.hg/bookmarks.current` (no Python startup)
- Zsh computes VCS info asynchronously via `zle -F`; zsh also shows dirty (`*`), staged (`+`), and untracked (`?`) indicators

## Arch Linux instructions
### Caps to ctrl & esc
1. install [`xcape`](https://archlinux.org/packages/community/x86_64/xcape)
2. Add to i3 config
```
exec setxkbmap -layout us -option ctrl:nocaps
exec_always xcape -e 'Control_L=Escape'
```

## Mac OSX instructions
### Install Homebrew
(and other utilities you'll need including `stow`)
1. Install homebrew: `/usr/bin/ruby -e "$(curl -fsSL 
   https://raw.githubusercontent.com/Homebrew/install/master/install)"`
2. `brew install stow`
3. `stow homebrew`
4. Install `brew bundle --global`


### [Optional] Latex
1. Install BasicTex `brew cask install basictex`
    * log into new terminal for changes to take place `zsh --login`
2. Update tool manager `sudo tlmgr update --self`
3. Install requisite tools
```
sudo tlmgr install textpos isodate substr titlesec
```
