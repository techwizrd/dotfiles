filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin on

set nocompatible
filetype indent on
set modelines=0

syntax on       " enable syntax highlighting

" My default tab settings
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

set encoding=utf-8
set cursorline
set ruler
set ttyfast
set mouse=a     " enable mouse usage in terminal (good for scrolling)
set backspace=2 " allow backspacing over everything in insert mode

" Make vim search sane
" use regular regexes, not vim's weird default
nnoremap / /\v
vnoremap / /\v
set ignorecase  " case insensitive search
set smartcase   " case sensitive when uppercase present
set gdefault    " apply substitutions globally on lines
set incsearch
set showmatch   " show matching brackets and parentheses
set hlsearch
" clear the search highlight
nnoremap <leader><space> :noh<CR> 

"Don't create backup files everywhere
set backupdir=/tmp
set dir=/tmp

let mapleader=","

" show line numbers
set number
nnoremap <leader>e :set nonumber!<CR>:set foldcolumn=0<CR>

" Switch buffers using PageUp/PageDown
nnoremap <PageDown> :bn<CR>     
nnoremap <PageUp> :bp<CR>
nnoremap <Control><PageDown> :tabn<CR>
nnoremap <Control><PageUp> :tabp<CR>

" Open NERDTree or TagList using Control+x and Shift+x respectively
nnoremap <C-x> :NERDTreeToggle<CR>
nnoremap <S-x> :TlistToggle<CR>

" Remap FuzzyFinder
nnoremap <leader>t :FufFile<Cr>

" Use ,v to paste from the X clipboard
"nnoremap <leader>v "+gP
nnoremap <leader>v i<C-r>+

" Hardwrap a paragraph of text
nnoremap <leader>q gqip

" Open a scratch buffer
nnoremap <leader><tab> :Scratch<CR>

" Remap jj to Esc in insert mode
inoremap jj <ESC>

" Always gj, gk
nnoremap j gj
nnoremap k gk

" Jump to top or bottom of screen
nnoremap <S-h> gT
nnoremap <S-l> gt 

" Preserve fold state
" au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set switchbuf=useopen

set autochdir

" Show tabstops (and optionally eol characters)
set list
"set listchars=tab:▸\
set listchars=tab:▸.
"set listchars=tab:▸\ ,eol:¬

"Vim 7.3+ specific features
if version >= 703
    set colorcolumn=80
    set relativenumber
endif

set background=dark
set t_Co=256
colorscheme wombat256
if has('gui_running')
    " wombat-eye looks better in GVim
    colorscheme wombat-eye

    " Show 40 lines instead of default 24
    set lines=40

    "Disable toolbar and menubar in GVim
    set guioptions-=m
    set guioptions-=T
    
    " Turn off those annoying scrollbars
    set guioptions+=LlRrb
    set guioptions-=LlRrb

    set guifont=Monospace\ 8
    autocmd FocusLost * wall
endif
