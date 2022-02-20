# -------------------------
#           _
#          | |
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__
#  /___|___/_| |_|_|  \___|
# -------------------------

# -----------------------------------------------------------------------------
# FB
# -----------------------------------------------------------------------------
fb_config="$HOME/.config/zsh/fb.zsh"
[[ -f "$fb_config" ]] && source "$fb_config"

# -----------------------------------------------------------------------------
# Antigen
# -----------------------------------------------------------------------------
source "$HOME/.local/share/zsh/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle vi-mode

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load sindresorhus pure prompt
antigen bundle sindresorhus/pure@main

# Tell Antigen that you're done.
antigen apply

# -----------------------------------------------------------------------------
# ENV variables
# -----------------------------------------------------------------------------
export BROWSER="$([ -n "$DISPLAY" ] && echo 'firefox' || echo 'links')"
export EDITOR="$([ -n $DISPLAY ] && echo 'nvim' || echo 'vi')"
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=130000
export SAVEHIST=130000
export TERM=xterm-256color
export TMPDIR="/var/tmp"
export VISUAL=nvim
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude __generated__'

# my binaries
export PATH="$PATH:$HOME/.local/bin"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

NPM_PACKAGES="$XDG_DATA_HOME/npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# pip
export PYTHONUSERBASE="$XDG_DATA_HOME/pip-packages"
export PATH="$PATH:$PYTHONUSERBASE/bin"

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------
alias vim=nvim

# -----------------------------------------------------------------------------
# Completion opts
# -----------------------------------------------------------------------------
# Remove . & .. from completions
zstyle ':completion:*' special-dirs false

# -----------------------------------------------------------------------------
# Mac OSX path
# -----------------------------------------------------------------------------
# TODO: define better MacOSX check
cellar="/usr/local/Cellar"
if [ -e "$cellar" ]
then
    export PATH=/usr/local/{bin,sbin}:$HOME/.local/bin:$PATH
    export PATH=$HOME/bin:$PATH
    export PATH="$cellar/python@3.8/3.8.5/Frameworks/Python.framework/Versions/3.8/bin:$PATH"

    export GOKU_EDN_CONFIG_FILE="$XDG_CONFIG_HOME/karabiner/karabiner.edn"
fi
