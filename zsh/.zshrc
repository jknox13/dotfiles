# ----------------------------------------------------------------------------
# ZSHRC
# ----------------------------------------------------------------------------
# Antigen
source $HOME/.zsh/antigen.zsh

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
antigen bundle sindresorhus/pure

# Tell Antigen that you're done.
antigen apply

# -----------------------------------------------------------------------------
# prompt (green vs magenta default)
PROMPT='%}%(12V.%F{242}%12v%f .)%(?.%F{green}.%F{red})${PURE_PROMPT_SYMBOL:->>}%f '

# -----------------------------------------------------------------------------
# ENV variables
export BROWSER="$(if [[ -n "$DISPLAY" ]]; then echo 'firefox'; else echo 'links'; fi)"
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'nvim'; else echo 'vi'; fi)"
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=10000
export VISUAL=nvim

# -----------------------------------------------------------------------------
# alias
alias vim=nvim

# -----------------------------------------------------------------------------
# Mac OSX path
# TODO: define better MacOSX check
if [ -e "/usr/local/Cellar" ]
then
    export PATH=/usr/local/{bin,sbin}:$HOME/.local/bin:$PATH
    export PATH=$HOME/bin:$PATH
    export PATH="/usr/local/Cellar/python@3.8/3.8.5/Frameworks/Python.framework/Versions/3.8/bin:$PATH"
fi
