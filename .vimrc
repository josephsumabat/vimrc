call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/neocomplete.vim'
Plug 'majutsushi/tagbar'
Plug 'hushicai/tagbar-javascript.vim'
Plug 'mhinz/vim-signify'
Plug 'w0rp/ale'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
call plug#end()

" NERDtree autostart
autocmd VimEnter * NERDTree

" Neocomplete autostart
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:tagbar_autoclose = 0

let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }

let g:easytags_languages = {
\   'javascript': {
\       'cmd': 'es-ctags',
\       'recurse_flag': ''
\   }
\}
"" Config for signify
let g:signify_vcs_list = ['git']
let g:signify_sign_delete_first_line = '_'
let g:signify_sign_change = '~'
let g:signify_sign_changedelete = '~_'
let g:signify_sign_show_count = 0

 "" Highlighting for GitGutter symbols
 highlight SignifySignAdd ctermbg=none ctermfg=64
 highlight SignifySignChange ctermbg=none ctermfg=136
 highlight SignifySignDelete ctermbg=none ctermfg=160

 "Make gutter clear
 highlight clear SignColumn


let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'readonly', 'filename' ],
      \     [ 'gitbranch', 'gitinfo' ],
      \   ],
      \   'right': [
      \     [ 'warnings' ],
      \     [ 'lineinfo' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ],
      \   ],
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs', 'buffers' ] ],
      \   'right': [ [ 'close' ] ],
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum' ],
      \   'inactive': [ 'tabnum' ],
      \ },
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 1,
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \ },
      \ 'component': {
      \   'lineinfo': '%l/%L:%3v',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'gitinfo': 'LightLineGitInfo',
      \   'warnings': 'LightLineWarnings',
      \ },
      \ }

set relativenumber
set number

syntax on

set wildmode=longest,list,full
set wildmenu
set ignorecase

set number
set relativenumber
set ruler
set showcmd

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set laststatus=2

set scrolloff=7

set cursorline
hi clear CursorLine
hi CursorLine cterm=underline
set showtabline=2

" moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"au filetype cc nnoremap <

let mapleader = " "
nnoremap <leader><tab> :bnext<CR>

"syntax based folding
"set foldmethod=syntax
"set foldlevelstart=1
"
"let javaScript_fold=1         " JavaScript
"let perl_fold=1               " Perl
"let php_folding=1             " PHP
"let r_syntax_folding=1        " R
"let ruby_fold=1               " Ruby
"let sh_fold_enabled=1         " sh
"let vimsyn_folding='af'       " Vim script
"let xml_syntax_folding=1      " XML