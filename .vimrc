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
Plug 'romainl/flattened'

"indent lines
Plug 'Yggdroot/indentLine'

"git
Plug 'tpope/vim-fugitive'


"git diff in gutter
Plug 'mhinz/vim-signify'
"marks in gutter
Plug 'kshenoy/vim-signature'

"Language server
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'neovimhaskell/haskell-vim'

"Markdown and latex
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'lervag/vimtex'

"Vimwiki"
Plug 'vimwiki/vimwiki'
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
colorscheme flattened_dark
"ctermbg=none

syntax on
filetype plugin indent on
let g:haskell_classic_highlighting=1

"Highlighting for GitGutter symbols
highlight SignifySignAdd ctermbg=none ctermfg=64
highlight SignifySignChange ctermbg=none ctermfg=136
highlight SignifySignDelete ctermbg=none ctermfg=160

 "Make gutter clear
 highlight clear SignColumn

let g:tex_conceal = ""

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
set shiftwidth=2
set expandtab
set smarttab
set laststatus=2

set scrolloff=7

set conceallevel=0

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
autocmd FileType haskell nnoremap <buffer> <C-]> :LspDefinition<CR>
autocmd FileType haskell nnoremap <buffer> <C-^> :LspReferences<CR>
autocmd FileType haskell nnoremap <buffer> <C-g> :LspHover<CR>
autocmd FileType haskell nnoremap <buffer> K :LspHover<CR>

"javascript linting on :make
autocmd FileType javascript setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
autocmd FileType javascript setlocal makeprg=eslint\ %\ -f\ compact\ --quiet

"typescript linting on :make
autocmd FileType typescript setlocal errorformat=ERROR:\ %f:%l:%c\ -\ %m
autocmd FileType typescript setlocal makeprg=tslint\ --quiet\ %\

autocmd QuickFixCmdPost [^l]* cwindow

au User lsp_setup call lsp#register_server({
    \ 'name': 'ghcide',
    \ 'cmd': {server_info->['ghcide', '--lsp']},
    \ 'whitelist': ['haskell'],
    \ })

filetype plugin on
set omnifunc=syntaxcomplete#Complete


let g:vimtex_view_general_viewer = 'zathura'

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 
