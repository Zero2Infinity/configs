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

"" Set of basic vim options
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
set hlsearch
" colorcolumn
set colorcolumn=120
highlight ColorColumn ctermbg=3 guibg=lightgrey

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"" Custom plugins to closely match IDE functionalities
Plugin 'VundleVim/Vundle.vim'                       " Vundle manager required (PluginInstall/PluginClean)
Plugin 'morhetz/gruvbox'                            " Color Theme
Plugin 'preservim/nerdtree'                         " File Explorer
Plugin 'git@github.com:kien/ctrlp.vim.git'          " Ctrl + P to find file based on fuzzy search
Plugin 'git@github.com:rking/ag.vim.git'            " 
Plugin 'jremmen/vim-ripgrep'                        " Search word or pattern in entire project
Plugin 'Valloric/YouCompleteMe'                     " Auto complete dialog 
Plugin 'artur-shaik/vim-javacomplete2'              " Java specific auto complete features
Plugin 'mbbill/undotree'                            " Keeps track of changes to individual file
Plugin 'majutsushi/tagbar'                          " Class overview (variables, methods)
Plugin 'Valloric/ListToggle'                        " QuickFix and List windows (toggle)
Plugin 'tpope/vim-fugitive'                         " Git (status: stage, unstage, dv), merge file conflict
Plugin 'vim-airline/vim-airline'                    " Git branch indiction at status bar
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme gruvbox
set background=dark

"" let definitions
let mapleader = " "

"" Custom mapping 
nnoremap noh :noh<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex<bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gj :diffget //3<CR>
" Tab related shortcuts
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap tn :tabnew<CR>
nnoremap tf :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap td :tabclose<CR>


"" RG
if executable('rg')
    let g:rg_derive_root='true'
    let g:rg_highlight='true'
endif
" close quick fix window after item selection
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

"" CtrlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" NerdTree
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=35
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$']
set autochdir
let g:NERDTreeChDirMode=2
nnoremap <silent> <leader>n :NERDTree .<CR>
nnoremap nt :NERDTreeToggle<CR>
" show NERDTree when you open VIM
autocmd VimEnter * NERDTree
" close vim if nerdtree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" AG 
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"" YCM
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>gi :YcmCompleter GoToImplementation<CR>
nnoremap <silent> <leader>rr :YcmCompleter RefactorRename<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR> 

"" Tagbar
nnoremap <silent> <leader>to :TagbarOpenAutoClose<CR>
nnoremap <silent> <leader>tt :TagbarToggle<CR>

"" ListToggle
let g:lt_location_list_toggle_map='<leader>lt'
let g:lt_quickfix_list_toggle_map='<leader>ft'
let g:lt_height=10
