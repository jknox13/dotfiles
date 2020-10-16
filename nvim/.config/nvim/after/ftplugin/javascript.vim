let g:ale_javascript_eslint_suppress_missing_config = 1
let b:ale_linters = ['eslint']
let b:ale_fixers  = ['eslint', 'prettier']

setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
setlocal omnifunc=v:lua.vim.lsp.omnifunc
