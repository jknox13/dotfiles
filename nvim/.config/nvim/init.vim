" ---------------------------------
"  _       _ _         _
" (_)     (_) |       (_)
"  _ _ __  _| |___   ___ _ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
" ---------------------------------

syntax on

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

set noshowmode
set completeopt=menuone,noinsert,noselect
set cmdheight=2              " Give more space for displaying messages.
set updatetime=50            " shorten updatetime (from 4000ms)
set shortmess+=c             " Don't pass messages to |ins-completion-menu|.

" -----------------------------------------------------------------------------
" Plugins (using Plug)
" -----------------------------------------------------------------------------
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
let plugin_install_path = stdpath('data') . '/plugged'

" Install Plugins
call plug#begin(plugin_install_path)         " specifies directory for pluggins
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
call plug#end()                              " initialize plugin system

unlet autoload_plug_path
unlet plugin_install_path

" -----------------------------------------------------------------------------
" Colorscheme
" -----------------------------------------------------------------------------
set termguicolors
let ayucolor="dark"  " [light|mirage|dark]
colorscheme ayu

let g:lightline = {'colorscheme': 'ayu'}

" -----------------------------------------------------------------------------
" Nerd Tree
" -----------------------------------------------------------------------------
filetype plugin indent on
let NERDTreeShowHidden=1

" Open Tree when vim is opened without file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if Tree is only buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"

" LSP
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

imap <C-a> <home>
imap <C-e> <end>
cmap <C-a> <home>
cmap <C-e> <end>

map <C-n> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
" NVim - LSP
" -----------------------------------------------------------------------------
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua require'nvim_lsp'.bashls.setup{ on_attach=require'completion'.on_attach }
lua require'nvim_lsp'.pyls.setup{ on_attach=require'completion'.on_attach }
