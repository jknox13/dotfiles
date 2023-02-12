# -------------------------
#           _
#          | |
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__
#  /___|___/_| |_|_|  \___|
# -------------------------

# -----------------------------------------------------------------------------
# Antigen
# -----------------------------------------------------------------------------
export ADOTDIR="$XDG_DATA_HOME/zsh/antigen"
export ANTIGEN_CACHE=false  # hack to get new path to work

source "$XDG_DATA_HOME/zsh/antigen.zsh"
#antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
#antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle sindresorhus/pure@main
antigen apply

# -----------------------------------------------------------------------------
# Cycle through history with up/down
# -----------------------------------------------------------------------------
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# -----------------------------------------------------------------------------
# FB
# -----------------------------------------------------------------------------
fb_config="$XDG_CONFIG_HOME/zsh/fb.zsh"
[[ -f "$fb_config" ]] && source "$fb_config"

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
# TODO -- update to ignore hgoriginal https://github.com/junegunn/fzf.vim/issues/453#issuecomment-767427765
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude __generated__'

# my binaries
export PATH="$PATH:$HOME/.local/bin"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

local NPM_PACKAGES="$XDG_DATA_HOME/npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# pip
export PYTHONUSERBASE="$XDG_DATA_HOME/pip-packages"
export PATH="$PATH:$PYTHONUSERBASE/bin"

# rust cargo
export PATH="$PATH:$HOME/.cargo/env"

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------
alias vim=nvim
alias hgrep='history 0 | grep'

# -----------------------------------------------------------------------------
# Completion opts
# -----------------------------------------------------------------------------
# Remove . & .. from completions
zstyle ':completion:*' special-dirs false

# -----------------------------------------------------------------------------
# Mac OSX path
# -----------------------------------------------------------------------------
# TODO: define better MacOSX check
if [[ "$OSTYPE" = darwin* ]]; then
    #local cellar="/usr/local/Cellar"
    #export PATH=/usr/local/{bin,sbin}:$HOME/.local/bin:$PATH
    #export PATH=$HOME/bin:$PATH
    #export PATH="$cellar/python@3.8/3.8.5/Frameworks/Python.framework/Versions/3.8/bin:$PATH"
    local homebrew="$HOME/homebrew"
    export PATH="$homebrew/bin:$homebrew/sbin:$PATH"

    export GOKU_EDN_CONFIG_FILE="$XDG_CONFIG_HOME/karabiner/karabiner.edn"
fi
