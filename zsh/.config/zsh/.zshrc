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
if [ -f "$fb_config" ]
then
    source "$fb_config"
fi

# -----------------------------------------------------------------------------
# Antigen
# -----------------------------------------------------------------------------
source "$HOME/.local/share/zsh/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle git
antigen bundle tmux
# antigen bundle vi-mode

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load sindresorhus pure prompt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure@main

# Tell Antigen that you're done.
antigen apply

# -----------------------------------------------------------------------------
# Prompt (green vs magenta default)
# -----------------------------------------------------------------------------
PROMPT='%}%(12V.%F{242}%12v%f .)%(?.%F{green}.%F{red})${PURE_PROMPT_SYMBOL:->>}%f '

# -----------------------------------------------------------------------------
# ENV variables
# -----------------------------------------------------------------------------
export BROWSER="$(if [[ -n "$DISPLAY" ]]; then echo 'firefox'; else echo 'links'; fi)"
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'nvim'; else echo 'vi'; fi)"
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=130000
export SAVEHIST=130000
export TMPDIR="/var/tmp"
export VISUAL=nvim
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude __generated__'


# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------
alias vim=nvim

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
