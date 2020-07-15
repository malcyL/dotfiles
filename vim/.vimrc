set nocompatible              " be iMproved, required
filetype off                  " required

" save information about files I open
set viminfo='100,n$HOME/.vim/files/info/viminfo

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" CtrlP
Plug 'kien/ctrlp.vim'

" Ack
Plug 'mileszs/ack.vim'

" Ag
Plug 'rking/ag.vim'

" LightLine
Plug 'itchyny/lightline.vim'

" Git Gutter
Plug 'airblade/vim-gitgutter'

" Comment things out with commentary
Plug 'tpope/vim-commentary'

" Make . command (Repeat) work with plugins like commentary
Plug 'tpope/vim-repeat'

" Colour Scheme
Plug 'flazz/vim-colorschemes'

" Syntax checking
Plug 'w0rp/ale'

" Inserting closing brackets etc
Plug 'Raimondi/delimitMate'

" NerdTree
Plug 'preservim/nerdtree'
" Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" NerdTree Git
" Plug 'Xuyuanp/nerdtree-git-plugin'
" This seems to have broken at the time of
" vundle -> plug and
" 'scrooloose/nerdtree' -> 'preservim/nerdtree'

" Surround Vim
Plug 'tpope/vim-surround'

" Commenting out Code
Plug 'scrooloose/nerdcommenter'

" Search Highlighting
Plug 'inside/vim-search-pulse'

" Vertical indent lines
" Plugin 'yggdroot/indentline'

" Display buffers in status bar
Plug 'bling/vim-bufferline'

" Close buffers without destroying windows
Plug 'moll/vim-bbye'

" Close all other buffers
Plug 'schickling/vim-bufonly'

" Use tag file to display current file structure
" Plugin 'majutsushi/tagbar'

" Auto update tags
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'

" Coloured brackets
Plug 'luochen1990/rainbow'

" Easy motion
Plug 'easymotion/vim-easymotion'

" Prettier - javascript code formatter
Plug 'prettier/vim-prettier'

" CoC https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim'

" Initialize plugin system
call plug#end()

" None plug config:

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

" javascript 2 spaces
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab

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
" nnoremap <leader>xa :BufOnly<CR>
" nmap <F8> :TagbarToggle<CR>
" nmap <leader>i :IndentLinesToggle<CR>:set invnumber<CR>
" nnoremap <bs> <c-^>

" Move visual selection
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" Coc Configuration

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.  nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
