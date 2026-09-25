" Author: tsny
" Description: my .vimrc
" Attributions: jdavis, tpope, stevelosh, tshirtman_ 
"
"""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"""

" --- BEFORE OTHER CMDS ---

" Few commands for improving performance
set regexpengine=0
set synmaxcol=1000
set redrawtime=10000
set nocompatible
set modelines=0

" Disable syntax on very large files (>1MB)
autocmd BufReadPre * if getfsize(expand("%")) > 1000000 | syntax off | endif

" Prevent terminal response sequences from leaking into input buffer in WSL
set t_RV=
set t_u7=

" auto change dir
" autocmd BufEnter * silent! lcd %:p:h

" Setting default shell in windows
if has('win32unix') || has('win32')
    set shell=C:\Program\ Files\Git\bin\bash
endif

" Allows for plugins/indents based on filetype
filetype indent on
filetype plugin on

" Automatically reload unmodified buffers when files change on disk.
set autoread
augroup AutoReloadBuffers
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
augroup END
set wildmenu
set wildignore+=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn,*/cm/log/**
set wildignore+=tags,*.jpg,*.png,*.jpeg,*.png,*.mesh,build*/**,build/**,*.svg,build2/**,build3/**
set lazyredraw

" Functions
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

" Bare necessities
syntax on

nnoremap <leader>l :RustRun<CR>

inoremap <special> jk <ESC>
inoremap <special> <C-k> <ESC>
let mapleader = ","
nnoremap ; :
vnoremap ; :

" Numbers and Lines

"set number relativenumber
set number

" --- BINDINGS ---

" Insert new line below without entering insert mode (also removes
" help-mapping)
nnoremap K o<Esc>k

" Format file
map <F7> gg=G<C-o><C-o>
map <leader>fj :%!jq .<CR>

" Terminal binding that auto sources .bash_profile
"nnoremap <leader>z :term<CR>source $HOME/.bash_profile<CR>
"nnoremap <leader>tz :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>

" Quickly get into .vimrc
nnoremap <leader>ev :tabnew<cr>:e $MYVIMRC<cr>
nnoremap <leader>ez :tabnew<cr>:e ~/.zshrc<cr>

" Begins open vsplit command
nnoremap <leader>vs :vsp<cr>
nnoremap <leader>hs :split<cr>

" Open vifmrc
nnoremap <leader>fm :tabnew<cr>:e ~/.config/vifm/vifmrc<cr>

" Open file explorer
nnoremap <leader>oe :Vexplore<CR>

" Fzf
nnoremap <c-f> :Rg<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-h> :History<cr>
nnoremap <leader>ff :Files ~/<cr>
nnoremap H :History<cr>
nnoremap <leader>b :Buffers<cr>

let g:fzf_buffers_jump = 1
if !has('win32unix') && isdirectory('/opt/homebrew/opt/fzf')
    set rtp+=/opt/homebrew/opt/fzf
endif

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git"'

" Makes all splits equal size
nnoremap <leader>eq <C-w>=

" Reloads .vimrc
nnoremap <leader>so :so $MYVIMRC<CR>

" Faster saving
nnoremap <leader>w :w<CR>

" Clear search with esc to get rid of highlighting
nnoremap <C-c> :noh<CR>

" Deleting a character does not overwrite buffer
nnoremap x "_x

" Select pasted text
nnoremap <leader>p V`]

" Move through Vim splits first, then hand navigation to Zellij at an edge.
let g:tmux_navigator_no_mappings = 1
let s:zellij_directions = {
            \ 'h': 'left',
            \ 'j': 'down',
            \ 'k': 'up',
            \ 'l': 'right',
            \ }
let s:tmux_navigation_commands = {
            \ 'h': 'TmuxNavigateLeft',
            \ 'j': 'TmuxNavigateDown',
            \ 'k': 'TmuxNavigateUp',
            \ 'l': 'TmuxNavigateRight',
            \ }

function! s:NavigatePane(direction) abort
    let l:previous_window = winnr()
    execute 'wincmd ' . a:direction

    if winnr() != l:previous_window
        return
    endif

    if !empty($ZELLIJ)
        silent call system('zellij action move-focus ' . s:zellij_directions[a:direction])
    elseif !empty($TMUX) && exists(':' . s:tmux_navigation_commands[a:direction])
        execute s:tmux_navigation_commands[a:direction]
    endif
endfunction

function! s:SetZellijMode(mode) abort
    if !empty($ZELLIJ)
        silent call system('zellij action switch-mode ' . a:mode)
    endif
endfunction

nnoremap <silent> <C-h> :<C-U>call <SID>NavigatePane('h')<CR>
nnoremap <silent> <C-j> :<C-U>call <SID>NavigatePane('j')<CR>
nnoremap <silent> <C-k> :<C-U>call <SID>NavigatePane('k')<CR>
nnoremap <silent> <C-l> :<C-U>call <SID>NavigatePane('l')<CR>

" Zellij's locked mode passes Ctrl-h/j/k/l through to Vim. Restore normal
" mode whenever Vim loses focus so the same keys keep working in other panes.
augroup ZellijPaneNavigation
    autocmd!
    autocmd VimEnter,FocusGained * call <SID>SetZellijMode('locked')
    autocmd FocusLost,VimLeavePre * call <SID>SetZellijMode('normal')
    if exists('##VimSuspend')
        autocmd VimSuspend * call <SID>SetZellijMode('normal')
        autocmd VimResume * call <SID>SetZellijMode('locked')
    endif
augroup END

" Make the same navigation work from Vim terminal buffers.
if has('terminal')
    tnoremap <silent> <C-h> <C-w>:call <SID>NavigatePane('h')<CR>
    tnoremap <silent> <C-j> <C-w>:call <SID>NavigatePane('j')<CR>
    tnoremap <silent> <C-k> <C-w>:call <SID>NavigatePane('k')<CR>
    tnoremap <silent> <C-l> <C-w>:call <SID>NavigatePane('l')<CR>
endif

" Tab matches bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" Save the current session
" nnoremap <leader>ms :mksession!<CR>

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

" Easy set syntax
nnoremap <leader>ss :set syntax=

" Tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tm :tabmove<Space>
map <Leader>tc <esc>:tabclose<CR>


" Automatically move to text instead of netrw

map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Mouse support for netrw
set mouse=n

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" Thin bar cursor in input mode -----------
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
" -----------------------------------------


" Treat extensionless and commonly named kubeconfig files as YAML.
augroup kubeconfig_yaml
    autocmd!
    autocmd BufRead,BufNewFile */.kube/config,*/.kube/config.*,*/kubeconfig,*/kubeconfig.*,*.kubeconfig setfiletype yaml
