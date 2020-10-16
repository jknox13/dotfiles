" ---------------------------------
"  _       _ _         _
" (_)     (_) |       (_)
"  _ _ __  _| |___   ___ _ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
" ---------------------------------

" -----------------------------------------------------------------------------
" Plugins (using Plug)
" -----------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')
" Appearance
" -------------------------
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
" Plug 'nvim-lua/lsp-status.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'

" IDE & LSP
" -------------------------
" Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'

" Navigation
" -------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'preservim/nerdtree'
Plug 'unblevable/quick-scope'

" Ease of Use
" -------------------------
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-reapeat'

" C/Cpp
" -------------------------
Plug 'octol/vim-cpp-enhanced-highlight'

" Hack
" -------------------------
Plug 'hhvm/vim-hack'

" JavaScript
" -------------------------
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Python
" -------------------------
Plug 'vim-python/python-syntax'

call plug#end()

" -----------------------------------------------------------------------------
" Base Settings
" -----------------------------------------------------------------------------
syntax on
filetype plugin indent on

set number
set relativenumber
setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set smartindent
set noswapfile
set nohlsearch
set noshowmode
set nobackup
set undodir=$HOME/.cache/vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set encoding=utf-8
set mouse=n

set noshowmode
set completeopt=menuone,noinsert,noselect
set cmdheight=2              " Give more space for displaying messages.
set updatetime=50            " shorten updatetime (from 4000ms)
set shortmess+=c             " Don't pass messages to |ins-completion-menu|.

" -----------------------------------------------------------------------------
" Colorscheme
" -----------------------------------------------------------------------------

set t_Co=256
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors
let ayucolor="mirage"  " [light|mirage|dark]
colorscheme ayu

let g:lightline = {'colorscheme': 'ayu'}

" -----------------------------------------------------------------------------
" Quickscope
" -----------------------------------------------------------------------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" -----------------------------------------------------------------------------
" Nerd Tree
" -----------------------------------------------------------------------------
"let NERDTreeShowHidden=1
"
"" Open Tree when vim is opened without file
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
"" Close vim if Tree is only buffer open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" map <C-n> :NERDTreeToggle<CR>
"
" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>i :edit ~/.config/nvim/init.vim<CR>
nnoremap <Leader><CR> :source ~/.config/nvim/init.vim<CR>
nnoremap <Leader>ex :Explore<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>sp :setlocal spell spelllang=en_us<CR>

imap <C-a> <home>
imap <C-e> <end>
cmap <C-a> <home>
cmap <C-e> <end>

" -----------------------------------------------------------------------------
" NVim - LSP
" -----------------------------------------------------------------------------
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

"lua require'nvim_lsp'.pyls.setup{ on_attach=require'completion'.on_attach }
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_insert_delay = 1
let g:space_before_virtual_text = 10

autocmd FileType javascript,bash,python setlocal signcolumn=yes
:lua << EOF
    local nvim_lsp = require('nvim_lsp')
    local completion = require('completion')
    local diagnostic = require('diagnostic')

    local on_attach = function(client)
        completion.on_attach(client)
        diagnostic.on_attach(client)
    end

    nvim_lsp.bashls.setup{on_attach = on_attach}

    nvim_lsp.flow.setup{
--         settings = {
--             flow = {
--                 useLSP = false;
--                 showStatus = true;
--                 runOnEdit = false;
--             };
--         };
        on_attach = on_attach;
    }
EOF

nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vd  :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vh  :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vi  :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
