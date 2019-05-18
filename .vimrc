"Install plugged if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Load Plugins
call plug#begin('~/.vim/plugged')
"fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Colorscheme
Plug 'altercation/vim-colors-solarized' 

"git, aesthetics, marks shown on in gutter
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'mhinz/vim-signify'
Plug 'kshenoy/vim-signature'

"Language server
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-javascript'
Plug 'ryanolsonx/vim-lsp-typescript'

"javascript/typescript development
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'

"Markdown
Plug 'JamshedVesuna/vim-markdown-preview'
call plug#end()

"lsp configuration
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_enabled = 1

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')
let g:tagbar_autoclose = 0

"Config for signify
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

"Highlighting for GitGutter symbols
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
set tabstop=2
set shiftwidth=2
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

"fzf commands
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

"<TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"Javascript/typescript specific
autocmd FileType javascript,typescript nnoremap <buffer> <C-]> :LspDefinition<CR>
autocmd FileType javascript,typescript nnoremap <buffer> <C-^> :LspReferences<CR>
autocmd FileType javascript,typescript nnoremap <buffer> <C-g> :LspHover<CR>

"javascript linting on :make
autocmd FileType javascript setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
autocmd FileType javascript setlocal makeprg=eslint\ %\ -f\ compact\ --quiet
"typescript linting on :make
autocmd FileType typescript setlocal errorformat=ERROR:\ %f:%l:%c\ -\ %m
autocmd FileType typescript setlocal makeprg=tslint\ --quiet\ %\

autocmd QuickFixCmdPost [^l]* cwindow
