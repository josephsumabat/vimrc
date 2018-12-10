if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plug 'altercation/vim-colors-solarized' 
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'Shougo/neocomplete.vim'
Plug 'majutsushi/tagbar'
Plug 'hushicai/tagbar-javascript.vim'
Plug 'mhinz/vim-signify'
Plug 'w0rp/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-easytags'
call plug#end()

" Neocomplete autostart
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:tagbar_autoclose = 0

let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }

"let g:easytags_languages = {
"\   'javascript': {
"\       'cmd': 'es-ctags',
"
"\       'recurse_flag': ''
"\   }
"\}

"" Config for signify
let g:signify_vcs_list = ['git']
let g:signify_sign_delete_first_line = '_'
let g:signify_sign_change = '~'
let g:signify_sign_changedelete = '~_'
let g:signify_sign_show_count = 0



 "solarized theme
syntax enable
let g:solarized_termtrans=1
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

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

set wildmode=longest,list,full
set wildmenu
set ignorecase
set smartcase

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

command W w
command Wq wq

" moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"au filetype cc nnoremap <
"
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg  --line-number --no-heading --color=never '.shellescape(<q-args>), 0,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
let mapleader = " "

nnoremap <leader><tab> :Buffer<CR>
nnoremap <leader>s :FZF<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>x :bdelete<CR>

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
