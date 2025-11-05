" Kunal Sarkhel's Neovim Configuration

" AUTHOR:  Kunal Sarkhel
" EMAIL:   <kksarkhel@bluedevs.net>
" DATE:    January 15, 2015
" WEBSITE: https://github.com/techwizrd/dotfiles/
" LICENSE: GPLv3 available at http:/http://www.gnu.org/licenses/gpl-3.0.html/

" STARTUP SETTINGS {{{

set nocompatible   " stop vim from emulating vi

" use '.vim' directory instead of 'vimfiles' under Windows
if has("win32")
    set runtimepath=~/.vim,$VIMRUNTIME
endif

" Statusline configuration for vim-crystalline {{{
" vim-crystalline is supposedly faster than vim-airline
"function! StatusLine(...)
"  return crystalline#mode() . crystalline#right_mode_sep('')
"        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
"        \ . crystalline#left_sep('', 'Fill') . ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] '
"endfunction
"let g:crystalline_enable_sep = 1
"let g:crystalline_statusline_fn = 'StatusLine'

"function! g:CrystallineStatuslineFn(winnr)
"  let l:s = ''

"  let l:s .= ' %f%h%w%m%r '

"  " Add the current branch from vim-fugitive
"  " Plugins often provide functions for the statusline
"  "let l:s .= '%{fugitive#Head()} '

"  let l:s .= '%='

"  " Show settings in the statusline
"  let l:s .= '%{&paste ? "PASTE " : " "}'

"  return l:s
"endfunction

function! g:CrystallineStatuslineFn(winnr)
  let l:s = ''

  " Automatically create a mode highlight group, mode label, and separator
  " Same arguments as crystalline#Sep()
  let l:s .= crystalline#ModeSection(0, 'A', 'B')

  let l:s .= ' %f%h%w%m%r '

  let l:s .= crystalline#Sep(0, 'B', 'Fill')

  return l:s
endfunction

let g:crystalline_theme = 'dracula'
set laststatus=2
" }}}

" Enable vim-plug to load plugins {{{
" TODO: Use `nvim --startuptime nvim.log` to check how many milliseconds each
" plugin adds to the startup time. We should be able to pare this down a bit.
" TODO: Organize and document the purpose of each of these plugins
" TODO: Add pyright through either coc or ALE.
" TODO: Switch to either coc or ALE for autocomplete.
call plug#begin('~/.nvim/bundle')

