set nocompatible              " be iMproved, required
filetype off                  " required

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
" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git Gutter
" Plugin 'jisaacks/GitGutter'
Plugin 'airblade/vim-gitgutter'

" Comment things out with commentary
Plugin 'tpope/vim-commentary'

" Make . command (Repeat) work with plugins like commentary
Plugin 'tpope/vim-repeat'

" Colour Scheme
" Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'

" Syntax checking
Plugin 'vim-syntastic/syntastic'

" Inserting closing brackets etc
Plugin 'Raimondi/delimitMate'

" Buffer navigation
Plugin 'jeetsukumaran/vim-buffergator'

" NerdTree
Plugin 'scrooloose/nerdtree'

" Surround Vim
Plugin 'tpope/vim-surround'

" Commenting out Code
Plugin 'scrooloose/nerdcommenter'

"Rails
Plugin 'tpope/vim-rails.git'

" Search Highlighting
Plugin 'inside/vim-search-pulse'

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

" enable 256 color support
" set t_Co=256
" if (has("termguicolors"))
 " set termguicolors
" endif
" set background=dark
" colorscheme solarized
colorscheme molokai

syntax enable " Turn on syntax highlighting
set hidden " Leave hidden buffers open
set history=100 "by default Vim saves your last 8 commands.  We can handle more
set number
set clipboard=unnamedplus
:au FocusLost * silent! wa
:set autowriteall

" default ident to 2 spaces
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" javascript 2 spaces
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab

" php 4 spaces
autocmd Filetype php setlocal ts=4 sw=4 sts=0 expandtab

" SYNTASTIC
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" eslint should be installed local to the project along with
" any plugins that are needed
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_puppet_puppetlint_args = "--no-80chars-check"

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Airline

let g:airline#extensions#tabline#enabled = 1

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <C-f> :NERDTreeFind<CR>
map <silent> <C-PageDown> :bnext<CR>
map <silent> <C-PageUp> :bprevious<CR>

" switch to previously opened buffer and close the one we just
" switched away from (does the equivelant of :bd but without destroying
" my split window)
nmap <leader>bd :b#<bar>bd#<CR>

" closes all buffers that aren't currently visible in
" window/split/tab
nnoremap <leader>bc :call CloseAllHiddenBuffers()<CR>

" Use f2 to toggle paste mode
set pastetoggle=<F2>

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
