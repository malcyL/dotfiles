set nocompatible              " be iMproved, required
filetype off                  " required

" save information about files I open
set viminfo='100,n$HOME/.vim/files/info/viminfo

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" CtrlP
Plugin 'kien/ctrlp.vim'

" Ack
Plugin 'mileszs/ack.vim'

" Ag
Plugin 'rking/ag.vim'

" LightLine
Plugin 'itchyny/lightline.vim'

" Git Gutter
Plugin 'airblade/vim-gitgutter'

" Comment things out with commentary
Plugin 'tpope/vim-commentary'

" Make . command (Repeat) work with plugins like commentary
Plugin 'tpope/vim-repeat'

" Colour Scheme
Plugin 'flazz/vim-colorschemes'

" Syntax checking
Plugin 'w0rp/ale'

" Inserting closing brackets etc
Plugin 'Raimondi/delimitMate'

" NerdTree
Plugin 'scrooloose/nerdtree'

" NerdTree Git
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Surround Vim
Plugin 'tpope/vim-surround'

" Commenting out Code
Plugin 'scrooloose/nerdcommenter'

" Search Highlighting
Plugin 'inside/vim-search-pulse'

" Vertical indent lines
" Plugin 'yggdroot/indentline'

" Display buffers in status bar
Plugin 'bling/vim-bufferline'

" Close buffers without destroying windows
Plugin 'moll/vim-bbye'

" Close all other buffers
Plugin 'schickling/vim-bufonly'

" Use tag file to display current file structure
Plugin 'majutsushi/tagbar'

" Auto update tags
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'

" Coloured brackets
Plugin 'luochen1990/rainbow'

" Easy motion
Plugin 'easymotion/vim-easymotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" None vundle config:

colorscheme molokai

syntax enable " Turn on syntax highlighting

set hidden " Leave hidden buffers open
set history=100 "by default Vim saves your last 8 commands.  We can handle more
set number relativenumber
set clipboard=unnamedplus
:au FocusLost * silent! wa
:set autowriteall
" Use f2 to toggle paste mode
set pastetoggle=<F2>
" Automatically save file
autocmd FocusLost * silent! wa 
" Keep 5 lines below and above the cursor
set scrolloff=5 

command FormatJSON %!python -m json.tool

" default ident to 2 spaces
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" javascript 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab

" php 4 spaces
autocmd Filetype php setlocal ts=4 sw=4 sts=0 expandtab

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|node_modules',
  \ }

" ALE
let g:ale_pattern_options = {
\   '.*\.test\.js$': {'ale_enabled': 0},
\}
let g:ale_fixers = { 'javascript': ['eslint'], 'go': ['gofmt'] }

" Coloured Brackets
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['darkblue', 'darkyellow', 'darkcyan', 'darkmagenta'],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'tex': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'vim': {
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'css': 0,
\	}
\}

" LightLine
set laststatus=2

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['relativepath', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" Indentline
let g:indentLine_conceallevel = 1

" NERDTree
let NERDTreeQuitOnOpen = 0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Following two lines open NerdTree on startup if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | wincmd p | ene | endif

"
" Easy Motion
"

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"
" Key Mappings
"

map <C-A> <C-W>

nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>p :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>c :cclose<CR>
nmap <leader>q :Bdelete<CR>
nnoremap <leader>xa :BufOnly<CR>
nmap <F8> :TagbarToggle<CR>
nmap <leader>i :IndentLinesToggle<CR>:set invnumber<CR>
nnoremap <bs> <c-^>

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv'
vnoremap K :m '<-2<CR>gv=gv'
