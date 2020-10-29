" =============================================================================
" Author: Lucas Barcelos de Oliveira
" Last update: 17/09/2020
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

" Plugins to handle surroundings.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Motion plugins
Plug 'asvetliakov/vim-easymotion'
Plug 'ryym/vim-unimpaired'
Plug 'bkad/CamelCaseMotion'

" Easy replace text with register using `gr`
Plug 'vim-scripts/ReplaceWithRegister'

" Case sensitive search and replace
Plug 'tpope/vim-abolish'

call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

" " Better copy and paste, use same clipboard outside vim
set clipboard^=unnamedplus,unnamed

" Mappings
" ========

" Map the leader key to SPACE.
let mapleader="\<space>"

" Map ; to : for easier typing
nmap ; :

" Workaround for navigating folds
nmap j gj
nmap k gk

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$

" Redo
nnoremap U <C-r>

" Easier block indentation, keeps visual selection
vnoremap < <gv
vnoremap > >gv

" Clear search highlight after search.
nnoremap <C-N> :nohlsearch<CR>

" Replaces vim-commentary
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Run Find in files for word under cursor in vscode
nnoremap <silent> ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

" Run Find in files for word under cursor in vscode
nnoremap <silent> <leader>p <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>

" Plugin specific options
" =======================

" Auto Pairs
" ----------
let g:AutoPairsShortcutFastwrap='<M-e>'

" Unimpaired
" ----------
" Disable encodings and '[e' and ']e' for line swap
let g:unimpaired_mapping = {
\ 'encodings' : 0,
\ 'excludes' : { 'lineopes' : ['e']}
\ }