" Make sure you use single quotes
"Plug 'tpope/vim-sensible' " sensible defaults for vim
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
Plug 'jlanzarotta/bufexplorer'
Plug 'kien/ctrlp.vim'
" TODO: Organize and document the purpose of each of these plugins
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
"Plug 'bling/vim-airline'
Plug 'rbong/vim-crystalline'
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-expand-region'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" Add filetype icons to NERRDtree, vim-airline, CtrlP, etc.
" TODO: Install patched font
"Plug 'ryanoasis/vim-devicons'
"Plug 'mattn/emmet-vim', {'for': 'html,css,javascript,django'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'Raimondi/delimitMate'
" TODO: Compare nerdcommenter with vim-commentary at some point
Plug 'scrooloose/nerdcommenter'
Plug 'chrisbra/NrrwRgn', {'on': 'NR'}
"Plug 'SirVer/UltiSnips' | Plug 'honza/vim-snippets'
Plug 'othree/vim-autocomplpop' | Plug 'vim-scripts/L9'
Plug 'ehamberg/vim-cute-python', {'for': 'python'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'Twinside/vim-haskellConceal', {'for': 'haskell'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'jtratner/vim-flavored-markdown', {'for': 'markdown'}
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown', 'on': ['GenTocGFM', 'GenTocRedcarpet', 'GenTocGitlab', 'GenTocMarked', 'UpdateToc', 'RemoveToc']}
Plug 'tpope/vim-haml', {'for': 'haml,sass'}
Plug 'othree/html5.vim', {'for': 'html,django'}
Plug 'klen/python-mode', {'for': 'python'}
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
"Plug 'hashivim/vim-vagrant'
Plug 'vimwiki/vimwiki'
" Add filetype icons to NERRDtree, vim-airline, CtrlP, etc.
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'freitass/todo.txt-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'Yggdroot/indentLine', {'for': 'yaml'}
Plug 'pedrohdz/vim-yaml-folds', {'for': 'yaml'}
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterEnable', 'GitGutterToggle']}
"Plug 'rktjmp/git-info' " Extracts git info for use in status line
"Plug 'JuliaEditorSupport/julia-vim'
"Plug 'w0rp/ale'  " Asynchronous linting using LSP
" Physics-based smooth scrolling for Vim/Neovim
Plug 'yuttie/comfortable-motion.vim'
"Plug 'vim-test/vim-test' " Run tests from vim
" Respect and use EditorConfig files if found
Plug 'editorconfig/editorconfig-vim'
" Intelligently reopen files at last edit position
Plug 'farmergreg/vim-lastplace'
call plug#end()
" }}}

filetype plugin on " re-enable filetype plugin

"set modelines=0    " stop vim from checking for modelines

let mapleader=","

" ENCODING {{{

"set termencoding=utf-8
set encoding=utf-8                            " encoding used within a vim
"set fileencodings=ucs-bom,utf-8,default,latin1 " encodings to try when editing a file

"}}}

" }}}

" INTERFACE OPTIONS {{{

syntax on          " enable syntax highlighting
set title          " set title to filename and modification status
set ruler          " always show current position
set ttyfast        " tell vim we have a fast tty (good for local computer, not for ssh)
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

" NOTE: Disabled these because they can be distracting with Dracula
"set cursorline     " highglight cursor line (useful, but sometimes slow)
"set cursorcolumn   " highlight currnet column  (useful,  but sometimes slow)

if version >= 703 "Vim 7.3+ specific features
    set colorcolumn=80
    set relativenumber
else
    set number
endif
nnoremap <leader>e :set nonumber!<CR>:set foldcolumn=0<CR>

" }}}

" VISUAL THEME AND APPEARANCE {{{

"set background=dark

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
        set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
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

"colorscheme wombat256
let g:dracula_italic=0
let g:dracula_colorterm=0
set termguicolors
colorscheme dracula

"}}}


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

" TODO: Do I still want this stuff?
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

set noshelltemp
set shell=/bin/sh          " Workaround because Vim doesn't like Fish shell
let g:tagbar_usearrows = 1 " make Tagbar to use arrows
let g:airline_powerline_fonts = 1 " make vim-airline use Powerline fonts
let g:rust_conceal = 1     " Enable conceal support in Rust
"let g:rust_conceal_mod_path = 1 " Conceal the :: in Rust

" Start YAML files unfolded
set foldlevelstart=20

" Open NERDTree or TagList using Control+x and Shift+x respectively
nnoremap <C-x> :NERDTreeToggle<CR>
nnoremap <S-x> :TagbarToggle<CR>

" Open a Scratch buffer
"nnoremap <leader><tab> :Scratch<CR>

" DelimitMate
let delimitMate_matchpairs = "(:),[:],{:},<:>"
au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"

" CtrlP.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,                    " MacOSX/Linux
set wildignore+=tmp\*,*.swp,*.zip,*.exe                      " Windows
set wildignore+=*.avi,*.mpg,*.flv,*.ogv,*.AVI                " Videos
set wildignore+=*.jpg,*.png,*.gif,*.JPG,*.GIF                " Images
set wildignore+=*.mp3,*.flac,*.ogg,*.wav,*.WAV,*.MP3,*.FLAC  " Audio/Music
set wildignore+=*.zip,*.rar,*.ZIP,*.cbz,*.cbr,*.tar.gz,*.tar " Archive

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|site-packages)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_cmd = 'CtrlPMixed'

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" Use Github Flavored Markdown by default
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Comfortable-motion: physics based smooth scrolling for Vim/Neovim
"let g:comfortable_motion_scroll_down_key = "j"
"let g:comfortable_motion_scroll_up_key = "k"

" Avoid loading EditorConfig for any remote files over ssh
let g:EditorConfig_exclude_patterns = ['scp://.*']

" TODO: This slows down Vim quite a bit on startup. We should asynchronously
" call `git rev-parse --is-inside-work-tree` using job_start (Vim8) or
" jobstart (Neovim) and use that for our if statement. Then we can set the
" following. This might be worth spinning out into a plugin.
" - g:pymode_rope=1
" - GitGutterEnable
" there's a better way to do this.
" Only use Rope for Git repositories
"python3 << EOF
"import vim
"import git
"def is_git_repo():
"    try:
"        _ = git.Repo('.', search_parent_directories=True).git_dir
"        return "1"
"    except:
"        return "0"
"vim.command("let g:pymode_rope = " + is_git_repo())
"EOF

" }}}

