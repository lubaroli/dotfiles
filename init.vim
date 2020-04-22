" =============================================================================
" Author: Lucas Barcelos de Oliveira
" Last update: 14/04/2020
"
" My init.vim for Neovim
" =============================================================================

" Plugins
" =======

filetype off

" Bootstrap Plug
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . 'plugged')

" File tree plugin.
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Tag management and visualization.
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

" Status line plugin.
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy logic search engine.
Plug 'ctrlpvim/ctrlp.vim'

" Colorschemes.
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'jacoborus/tender.vim'

" Plugin to add file type icons to many other plugins. Needs a patched font.
Plug 'ryanoasis/vim-devicons'

" LSP for NeoVim.
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Plugin for multi-language debugging
Plug 'puremourning/vimspector'

" Plugin to use tab for autocompletion.
Plug 'ervandew/supertab'

" Plugin to keep windows open on buffer close.
Plug 'qpkorr/vim-bufkill'

" Plugins to handle surroundings.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Plugin to display and clean leading whitespaces.
Plug 'ntpeters/vim-better-whitespace'

" Version control tools.
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Plugin to comment text easily.
Plug 'tpope/vim-commentary'

" Motion plugins
Plug 'easymotion/vim-easymotion'
Plug 'ryym/vim-unimpaired'

" Easy replace text with register using `gr`
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install


" General config
" ==============

syntax on               " Enable syntax highlighting.
filetype indent on      " Allow indent for know filetypes.
filetype plugin on      " Allow filespecific plugins.
set hidden              " Keep unsaved buffers in memory.
set encoding=UTF-8      " Set encoding to UTF-8.
set nobackup            " Some language servers have issues with backups.
set nowritebackup       " Some language servers have issues with backups.
set wildmenu            " Better command-line completion
set laststatus=2        " Always display the status line
set mouse=a             " Enable use of the mouse for all modes
set ignorecase          " Make searching case insensitive
set smartcase           " ...unless the query has capital letters
set visualbell          " Use visual bell instead of beeping
set autochdir           " Switch to current file's parent directory
set nowrap              " Don't wrap lines
set updatetime=300      " Improve experience for diagnostic messages
set shortmess+=c        " Don't give |ins-completion-menu| messages
set cmdheight=2         " Better display for messages
let ttimeout=10         " Set insermode timeout to 10ms
set splitbelow          " Make splits more natural
set splitright
set autoindent          " Keeps the same line ident for generic file types.
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set nojoinspaces        " Prevents two spaces after punctuation on a join (J)
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set tw=80               " Set document width...
set colorcolumn=+1      " ... and mark next column.

if &undolevels < 1000
    set undolevels=1000 " Number of undo levels
endif

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling
endif

" Makes only the neovim terminal hidden on when not loaded on a split/window
augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
augroup END

" Allow backspacing over autoindent, line breaks and start of insert
set backspace=indent,eol,start

" Better copy and paste, use same clipboard outside vim
set clipboard^=unnamedplus,unnamed

function! SetTextPrefs()
    setlocal spell
    setlocal wrap
    setlocal linebreak
    setlocal colorcolumn=""
endfunction

" Set syntax highlighting for specific file types
augroup file_syntax
  autocmd!
  autocmd BufRead,BufNewFile *.md call SetTextPrefs()
  autocmd BufRead,BufNewFile gitconfig.local call SetTextPrefs()
augroup END


" Color Scheme configuration
" ==========================

colorscheme gruvbox
let g:airline_theme='gruvbox'
set background=dark
if has('termguicolors')
    set termguicolors
endif


" Mappings
" ========

" Map the leader key to SPACE.
let mapleader="\<space>"

" Map ; to : for easier typing
nmap ; :

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$

" Redo
nnoremap U <C-r>

" Map ESC to exit Terminal mode in NeoVim.
if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
endif

" Easier block indentation, keeps visual selection
vnoremap < <gv
vnoremap > >gv

" Clear search highlight after search.
nnoremap <leader>l :nohlsearch<CR>


" Navigation mappings
" ===================

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


" Plugin specific options
" =======================

" Auto Pairs
" ----------
let g:AutoPairsShortcutFastwrap='<M-e>'

" coc.nvim
" --------

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" Tagbar
" ------
nmap <Leader>t :TagbarToggle<CR>

" NERDTree
" --------
map <Leader>n :NERDTreeToggle<CR>

" Ctrl-P
" ------
" Open file menu (o for open file)
nnoremap <Leader>o :CtrlP<CR>

" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>

" Open most recently used files (h for history)
nnoremap <Leader>h :CtrlPMRUFiles<CR>

" Keep persistent cache file
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" use ag for searching instead of vim's globpath()
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" SuperTab
" --------
" Let SuperTab scroll from top to bottom.
let g:SuperTabDefaultCompletionType = "<c-n>"
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1

" Airline
" -------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

" Better-whitespaces
" ------------------
let g:strip_whitespace_on_save = 1

" Signify
" -------
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'

" Unimpaired
" ----------
" Disable encodings and '[e' and ']e' for line swap
let g:unimpaired_mapping = {
\ 'encodings' : 0,
\ 'excludes' : { 'lineopes' : ['e']}
\ }
