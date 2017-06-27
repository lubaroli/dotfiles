scriptencoding utf8

"------------------------------------------------------------------------------
" Plugins {

filetype off

call plug#begin('~/.local/share/nvim/bundle/') 

" Interactive REPL for NeoVim.
Plug 'hkupty/iron.nvim'

" File tree plugin.
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Status line plugin.
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy logic search engine.
Plug 'ctrlpvim/ctrlp.vim'

" Colorschemes.
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'

" Code completion for NeoVim.
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'zchee/deoplete-jedi', {'for': ['python', 'python3']}
Plug 'davidhalter/jedi-vim'

" Code linting.
Plug 'w0rp/ale'

" Code snippets.
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Version control tools.
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Plugin to use tab for autocompletion.
Plug 'ervandew/supertab'

" Plugin to comment text easily.
Plug 'tpope/vim-commentary'

" Simpe motion to jump to next two char block.
Plug 'justinmk/vim-sneak'

call plug#end()  

" }

"------------------------------------------------------------------------------
" Color Scheme configuration {

set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'
if has('nvim')
    set termguicolors
endif

" }

"------------------------------------------------------------------------------
" General config {

filetype plugin on      " Allow filespecific plugins.
set wildmenu            " Better command-line completion.
set laststatus=2        " Always display the status line .
set mouse=a             " Enable use of the mouse for all modes.
set ignorecase          " Make searching case insensitive.
set smartcase           " ...unless the query has capital letters.
set visualbell          " Use visual bell instead of beeping.
set autochdir           " Switch to current file's parent directory.
set ttimeout=10         " Set insermode timeout to 10ms.

if &undolevels < 200
    set undolevels=200  " Number of undo levels.
endif

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

" Allows you to switch from an unsaved buffer without saving it first.
" Also allows you to keep an undo history for multiple files.
set hidden

" Allow backspacing over autoindent, line breaks and start of insert.
set backspace=indent,eol,start

" }

"------------------------------------------------------------------------------
" Formatting options {

syntax on               " Enable syntax highlighting.
filetype indent on      " Allow indent for know filetypes.
set autoindent          " Keeps the same line ident for generic file types.
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set nojoinspaces        " Prevents two spaces after punctuation on a join (J)
set splitbelow          " Horizontal split below current. More natural splits.

" }

"------------------------------------------------------------------------------
" Mappings {

" Map the leader key to SPACE.
let mapleader="\<SPACE>"

" Move between buffers.
nmap <Leader>l :bnext<CR>
nmap <Leader>h :bprevious<CR>

" Close current buffer/tab.
nmap <Leader>w :bdelete<CR>

" Relative numbering.
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering. 'J' is for jump.
nnoremap <leader>j :call NumberToggle()<cr>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$

" Map ESC to exit Terminal mode in NeoVim.
if has('nvim') 
    :tnoremap <Esc> <C-\><C-n> 
endif

" Quick window navigation with Alt+HJKL.
nmap <silent> ˚ :wincmd k<CR>
nmap <silent> ∆ :wincmd j<CR>
nmap <silent> ˙ :wincmd h<CR>
nmap <silent> ¬ :wincmd l<CR>

" Remap <C-c> and <C-v> to copy/paste to/from clipboard.
vnoremap <C-c> "+y
vnoremap <C-x> "+d
nnoremap <C-V> "+P
vnoremap <C-V> "+P
nnoremap <C-v> "+p
vnoremap <C-v> "+p

" Clear search highlight after search.
nnoremap <C-L> :nohlsearch<CR><C-L>

" }

"----------------------------------------------------------------------
" Plugin specific options {

" Deoplete
" " Enable deoplete at startup.
" let g:deoplete#enable_at_startup = 1

" " Use smart case for deoplete completion.
" let g:deoplete#enable_smart_case = 1

" " Deoplete mappings.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" NERDTree
    map <Leader>t :NERDTreeToggle<CR>

" Ctrl-P
    " Open file menu.
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu.
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files.
    nnoremap <Leader>f :CtrlPMRUFiles<CR>

" Jedi
    " Force Jedi to use Python3.
    let g:jedi#force_py_version = 3
    let g:jedi#auto_close_doc = 1
    " Select candidate with <CR>.
    inoremap <expr> <silent> <CR> pumvisible() ? "<C-y>" : "<CR>"

" SuperTab
    " Let SuperTab scroll from top to bottom.
    let g:SuperTabDefaultCompletionType = "<c-n>"

" Airline
    let g:airline#extensions#ale = 1
    let g:airline_powerline_fonts = 1 
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#right_alt_sep = ''
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_theme= 'gruvbox'

" ALE {
    let g:ale_sign_column_always = 1
" }
" }
"----------------------------------------------------------------------
