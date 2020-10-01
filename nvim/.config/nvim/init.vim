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
Plug 'ayu-theme/ayu-vim'
" Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'preservim/nerdtree'
" Plug 'vim-python/python-syntax'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-unimpaired'
Plug 'unblevable/quick-scope'
call plug#end()

" -----------------------------------------------------------------------------
" Base Settings
" -----------------------------------------------------------------------------
syntax on
filetype plugin indent on

set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set noshowmode
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set encoding=utf-8

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

" LSP
"nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
"nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
"nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
"nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
"nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
"nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
"nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

imap <C-a> <home>
imap <C-e> <end>
cmap <C-a> <home>
cmap <C-e> <end>


" -----------------------------------------------------------------------------
" NVim - LSP
" -----------------------------------------------------------------------------
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"lua require'nvim_lsp'.bashls.setup{ on_attach=require'completion'.on_attach }
"lua require'nvim_lsp'.pyls.setup{ on_attach=require'completion'.on_attach }
