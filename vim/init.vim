call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

Plug 'itchyny/lightline.vim'

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'neoclide/coc.nvim'

Plug 'ctrlpvim/ctrlp.vim'

"Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-fugitive'
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
"Plug 'neovim/nvim-lspconfig'

Plug 'tpope/vim-eunuch'
Plug 'bling/vim-bufferline'

Plug 'vim-test/vim-test'

Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'

"Plug 'gyim/vim-boxdraw'
"Plug 'prettier/vim-prettier', {
"  \ 'do': 'npm install',
"  \ 'for': ['javascript'] }
call plug#end()

" ========= NERD Tree start =========

nmap <C-n> :NERDTreeToggle<CR>


function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

autocmd BufEnter * call SyncTree()

" ========= NERD Tree end =========


" ========= coc settings start ========

let g:coc_global_extensions = [ 
            \ 'coc-snippets', 
            \ 'coc-pairs', 
            \ 'coc-tsserver', 
            \  'coc-eslint', 
            \  'coc-prettier', 
            \  'coc-omnisharp', 
            \  'coc-json', 
            \  'coc-sql', 
            \  'coc-html', 
            \  'coc-db' 
            \ ]

" NOTE: For XAML files, in vim you can run :setf xml
" and this will treat it as an xml file and will show coloring which makes it easier to read.

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" ========= coc settings end ========

" ========= ALE settings start ========
let g:ale_linter = {
      \ 'cs' : ['OmniSharp']
      \}
" ========= ALE settings end ========


" =============== OmniSharp settings start===============
" OmniSharp won't work without this setting
filetype plugin on

" Use Roslyin and also better performance than HTTP
let g:OmniSharp_server_stdio = 1
let g:omnicomplete_fetch_full_documentation = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 30

" this will make it so any subsequent C# files that you open are using the same solution and you aren't prompted again (so you better choose the right solution the first time around :) )
let g:OmniSharp_autoselect_existing_sln = 1

let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [1],
\ 'border': [1]
\}

let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 3

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}
" =============== OmniSharp settings end=================


" ======== pathogen setting start ========

" ======== pathogen setting end ==========


" ========= airline settings start ======================

" enable powerline fonts
let g:airline_powerline_fonts = 1

" Switch to your current theme
"let g:airline_theme = 'powerlineish'
"let g:airline_theme='badwolf'
let g:airline_theme='base16'

" Always show tabs
set showtabline=2
set bg=dark

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
"
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
"
let g:airline#extensions#tabline#enabled = 1

" show branch information
let g:airline#extensions#branch#enabled = 1
" ========= airline settings end ========================


" ========= ctrlp settings start =========

set runtimepath^=~/AppData/Local/nvim/plugged/ctrlp.vim

" ========= ctrlp settings end =========

set shell=powershell shellquote=( shellpipe=\| shellredir=> shellxquote=
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command

colorscheme gruvbox

set colorcolumn=81

let mapleader = ";"

inoremap kj <ESC>

vnoremap <leader><C-c> "*y 
nnoremap <leader><C-v> "*p


" auto reload the file when buffer / focus changed
au FocusGained,BufEnter * :silent! !

" auto save the file
au FocusLost,WinLeave * :silent! w

" show line numbers
set nu rnu

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" no wrapping
set nowrap

" all utf-8
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

set showmode

set showcmd

set ruler

"no backup files
set nobackup

"no swap files
set noswapfile

" change to current file's directory
set autochdir

" Highlight search results when using /
set hlsearch

set showmatch

" Show white spaces a
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
set list

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500


set smartcase
set smartindent

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4

"set shell=powershell.exe


" Deal with unwanted white spaces (show them in red)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" fix colors
"set t_Co=256

syntax on


nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

