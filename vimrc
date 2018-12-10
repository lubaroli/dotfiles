"------------------------------------------------------------------------------
" Author: Lucas Barcelos de Oliveira
" Last update: 15/07/2017
"
" My .vimrc file for use with Neovim and/or Vim 8

scriptencoding utf8

" Automatic reloading of .vimrc on save
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost *vimrc source $MYVIMRC | AirlineRefresh
augroup END " }

"------------------------------------------------------------------------------
" Plugins {{{

filetype off

call plug#begin('~/.local/share/nvim/bundle/')

" File tree plugin.
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Collection of language packs
Plug 'sheerun/vim-polyglot'

" Tag visualization plugin
Plug 'majutsushi/tagbar'

" Status line plugin.
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy logic search engine.
Plug 'ctrlpvim/ctrlp.vim'

" Colorschemes.
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'jacoborus/tender.vim'

" Code completion for NeoVim.
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

" Plugins to handle surroundings.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Plugin to use tab for autocompletion.
Plug 'ervandew/supertab'

" Code linting.
Plug 'w0rp/ale'

" Code snippets.
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Version control tools.
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Plugin to comment text easily.
Plug 'tpope/vim-commentary'

" Simple motion to jump to next two char block.
Plug 'justinmk/vim-sneak'

" Plugin to add file type icons to many other plugins
Plug 'ryanoasis/vim-devicons'

call plug#end()

" }}}

"------------------------------------------------------------------------------
" General config {{{

filetype plugin on      " Allow filespecific plugins.
set wildmenu            " Better command-line completion.
set laststatus=2        " Always display the status line .
set mouse=a             " Enable use of the mouse for all modes.
set ignorecase          " Make searching case insensitive.
set smartcase           " ...unless the query has capital letters.
set visualbell          " Use visual bell instead of beeping.
set autochdir           " Switch to current file's parent directory.
set foldmethod=marker   " Use three { as marker for folds
set tw=79               " Set document width...
set colorcolumn=80      " ... and mark column 80
set nowrap              " Don't wrap lines
let ttimeout=10         " Set insermode timeout to 10ms.

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

" Better copy and paste, use same clipboard outside vim
set clipboard=unnamed

" }}}

"------------------------------------------------------------------------------
" Color Scheme configuration {{{

colorscheme gruvbox
let g:airline_theme='gruvbox'
set background=dark
if has('termguicolors')
    set termguicolors
endif
" }}}

"------------------------------------------------------------------------------
" Formatting options {{{

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

" }}}

"------------------------------------------------------------------------------
" Mappings {{{

" Map the leader key to SPACE.
let mapleader="\<SPACE>"

" Map ; to : for easier typing
nmap ; :

" Move between buffers.
nmap <Leader>k :bnext<CR>
nmap <Leader>j :bprevious<CR>

" Easier block indentation, keeps visual selection
vnoremap < <gv
vnoremap > >gv

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

" Toggle between normal and relative numbering. 'C' is for change.
nnoremap <leader>c :call NumberToggle()<cr>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$

" Map ESC to exit Terminal mode in NeoVim.
if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
endif

" Quick window navigation with Alt+HJKL. On iTerm, remember to make left option
" key work like +Esc
nmap <silent><M-k> :wincmd k<CR>
nmap <silent><M-j> :wincmd j<CR>
nmap <silent><M-h> :wincmd h<CR>
nmap <silent><M-l> :wincmd l<CR>

" Clear search highlight after search.
nnoremap <C-L> :nohlsearch<CR><C-L>

" }}}

"----------------------------------------------------------------------
" Plugin specific options {{{

" Deoplete
    " Enable deoplete at startup.
    let g:deoplete#enable_at_startup = 1
    " Use smart case for deoplete completion.
    let g:deoplete#enable_smart_case = 1
    " Make Deoplete ignore open buffers.
    let b:deoplete_ignore_sources = ['buffer']
    inoremap <silent><expr><CR> pumvisible() ?
                \ deoplete#mappings#close_popup() : "\<CR>"

" " Jedi
"     " Force Jedi to use Python3.
"     let g:jedi#force_py_version = 3
"     let g:jedi#auto_close_doc = 1
"     " Select candidate with <CR>.
"     inoremap <expr> <silent> <CR> pumvisible() ? "<C-y>" : "<CR>"
"     " Set variable refactoring to <leader> 'v'
"     let g:jedi#rename_command = "<leader>v"
"     " Set usages to <leader> 'u'
"     let g:jedi#usages_command = "<leader>u"

" SuperTab
    " Let SuperTab scroll from top to bottom.
    let g:SuperTabDefaultCompletionType = "<c-n>"
    " close the preview window when you're not using it
    let g:SuperTabClosePreviewOnPopupClose = 1

" UltiSnips
    " Use <TAB> for everything except snippets
    let g:UltiSnipsExpandTrigger="<C-j>"

" Tagbar
    nmap <Leader>t :TagbarToggle<CR>

" NERDTree
    map <Leader>n :NERDTreeToggle<CR>

" Ctrl-P
    " Open file menu.
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu.
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files.
    nnoremap <Leader>l :CtrlPMRUFiles<CR>
    " Keep persistent cahe file
    let g:ctrlp_clear_cache_on_exit = 1
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    " use ag for searching instead of vim's globpath()
    if executable('ag')
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif

" Airline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#ale = 1
    let g:airline_powerline_fonts = 1

" ALE
    let g:ale_sign_column_always = 1
    let g:ale_sign_error = '!'
    let g:ale_sign_warning = '!'

" Sneak
    let g:sneak#s_next = 1

" Signify
    let g:signify_sign_change = '~'
    let g:signify_sign_delete = '-'

" Auto Pairs
    let g:AutoPairsShortcutFastwrap='<M-e>'

" }}}
"----------------------------------------------------------------------
