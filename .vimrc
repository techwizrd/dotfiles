" Kunal Sarkhel's Vim (and GVim) Configuration

" AUTHOR:  Kunal Sarkhel
" EMAIL:   <theninja@bluedevs.net>
" DATE:    August 12, 2011
" WEBSITE: https://github.com/techwizrd/dotfiles/blob/master/.vimrc
" LICENSE: GPLv3 available at http:/http://www.gnu.org/licenses/gpl-3.0.html/

" NOTES: I've written this over the past few years by reading through the Vim
"        help, Vim wiki, various dotfiles around the internet, and personal
"        preferences. Any functions or settings I've found elsewhere have not
"        been attributed and it would be nigh impossible to track down the
"        original authors anyway. I've tried to keep everything well organized,
"        well commented, and portable so that it can be brought to other systems
"        without modification. Please feel free to contact me and send me a
"        patch or pull request if you have any nice additions, tips or
"        suggestions, or comments. I am always looking for ways to improve my
"        vim configuration and improve my efficiency so please feel free to
"        contact me and send me a patch or pull request if you have any nice
"        additions, tips or suggestions, or comments.

" STARTUP SETTINGS {{{

set nocompatible   " stop vim from emulating vi

" use '.vim' directory instead of 'vimfiles' under Windows
if has("win32")
    set runtimepath=~/.vim,$VIMRUNTIME
endif

" Enable Pathogen to load plugin bundles from ~/.vim/bundles/
filetype off       " temporarily disable for Pathogen
call pathogen#runtime_append_all_bundles()
filetype plugin on " re-enable filetype plugin

set modelines=0    " stop vim from checking for modelines

" quickly edit and source .vimrc
nnoremap <silent> <S-W>e :edit $MYVIMRC<CR>
nnoremap <silent> <S-W>r :source $MYVIMRC<CR>

let mapleader=","

" ENCODING {{{

set termencoding=utf-8
set encoding=utf-8                            " encoding used within a vim
"set fileencodings=ucs-bom,utf-8,default,latin1 " encodings to try when editing a file

"}}}

" }}}

" INTERFACE OPTIONS {{{

syntax on          " enable syntax highlighting
set title          " set title to filename and modification status
set ruler          " always show current position
set ttyfast
set mouse=a        " enable mouse usage in terminal (good for scrolling)
set backspace=2    " allow backspacing over everything in insert mode

set showcmd        " always show the command being typed
set showmode       " show current mode

" Show tabstops (and optionally eol characters)
set list listchars=tab:▸·,trail:·
"set list listchars=tab:▸\ ,eol:¬

" HELPFUL REMAPPINGS {{{

" Hardwrap a paragraph of text
nnoremap <leader>q gqip

" Remap jj to Esc in insert mode
inoremap jj <ESC>

" }}}

" MOVEMENT / NAVIGATION {{{

set scrolloff=5       " scrolling starts 5 lines before window border
"set virtualedit=block " allow cursor to move past last character on line in visual block mode

" Always use gj, gk to prevent skipping over wrapped line
nnoremap j gj
nnoremap k gk

