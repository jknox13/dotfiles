" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" VIMRC
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vundle
set nocompatible  " Required
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'dense-analysis/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'python-mode/python-mode'
Plugin 'vim-syntastic/syntastic'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ryanoasis/vim-devicons'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'

" Color Schemes
Plugin 'altercation/vim-colors-solarized'

" Required. Plugins available after.
call vundle#end()

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Base Vim
filetype plugin indent on
set cursorline
set colorcolumn=80
set number
set relativenumber

" mousemode (only in normal mode)
set mouse=n

" unicode
set encoding=utf-8

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" colors: solarized
set t_Co=16
syntax enable
colorscheme solarized
let g:solarized_termtrans=1
let g:solarized_termcolors=16
let g:solarized_visibility="normal"
let g:solarized_contrast="normal"
"set background=light
set background=dark " dark | light "
call togglebg#map("<F5>")

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Ctrl P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" NERDTree
let NERDTreeShowHidden=1
nnoremap <silent> <C-n> :NERDTreeToggle <CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 &&
      \ exists("b:NERDTree") &&
      \ b:NERDTree.isTabTree()) | q | endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Ale -- lint only on save
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
