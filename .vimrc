filetype off

call pathogen#runtime_append_all_bundles()

set nocompatible
filetype plugin on
filetype indent on

" Default tab settings
set tabstop=4 shiftwidth=4 expandtab

augroup vimrc
au!
autocmd FileType css setlocal sw=4 sts=4 et
autocmd FileType haskell setlocal sw=4 sts=4 et
autocmd FileType html setlocal sw=2 sts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 et
autocmd FileType java setlocal sw=4 sts=4 et
autocmd FileType perl setlocal sw=4 sts=4 et
autocmd FileType php setlocal sw=4 sts=4 et
autocmd FileType python setlocal sw=4 sts=4 et
autocmd FileType ruby setlocal sw=2 sts=2 et
autocmd FileType scheme setlocal sw=2 sts=2 et
autocmd FileType sql setlocal et
autocmd FileType text setlocal sw=2 sts=2 et
augroup END

"set gcr=a:blinkon0  " never blink the cursor

set ruler
set mouse=a

set incsearch
set hlsearch

set backspace=2 " allow backspacing over everything in insert mode

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

nnoremap <space> za
nnoremap ,b zR<Cr>
nnoremap ,n zM<Cr>

nnoremap <C-x> :TlistClose<CR>:NERDTreeToggle<CR>
nnoremap <S-x> :NERDTreeClose<CR>:TlistToggle<CR>

"Remap FuzzyFinder
nnoremap ,t :FufFile<Cr>

" Always gj, gk
nnoremap j gj
nnoremap k gk

" Preserve fold state
" au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set background=dark
set t_Co=256

set switchbuf=useopen

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

set autochdir

"set list
"set listchars=tab:>.