augroup END

" Folding
set foldmethod=indent
set foldlevel=99
"nnoremap <leader>ff za

" Copy file details
nnoremap <leader>cfp :call CopyFilePath()<CR>
nnoremap <leader>cfn :call CopyFileName()<CR>
nnoremap <leader>cfd :call CopyDir()<CR>

" Set json syntax and format it
nnoremap <leader>fj :set syntax=json<CR> :execute '%!python3 -m json.tool'<CR>

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

" --- AESTHETIC ---

set title

" Removes startup message
set shortmess=Ia

" GUI Settings

" Remove toolbars on windows
:set guioptions-=m
:set guioptions-=T
:set guioptions-=r
:set guioptions-=L

" Setting guifont, defaults to lesser-quality fonts if the previously tried ones don't exist
if has("gui_running")
    silent! set guifont=Office\ Code\ Pro:h12
    set columns=150
    set lines=50
endif

" Moves the window rather than the cursor
set scrolloff=20
set cursorline

" Tabs are spaces 
set tabstop=4 shiftwidth=4 expandtab
au BufRead,BufNewFile *.zsh setlocal shiftwidth=2

" File Explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 1 
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15 

" Hide these filetypes in netrw 
let g:netrw_list_hide= '.*\.swp$,.DS_Store,ntuser*,NTUSER*,.meta,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'

" -- MISC --

" Yanking always copies to clipboard
set clipboard=unnamed

" Allows the deletion of previously typed characters in a different insert-mode 'instance'
set backspace=indent,eol,start

" No backups and swaps
set nobackup
set noswapfile

" Bells
if exists('&belloff')
    set belloff=all
endif

" After all loading
set ruler
set showcmd
set cmdheight=2

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1

autocmd FileType markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Helper for tsv files
au BufNewFile,BufRead *.tsv setlocal noexpandtab shiftwidth=20 softtabstop=20 tabstop=20

" Vim Plug if it exists
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'gruvbox-community/gruvbox'
    Plug 'mtdl9/vim-log-highlighting'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'chrisbra/csv.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'nathanaelkane/vim-indent-guides'

    Plug 'powerman/vim-plugin-AnsiEsc'

    Plug 'hashivim/vim-terraform'

    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'

    Plug 'ryanoasis/vim-devicons'

    Plug 'easymotion/vim-easymotion'
    map  f <Plug>(easymotion-bd-f)
    nmap f <Plug>(easymotion-overwin-f)

    Plug 'preservim/nerdtree'
    nnoremap <leader>oe :NERDTree<CR>
    let NERDTreeShowHidden=1
    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

call plug#end()

let g:airline_section_b = '%{pathshorten(getcwd())}'

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p


"" GOLANG ---------------------------------------------------
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1

" Something for go and indent lines
set et
let g:indent_guides_start_level=1

nnoremap <leader>gb :GoBuild<CR>
nnoremap <leader>gtf :GoTestFunc<CR>
nnoremap <leader>gta :GoTest<CR>
nnoremap <leader>gi :GoInfo<CR>
nnoremap <leader>gl :GoLint<CR>
nnoremap <leader>gr :GoRun<CR>
"" ----------------------------------------------------------

" Enable colors in tmux
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

function! SetThemeFromSystem()
    let l:mode = system('defaults read -g AppleInterfaceStyle 2>/dev/null')
    if l:mode =~? 'dark'
        set background=dark
    else
        set background=light
    endif
    try
        colorscheme atom-dark-256
    catch
        try
            colo darkblue
        catch
        endtry
    endtry
endfunction

augroup SystemTheme
    autocmd!
    autocmd VimEnter,FocusGained * call SetThemeFromSystem()
augroup END


" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
