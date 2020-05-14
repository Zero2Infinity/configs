syntax on
set nocompatible              " be iMproved, required
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set encoding=utf-8
set clipboard=unnamedplus
filetype off                  " required

" Set of basic vim options
" line number
set number relativenumber
" alignment
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4 
set smarttab
set autoindent
" for searching
set smartcase
set incsearch
" colorcolumn
set colorcolumn=120
highlight ColorColumn ctermbg=3 guibg=lightgrey

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'git@github.com:kien/ctrlp.vim.git'
Plugin 'git@github.com:rking/ag.vim.git'
Plugin 'jremmen/vim-ripgrep'
Plugin 'Valloric/YouCompleteMe'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme gruvbox
set background=dark

" let definitions
let mapleader = " "

" Custom mapping 
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex<bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

" RG
if executable('Rg')
    let g:rg_derive_root='true'
    let g:rg_highlight='true'
endif

" CtrlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" FileTree
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=30

" AG 
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>gi :YcmCompleter GoToImplementation<CR>
nnoremap <silent> <leader>rr :YcmCompleter RefactorRename<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR> 

" Tagbar
nnoremap <silent> <leader>tt :TagbarToggle<CR>
nnoremap <silent> <leader>to :TagbarOpenAutoClose<CR>
