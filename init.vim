"------------------------------------------------------------------------------
" Author: Lucas Barcelos de Oliveira
" Last update: 07/08/2019
"
" My .vimrc file for use with Neovim and/or Oni

scriptencoding utf8

"------------------------------------------------------------------------------
" Plugins {{{

filetype off

call plug#begin('~/.local/share/nvim/bundle/')

if !exists("g:gui_oni")
    " File tree plugin.
    Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

    " Tag management and visualization
    Plug 'majutsushi/tagbar'
    Plug 'ludovicchabant/vim-gutentags'

    " Status line plugin
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Fuzzy logic search engine
    Plug 'ctrlpvim/ctrlp.vim'

    " Colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'joshdick/onedark.vim'
    Plug 'jacoborus/tender.vim'

    " LSP for NeoVim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Plugin to use tab for autocompletion
    Plug 'ervandew/supertab'

    " Plugin to keep windows open on buffer close
    Plug 'qpkorr/vim-bufkill'
    endif

" Plugins to handle surroundings.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Plugin to display and clean leading whitespaces
Plug 'ntpeters/vim-better-whitespace'

" Version control tools.
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Plugin to comment text easily.
Plug 'tpope/vim-commentary'

" Simple motion to jump to next two char block.
Plug 'justinmk/vim-sneak'

" Plugin to add file type icons to many other plugins
Plug 'ryanoasis/vim-devicons'

" Plugin for interactive iPython REPL
Plug 'bfredl/nvim-ipy'

call plug#end()

" }}}

"------------------------------------------------------------------------------
" General config {{{

filetype plugin on      " Allow filespecific plugins
set wildmenu            " Better command-line completion
set laststatus=2        " Always display the status line
set mouse=a             " Enable use of the mouse for all modes
set ignorecase          " Make searching case insensitive
set smartcase           " ...unless the query has capital letters
set visualbell          " Use visual bell instead of beeping
set autochdir           " Switch to current file's parent directory
set foldmethod=marker   " Use three { as marker for folds
set tw=79               " Set document width...
set colorcolumn=80      " ... and mark column 80
set nowrap              " Don't wrap lines
set updatetime=300      " Improve experience for diagnostic messages
set shortmess+=c        " Don't give |ins-completion-menu| messages
let ttimeout=10         " Set insermode timeout to 10ms
set splitbelow          " Make splits more natural
set splitright

if &undolevels < 200
    set undolevels=200  " Number of undo levels
endif

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling
endif

" Allows you to switch from an unsaved buffer without saving it first
" Also allows you to keep an undo history for multiple files
set hidden

" Makes only the neovim terminal hidden on when not loaded on a split/window
augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
augroup END

" Allow backspacing over autoindent, line breaks and start of insert
set backspace=indent,eol,start

" Better copy and paste, use same clipboard outside vim
set clipboard=unnamed

if exists('g:gui_oni')
    " Disable nvim statusbar and use oni's
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    " editor.fontFamily Hack??
endif
" }}}

"------------------------------------------------------------------------------
" Color Scheme configuration {{{

" If not on Oni, use theme below
if !exists('g:gui_oni')
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
    set background=dark
    if has('termguicolors')
        set termguicolors
    endif
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
let mapleader="\<space>"

" Map ; to : for easier typing
nmap ; :

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$

" Map ESC to exit Terminal mode in NeoVim.
if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
endif

" Easier block indentation, keeps visual selection
vnoremap < <gv
vnoremap > >gv

" Clear search highlight after search.
nnoremap <C-L> :nohlsearch<CR><C-L>

"------------------------------------------------------------------------------
" Navigation mappings

" Move between buffers.
nmap <Leader>k :bnext<CR>
nmap <Leader>j :bprevious<CR>

" Close current buffer/tab.
nmap <Leader>w :BD!<CR>

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

" Quick window navigation with Alt+HJKL. On iTerm, remember to make left
" option key work like +Esc
nmap <silent><M-k> :wincmd k<CR>
nmap <silent><M-j> :wincmd j<CR>
nmap <silent><M-h> :wincmd h<CR>
nmap <silent><M-l> :wincmd l<CR>

" Auto Pairs
let g:AutoPairsShortcutFastwrap='<M-e>'

if !exists('g:gui_oni')
    " Mappings for terminal

    " coc.nvim
    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at
    " current position. Coc does snippet and additional edit on confirm.
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Use <leader> + l as baseline command (l for language server)
    nmap <silent> <leader>lE <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>le <Plug>(coc-diagnostic-next)
    nmap <silent> <leader>ld <Plug>(coc-definition)
    nmap <silent> <leader>ly <Plug>(coc-type-definition)
    nmap <silent> <leader>li <Plug>(coc-implementation)
    nmap <silent> <leader>lr <Plug>(coc-references)
    " Use k as a shorthand to show documentation in preview window
    nnoremap <silent> <leader>lk :call CocActionAsync("doHover")<CR>
    " Remap for rename current word
    nmap <leader>lr <Plug>(coc-rename)
    " Remap for do codeAction of current line
    nmap <leader>la  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>lf  <Plug>(coc-fix-current)

    " Tagbar
    nmap <Leader>t :TagbarToggle<CR>

    " NERDTree
    map <Leader>n :NERDTreeToggle<CR>

    " Ctrl-P
    " Open file menu (o for open file)
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files (h for history)
    nnoremap <Leader>h :CtrlPMRUFiles<CR>
else
    " Keymaps for Oni
    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> <leader>lE :call OniCommand('oni.editor.previousError')<CR>
    nmap <silent> <leader>le :call OniCommand('oni.editor.nextError')<CR>
    " Remap for rename current word
    nmap <leader>lr :call OniCommand('')
endif

" nvim-ipy
let g:nvim_ipy_perform_mappings = 0
" Use <leader> + r as baseline command
" Run current line or selection
map <silent> <leader>r <Plug>(IPy-Run)
" Run all lines in buffer
map <silent> <leader>ra <Plug>(IPy-RunAll)
" Complete command on iPython
map <silent> <leader>rc <Plug>(IPy-Complete)
" Send interrupt to kernel
map <silent> <leader>ri <Plug>(IPy-Interrupt)
" Terminate kernel
map <silent> <leader>rt <Plug>(IPy-Terminate)

" }}}

"----------------------------------------------------------------------
" Plugin specific options {{{

if !exists('g:gui_oni')
    " Plugin options for terminal only

    " SuperTab
    " Let SuperTab scroll from top to bottom.
    let g:SuperTabDefaultCompletionType = "<c-n>"
    " close the preview window when you're not using it
    let g:SuperTabClosePreviewOnPopupClose = 1

    " Airline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline_powerline_fonts = 1

    " Ctrl-P
    " Keep persistent cahe file
    let g:ctrlp_clear_cache_on_exit = 1
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    " use ag for searching instead of vim's globpath()
    if executable('ag')
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif
endif

" Better-whitespaces
let g:strip_whitespace_on_save = 1

" Sneak
let g:sneak#s_next = 1

" Signify
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'

" }}}
"----------------------------------------------------------------------
