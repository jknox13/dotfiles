# -------------------------
#           _
#          | |
#   _______| |__  _ __ ___
#  |_  / __| '_ \| '__/ __|
#   / /\__ \ | | | | | (__
#  /___|___/_| |_|_|  \___|
# -------------------------

# -----------------------------------------------------------------------------
# Shared config
# -----------------------------------------------------------------------------
source "$XDG_CONFIG_HOME/shell/exports"
source "$XDG_CONFIG_HOME/shell/aliases"
source "$XDG_CONFIG_HOME/shell/vcs"

# -----------------------------------------------------------------------------
# Hooks
# -----------------------------------------------------------------------------
autoload -Uz add-zsh-hook

# Set pane/terminal title to the running command name, clear on completion
__set_title_preexec() { printf '\033]2;%s\033\\' "${1%% *}"; }
__clear_title_precmd() { printf '\033]2;\033\\'; }
add-zsh-hook preexec __set_title_preexec
add-zsh-hook precmd __clear_title_precmd

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------
setopt PROMPT_SUBST

typeset -g __prompt_vcs=""
typeset -g __prompt_async_fd=""

__prompt_dir() {
    local toplevel
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null) \
        || toplevel=$(__find_hg_root) \
        || { print -n '%~'; return; }
    local prefix=${toplevel%/*}/
    print -n "${PWD#$prefix}"
}

__prompt_git_status() {
    local indicators=""
    git diff --quiet 2>/dev/null || indicators+="%F{red}*%f"
    git diff --cached --quiet 2>/dev/null || indicators+="%F{green}+%f"
    [ -n "$(git ls-files --others --exclude-standard --directory --no-empty-directory 2>/dev/null | head -1)" ] && indicators+="%F{blue}?%f"

    local lr
    if lr=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null); then
        local ahead=${lr%%	*} behind=${lr##*	}
        (( ahead > 0 )) && indicators+="%F{cyan}↑${ahead}%f"
        (( behind > 0 )) && indicators+="%F{cyan}↓${behind}%f"
    fi

    [ -n "$indicators" ] && print -n " $indicators"
}

__prompt_vcs_info() {
    # git
    local branch sha
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        print -n " on %B%F{magenta}${branch}%f%b"
        __prompt_git_status
        print
        return
    elif sha=$(git rev-parse --short HEAD 2>/dev/null); then
        print -n " on %B%F{magenta}HEAD%f%b %B%F{green}(${sha})%f%b"
        __prompt_git_status
        print
        return
    fi

    # mercurial
    local hg_root
    hg_root=$(__find_hg_root) || return
    local bookmark="" node=""
    [ -f "$hg_root/.hg/bookmarks.current" ] && bookmark=$(< "$hg_root/.hg/bookmarks.current")
    node=$(xxd -l 20 -p "$hg_root/.hg/dirstate" 2>/dev/null | head -c 12)

    local hg_status indicators=""
    hg_status=$(hg status 2>/dev/null)
    print -r -- "$hg_status" | grep -q '^[M\!]' && indicators+="%F{red}*%f"
    print -r -- "$hg_status" | grep -q '^A' && indicators+="%F{green}+%f"
    print -r -- "$hg_status" | grep -q '^\?' && indicators+="%F{blue}?%f"

    if [ -n "$bookmark" ]; then
        print -n " on %B%F{magenta}${bookmark}%f%b %B%F{green}(${node})%f%b"
    elif [ -n "$node" ]; then
        print -n " at %B%F{green}${node}%f%b"
    fi
    [ -n "$indicators" ] && print -n " $indicators"
    print
}

__prompt_async_callback() {
    local fd=$1
    local vcs_info
    if IFS= read -r -u $fd vcs_info 2>/dev/null; then
        __prompt_vcs="$vcs_info"
    fi
    zle -F $fd
    exec {fd}<&-
    __prompt_async_fd=""
    zle && zle reset-prompt
}

__prompt_async_start() {
    # Clean up previous async process
    if [[ -n "$__prompt_async_fd" ]]; then
        zle -F $__prompt_async_fd 2>/dev/null
        exec {__prompt_async_fd}<&- 2>/dev/null
    fi

    __prompt_vcs=""

    local fd
    exec {fd}< <(__prompt_vcs_info)
    __prompt_async_fd=$fd
    zle -F $fd __prompt_async_callback
}

__prompt_precmd() {
    local depth=$((SHLVL - PROMPT_BASE_SHLVL + 1))
    __prompt_chevron="%B%F{yellow}${(pl:$depth::❯:)}%f%b"
    __prompt_dir_str="$(__prompt_dir)"
    __prompt_readonly=""
    [[ ! -w . ]] && __prompt_readonly=" %F{yellow}🔒%f"
    __prompt_async_start
}
add-zsh-hook precmd __prompt_precmd

PROMPT=$'\n''${SSH_CONNECTION:+%B%F{green\}(ssh)%f%b}%B%F{yellow}%n@%m%f%b in %B%F{cyan}${__prompt_dir_str}%f%b${__prompt_readonly}${__prompt_vcs}'$'\n''%(1j.%B%F{yellow}✦%f%b .)%(?..%B%F{red}✘%?%f%b )%(!.%B%F{red}(ROOT)%f%b .)${VIRTUAL_ENV:+%F{green\}(${VIRTUAL_ENV:t})%f }${__prompt_chevron} '

# -----------------------------------------------------------------------------
# Key bindings
# -----------------------------------------------------------------------------
# Force emacs mode (EDITOR=vi causes zsh to default to vi bindings)
bindkey -e

# Cycle through history with up/down
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# -----------------------------------------------------------------------------
# Local extensions
# -----------------------------------------------------------------------------
for _rc in "$XDG_CONFIG_HOME/zsh/conf.d/"*.zsh(N); do source "$_rc"; done

# -----------------------------------------------------------------------------
# ENV variables
# -----------------------------------------------------------------------------
[[ -d "$XDG_DATA_HOME/zsh" ]] || mkdir -p "$XDG_DATA_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=130000
export SAVEHIST=130000

[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------
alias hgrep='history 0 | grep'

# -----------------------------------------------------------------------------
# Completion opts
# -----------------------------------------------------------------------------
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"
# Remove . & .. from completions
zstyle ':completion:*' special-dirs false
# Color completions using LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# -----------------------------------------------------------------------------
# Mac OSX path
# -----------------------------------------------------------------------------
if [[ "$OSTYPE" = darwin* ]]; then
    export PATH=/usr/local/{bin,sbin}:$HOME/.local/bin:$PATH
    export PATH=$HOME/bin:$PATH

    export GOKU_EDN_CONFIG_FILE="$XDG_CONFIG_HOME/karabiner/karabiner.edn"
fi
