" Author: tsny
" Description: my .vimrc
" Attributions: jdavis, tpope, stevelosh, tshirtman_ 

" Before loading begins

" Few commands for improving performance
set regexpengine=1
set synmaxcol=200
set nocompatible
set modelines=0

" Setting default shell 
if has('win32unix') || has('win32')
    set shell=C:\Program\ Files\Git\bin\bash
else
    set shell=/bin/bash
endif

filetype indent on
filetype plugin on

set autoread
set wildmenu
set wildignore+=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn,*/cm/log/**
set wildignore+=tags,*.jpg,*.png,*.jpeg,*.png,*.mesh,build*/**,build/**,*.svg,build2/**,build3/**
set lazyredraw

" Status line

set laststatus=2

" Left side of status bar
set laststatus=2
set statusline=
set statusline+=%*\ %l
set statusline+=\ %*
set statusline+=%*\%f\ %*
set statusline+=%*\ %m

set statusline+=%*\ %F

" Seperator
set statusline+=%=

" Right side of status line
set statusline+=%((%l,%c)%)\ 
set statusline+=%=%*%y%*%*\              
set statusline+=%P\ \                     

" Functions

function! Fullscreen()
    if has("gui_running")
      " GUI is running or is about to start.
      " Maximize gvim window (for an alternative on Windows, see simalt below).
      set lines=999 columns=999
    else
      " This is console Vim.
      if exists("+lines")
        set lines=50
      endif
      if exists("+columns")
        set columns=100
      endif
    endif
endfunction

function! CopyFilePath()

    " Convert slashes to backslashes for Windows 
    " and adds colon after drive name
    " Example file without fix 
    " /c/Users/tsny7/.vimrc
    
    if has('win32unix')
        " Win Terminal VIM
        let path=substitute(expand("%:p"), "/", "\\", "g")
        let @*=path[1] . ":" . path[2:]

    elseif has('win32')
        " GVIM
        let path=substitute(expand("%:p"), "/", "\\", "g")
        let @*=path

    else
        " MacVIM
        let @*=expand("%:p")
    endif

    echo "copied path: " . @*
endfunction

function! CopyFileName()
    let @*=expand("%")
    echo "copied filename: " . @*
endfunction

function! CopyDir()
    let @*=expand("%:p:h")
    echo "copied dir: " . @*
endfunction

function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline guibg=lightred ctermbg=lightred
    else
        hi statusline guibg=lightgreen ctermbg=lightgreen
    endif
endfunction

" Auto-commands

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=lightblue ctermbg=cyan

" Bare necessities

syntax on
inoremap jk <Esc>
let mapleader = ","
nnoremap ; :
vnoremap ; :

" Numbers and Lines

"set number relativenumber
set number

" Remaps

" Insert new line below without entering insert mode (also removes
" help-mapping)
nnoremap K o<Esc>k

" Terminal binding that auto sources .bash_profile
"nnoremap <leader>z :term<CR>source $HOME/.bash_profile<CR>
nnoremap <leader>tz :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>

" Quickly get into .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Begins open vsplit command
nnoremap <leader>os :vsp<cr>

" Open file explorer
nnoremap <leader>oe :Vexplore<CR>

" Makes all splits equal size
nnoremap <leader>eq <C-w>=

" Reloads .vimrc
nnoremap <leader>so :so $MYVIMRC<CR>

" Force quit fast
nnoremap <leader>q :q!<CR>

" Faster saving
nnoremap <leader>w :w<CR>

" Gettin' outta there quick
nnoremap <leader>z :wq<CR>

" Faster quitting
nnoremap zz ZZ
nnoremap zq ZQ

" Clear search with esc to get rid of highlighting
nnoremap <leader><leader> :noh<CR>

" Deleting a character does not overwrite buffer
nnoremap x "_x

" Select pasted text
nnoremap <leader>p V`]

" Moving quickly around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Terminal splits movement - Testing, might break stuff
if v:version >800
    tnoremap <C-h> <C-w><C-h>
    tnoremap <C-j> <C-w><C-j>
    tnoremap <C-k> <C-w><C-k>
    tnoremap <C-l> <C-w><C-l>
endif

" Tab matches bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Save the current session
nnoremap <leader>ms :mksession!<CR>

" Tab moving with leader n/m
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Move up and down display lines rather than actual lines (for when lines
" are wrapped)
nnoremap j gj
nnoremap k gk

" Code blocks remain selected after indenting them
vnoremap < <gv
vnoremap > >gv

" Swap visual and visual line
nnoremap v <S-V>
nnoremap <S-V> v
vnoremap v <S-V>
vnoremap <S-V> v

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Mapping for fullscreen call
nnoremap <leader>fs :call Fullscreen()<CR>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Remap VIM 0 to first non-blank character
noremap 0 $
noremap $ ^

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Folding
set foldmethod=indent
set foldlevel=99
nnoremap <leader>ff za

" Copy file details
nnoremap <leader>cfp :call CopyFilePath()<CR>
nnoremap <leader>cfn :call CopyFileName()<CR>
nnoremap <leader>cfd :call CopyDir()<CR>

" Splits

set splitright
set splitbelow

" Searching

set gdefault
set incsearch
set showmatch
set hlsearch

set ignorecase
set smartcase

" Indents

set autoindent
set smartindent

" Look n' Feel

" Removes startup message
set cmdheight=2
set shortmess=Ia

" GUI Settings

" Remove toolbars on windows
:set guioptions-=m
:set guioptions-=T
:set guioptions-=r
:set guioptions-=L

" Setting guifont, defaults to lesser-quality fonts if the previously tried ones don't exist
if has("gui_running")
    silent! set guifont=Consolas:h14,Office\ Code\ Pro:h14
    set columns=150
    set lines=50
endif

" Setting colorscheme, degrades/defaults in a similar way to guifont
colorscheme desert
silent! colorscheme atom-dark-256

" Moves the window rather than the cursor
" set scrolloff=20

" Tabs are spaces 
set tabstop=4 shiftwidth=4 expandtab

" File Explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3 
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Hide files that can't really be edited
let g:netrw_list_hide= '.*\.swp$,.DS_Store,.meta,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'

" Misc    

" Yanking always copies to clipboard
set clipboard=unnamed

" Allows the deletion of previously typed characters in a different insert-mode 'instance'
set backspace=indent,eol,start

" No more backups and swaps
set nobackup
set noswapfile

if exists('&belloff')
    set belloff=all
endif

" After all loading
set ruler
set showcmd
set cmdheight=1

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1

"Default the status bar to lightblue
hi statusline guibg=lightblue ctermbg=lightblue
