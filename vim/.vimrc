" Set XDG defaults
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME . '/.config' | endif

" Source real config
let s:vimrc = $XDG_CONFIG_HOME . '/vim/vimrc'
if filereadable(s:vimrc) | execute 'source' s:vimrc | endif
