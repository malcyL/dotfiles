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
Plugin 'yggdroot/indentline'

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
set number
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

" javascript 2 spaces
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

" LightLine
set laststatus=2

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
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
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Following two lines open NerdTree on startup if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | wincmd p | ene | endif

" Key Mappings

map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <C-f> :NERDTreeFind<CR>
map <silent> <C-PageDown> :bnext<CR>
map <silent> <C-PageUp> :bprevious<CR>
map <silent> <C-c> :cclose<CR>
map <silent> <C-q> :b#<bar>bd#<CR>
map <silent> <C-b> :CtrlPBuffer<CR>
map <silent> <C-i> :IndentLinesToggle<CR>:set invnumber<CR>

" Nice mapping for switching buffers.
" Disable while trying :CtrlPBuffer
"nmap <leader>b :buffers<CR>:buf 

" closes all buffers that aren't currently visible in
" window/split/tab
nnoremap <leader>bc :call CloseAllHiddenBuffers()<CR>

func! s:buf_compare(b1, b2) abort
  let b1_visible = -1 == index(tabpagebuflist(), a:b1)
  let b2_visible = -1 == index(tabpagebuflist(), a:b2)
  "prefer loaded and NON-visible buffers
  if bufloaded(a:b1)
    if bufloaded(a:b2)
      return b2_visible ? !b1_visible : -1
    endif
    return 0
  endif
  return !bufloaded(a:b2) ? 0 : 1
endf

function! CloseAllHiddenBuffers()
  " list of *all* buffer numbers including hidden ones
  let l:buffers = filter(range(1, bufnr('$')),
              \ 'buflisted(v:val)
              \  && ("" ==# getbufvar(v:val, "&buftype") || "help" ==# getbufvar(v:val, "&buftype"))
              \ ')
  call sort(l:buffers, '<sid>buf_compare')
  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
