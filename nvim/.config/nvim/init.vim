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
" auto-install vim-plug
const plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  silent exe '!curl -fLo ' . plug_path . ' --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif
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
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Navigation
" -------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Telescope is much much too slow for large projects, even with fzf-native
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'unblevable/quick-scope'

" Ease of Use
" -------------------------
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

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

" Writing
" -------------------------
Plug 'junegunn/goyo.vim'

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

" TODO: encorporate lightlight change
nnoremap <Leader>csd :let ayucolor="dark"<bar>:colorscheme ayu<CR>
nnoremap <Leader>csm :let ayucolor="mirage"<bar>:colorscheme ayu<CR>
nnoremap <Leader>csl :let ayucolor="light"<bar>:colorscheme ayu<CR>

" -----------------------------------------------------------------------------
" Quickscope
" -----------------------------------------------------------------------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"

" consistency with C, D
nnoremap Y y$

" hard mode
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" fzf
nnoremap <Leader>f  :Files<CR>
nnoremap <Leader>b  :Buffers<CR>
nnoremap <Leader>m  :Marks<CR>
nnoremap <Leader>rg :Rg<Space>


" TODO: figure out how to do this with fnamemodify()
nnoremap <Leader>eh :edit %:h/

nnoremap <Leader>i :edit ~/.config/nvim/init.vim<CR>
nnoremap <Leader><CR> :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>
nnoremap <Leader>sp :setlocal spell spelllang=en_us<CR>

imap <C-a> <home>
imap <C-e> <end>
cmap <C-a> <home>
cmap <C-e> <end>

" -----------------------------------------------------------------------------
" NVim - LSP
" -----------------------------------------------------------------------------
:lua << EOF
    local opts = { noremap=true, silent=true }

    -- Telescope
    -- require('telescope').load_extension('fzf')
    -- vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope find_files<CR>', opts)
    -- vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<CR>', opts)
    -- vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', opts)

    -- LSP
    local lspconfig = require('lspconfig')
    local completion = require('completion')

    local on_attach = function(client)
        completion.on_attach(client)

        -- Mappings.
        vim.api.nvim_set_keymap('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vd',  '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vh',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vi',  '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>vic', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<leader>voc', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

        -- style
        vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
        vim.g.diagnostic_enable_virtual_text = 1
        vim.g.diagnostic_show_sign = 1
        vim.g.diagnostic_insert_delay = 1
        vim.g.space_before_virtual_text = 10
        vim.opt_local.signcolumn = 'yes:1'
    end

    local servers = { 'bashls', 'flow', 'hh_client', 'pyls' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
EOF
