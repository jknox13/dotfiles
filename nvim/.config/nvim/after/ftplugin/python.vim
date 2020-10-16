let b:ale_linters = ['pyre', 'mypy', 'flake8']
let b:ale_fixers  = ['black']

setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
setlocal omnifunc=v:lua.vim.lsp.omnifunc