" move between functions with Tab/Shift+Tab in normal mode
nmap <silent> <Tab> :silent! normal ]]<CR>
nmap <silent> <S-Tab> :silent! normal [[<CR>

" }}}

" HISTORY OPTIONS {{{

set history=500    " history of commands and searches
set undolevels=500 " changes to be remembered

" }}}

" WARNING/REDRAW OPTIONS {{{

set noerrorbells   " no bell for error messages
set lazyredraw     " don't redraw the screen when executing macros

" }}}

" SEARCH OPTIONS {{{

" use regular regexes, not vim's weird default
nnoremap / /\v
vnoremap / /\v

set ignorecase     " case insensitive search
set smartcase      " case sensitive when uppercase present
set gdefault       " apply substitutions globally on lines
set incsearch      " search incrementally
set showmatch      " show matching brackets and parentheses

set hlsearch       " highlight search terms
" clear the search highlight
nnoremap <leader>/ :noh<CR> 

" redraw window so that search terms are centered
nnoremap n nzz
nnoremap N Nzz

" }}}

" LINE NUMBERING AND COLUMNS {{{

set cursorline     " highglight cursor line (useful, but sometimes slow)
set cursorcolumn   " highlight currnet column  (useful,  but sometimes slow)

if version >= 703 "Vim 7.3+ specific features
    set colorcolumn=80
    set relativenumber
else
    set number
endif
nnoremap <leader>e :set nonumber!<CR>:set foldcolumn=0<CR>

" }}}

" VISUAL THEME AND APPEARANCE {{{

set background=dark

if has('gui_running') " gvim options
    colorscheme wombat256

    set lines=45   " Show 45 lines instead of default 24
    set columns=90 " Show 90 columns

    " Clean up gvim interface
    set guioptions+=mTLlRrb " remove all the scrollbars and menubars in GVim
    set guioptions-=mTLlRrb " remove all the scrollbars and menubars in GVim
    "set guioptions-=m " remove menu bar
    "set guioptions-=T " remove toolbar
    "set guioptions-=L " remove left vertical split scrollbar
    "set guioptions-=l " remove left scrollbar
    "set guioptions-=R " remove right vertical split scrollbar
    "set guioptions-=r " remove right scrollbar
    "set guioptions-=b " remove bottom scrollbar

    if has("unix")
        set guifont=Monospace\ 8
    elseif has("win32")
        set guifont=Consolas:h10
    end

    "autocmd FocusLost * wall
else " terminal vim options
    " If the terminal supports 256 color, force 256 colors and use a 256 color
    " colorscheme. If the terminal does not support 256 colors, use a 16 color
    " colorscheme.
    if &term == "xterm" || &term == "rvxt-unicode-256color" || &term =~# "screen"
        set t_Co=256
        colorscheme wombat256
    else
        " Use a 16 color colorscheme
        colo default
    endif
endif

"}}}

"" STATUSLINE {{{

"" use smart statusline if 256 colours are available or if gVim is running
"if &t_Co == 256 || has("gui_running")
"   set statusline=%!MyStatusLine('Enter')

"   " colours
"   " 113 / #87d75f : light-green
"   " 203 / #ff5f5f : red
"   " 208 / #ff8700 : orange
"   " 212 / #ff87d7 : pink
"   highlight StatColor guibg=#87d75f guifg=Black ctermbg=113 ctermfg=Black
"   highlight Modified guibg=#ff8700 guifg=Black ctermbg=208 ctermfg=Black

"   augroup smart_statusline
"       autocmd!
"       autocmd WinEnter * setlocal statusline=%!MyStatusLine('Enter')
"       autocmd WinLeave * setlocal statusline=%!MyStatusLine('Leave')

"       autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
"       autocmd InsertLeave * highlight StatColor guibg=#87d75f guifg=Black ctermbg=113 ctermfg=Black
"       autocmd InsertLeave * highlight Modified guibg=#ff8700 guifg=Black ctermbg=208 ctermfg=Black
"   augroup end

"   function! MyStatusLine(mode)
"       let l:statusline = ""
"       if a:mode == "Enter"
"           let l:statusline .= "%#StatColor#"
"       endif

"       let l:statusline .= "\(%n\)\ %f\ "
"       if a:mode == "Enter"
"           let l:statusline .= "%*"
"       endif

"       let l:statusline .= "%#Modified#%m"
"       if a:mode == "Leave"
"           let l:statusline .= "%*%r"
"       elseif a:mode == "Enter"
"           let l:statusline .= "%r%*"
"       endif

"       let l:statusline .= "\ (%l,%v)\ [%P\ of\ %L]%=%w\ %y\ [%{&encoding}:%{&fileformat}]"
"       return l:statusline
"   endfunction

"   function! InsertStatuslineColor(mode)
"       if a:mode == "i"
"           highlight StatColor guibg=#ff5f5f ctermbg=203
"       elseif a:mode == "r"
"           highlight StatColor guibg=#ff87d7 ctermbg=212
"       elseif a:mode == "v"
"           highlight StatColor guibg=#ff87d7 ctermbg=212
"       else
"           highlight StatColor guibg=#ff5f5f ctermbg=203
"       endif
"   endfunction
"else
"   set statusline=\(%n\)\ %f\ %m%r\ (%l,%v)\ [%P\ of\ %L]%=%w\ %y\ [%{&encoding}:%{&fileformat}]
"endif

"" }}}

" }}}

" FILE SETTINGS {{{

" write to root-owned file when running as non-root by piping through tee using sudo
cnoremap w!! write !sudo tee % > /dev/null

set spelllang=en_us   " set spellchecking region to US English

" CODE FOLDING {{{

set foldmethod=marker " fold code by markers

" Preserve fold state
" au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
nnoremap <space> za

" }}}

" BACKUP OPTIONS {{{

"Don't create backup files everywhere
"set backupdir=~/.vim/tmp/backup,/tmp
"set directory=~/.vim/tmp/swap,/tmp
set nobackup
set nowritebackup
set noswapfile
if v:version >= 730
  set undofile
  set undodir=~/.vim/tmp/undo,/tmp
endif

" }}}

" BUFFER MANAGEMENT {{{

set hidden    " allow buffer to be changed without writing to disk
set autoread  " update file when externally modified
set autochdir " change to directory of active buffer
set switchbuf=useopen

" Switch buffers using PageUp/PageDown and tabs with Control+PageUp/PageDown
nnoremap <PageDown> :bn<CR>     
nnoremap <PageUp> :bp<CR>
nnoremap <Control><PageDown> :tabn<CR>
nnoremap <Control><PageUp> :tabp<CR>

" }}}

" INDENTING {{{

set fileformats=unix,dos,mac "try recognizing line endings in this order
set tabstop=4      " width of a tab character in spaces
set shiftwidth=4   " number of spaces to use for autoindent
set softtabstop=4  " defines number of spaces for adding/removing tabs
set expandtab      " insert spaces instead of tabs
set autoindent     " automatic indenting
set cindent        " automatic indenting
set shiftround     " indent/dedent to nearest tabstops
filetype indent on " enable automatic indentation based on filetype

" }}}

" CUSTOM FILETYPE INDENTING {{{

autocmd FileType alsaconf,asm,autoit,context,css,dot,eruby,html,io,javascript,lisp,markdown,ocaml,perl,php,smarty,sql,plaintex,ruby,sh,svn,tex,textile,vb,vim,xhtml,xml,xslt setlocal ts=2 sts=2 sw=2 expandtab nocindent
autocmd FileType c,cs,cpp,php setlocal ts=3 sts=3 sw=3 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType apache setlocal ts=4 sts=4 sw=4
autocmd FileType mail setlocal ts=2 sts=2 sw=2 expandtab tw=80 lbr
autocmd FileType tex,plaintex,context setlocal lbr
autocmd FileType ruby compiler ruby | setlocal makeprg=ruby\ -c\ %

autocmd BufEnter /home/*/bin/*.run setf sh
autocmd BufEnter *.inc,*.thtml setf php
autocmd BufEnter *.boo setf python
autocmd BufEnter *.io setf io
autocmd BufEnter *.red setf textile
autocmd BufEnter *.plan setf ruby
autocmd BufEnter ~/.devilspie/* setf lisp

" Ruby block auto-completion
  function! RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let brackets_at_end = '[\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
    let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

    if match(current_line, braces_at_end) >= 0
      return "\<CR>}\<C-O>O"
    elseif match(current_line, brackets_at_end) >= 0
      return "\<CR>\1\<C-O>O"
    elseif match(current_line, stuff_without_do) >= 0
      return "\<CR>end\<C-O>O"
    elseif match(current_line, with_do) >= 0
      return "\<CR>end\<C-O>O"
    else
      return "\<CR>"
    endif
  endfunction

  autocmd FileType ruby inoremap <buffer> <CR> <C-R>=RubyEndToken()<CR>

" }}}

" COPY / PASTE {{{

set clipboard=unnamed

" use Linux clipboard register if supported (requires vim 7.3.74)
if has("unix") && v:version >= 703
    "set clibpboard+=unnamedplus
endif

" Use ,v to paste from the X clipboard
nnoremap <leader>v "+gP
"nnoremap <leader>v i<C-r>+

" Control+X to Cut, Control+C to Copy
vnoremap <C-X> "+x
vnoremap <C-C> "+y

" }}}

" }}}

" PLUGIN OPTIONS AND PLUGIN REMAPPINGS {{{

let g:tagbar_usearrows = 1 " make Tagbar to use arrows

" Open NERDTree or TagList using Control+x and Shift+x respectively
nnoremap <C-x> :NERDTreeToggle<CR>
nnoremap <S-x> :TagbarToggle<CR>

" Remap FuzzyFinder
nnoremap <leader>t :FufFile<Cr>

" Open a Scratch buffer
nnoremap <leader><tab> :Scratch<CR>

" DelimitMate
let delimitMate_matchpairs = "(:),[:],{:},<:>"
au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"

" }}}

