filetype off

call pathogen#runtime_append_all_bundles()

set nocompatible
filetype plugin on
filetype indent on

set tabstop=4
set shiftwidth=4
set expandtab

set gcr=a:blinkon0  " never blink the cursor

set ruler
set mouse=a

set incsearch
set hlsearch

set backspace=2

"Don't create backup files everywhere
"set backupdir=~/.vim/backup
"set dir=~/.vim/backup
set backupdir=/tmp
set dir=/tmp

syntax on
set number
nnoremap <S-e> :set nonumber!<CR>:set foldcolumn=0<CR>

nnoremap <PageDown> :bn<CR>
nnoremap <PageUp> :bp<CR>

nnoremap <Control><PageDown> :tabn<CR>
nnoremap <Control><PageUp> :tabp<CR>

"set foldmethod=syntax
nnoremap <space> za
nnoremap ,b zR<Cr>
nnoremap ,n zM<Cr>

"Remap FuzzyFinder
"Open files
nnoremap ,t :FufFile<Cr>

" Always gj, gk
nnoremap j gj
nnoremap k gk

" Preserve fold state
" au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set background=dark
set t_Co=256

colorscheme wombat256
if has('gui_running')
    " wombat-eye looks better in GViM
    colorscheme wombat-eye

    "Disable toolbar and menubar in GVim
    set guioptions-=m
    set guioptions-=T
    
    " Turn off those annoying scrollbars
    set guioptions+=LlRrb
    set guioptions-=LlRrb

    set guifont=Monospace\ 8
endif
