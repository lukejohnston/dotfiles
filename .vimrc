set nocompatible " required for Vundle
filetype off " required for Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-syntastic/syntastic'

Plugin 'fatih/vim-go'

Plugin 'vimwiki/vimwiki'

Plugin 'derekwyatt/vim-scala'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-rooter'

call vundle#end()
filetype plugin indent on

syntax on
set number
set relativenumber
set smartcase
set mouse=a

autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

let mapleader="\\"
inoremap jj <esc>
nnoremap JJJJ <nop>
map L $
map H ^

" Make sure cursor is always centered on j/k moves
"set so=999

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Better way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"Syntastic
autocmd FileType go,scala let g:syntastic_aggregate_errors = 1
autocmd FileType go let g:syntastic_go_checkers = ["go", "govet", "golint"]
autocmd FileType go let g:syntastic_quiet_messages = { "type": "style" }
autocmd FileType go,scala nmap <leader>e :Errors<CR>
autocmd FileType go,scala nmap <leader>r :lclose<CR>
let g:syntastic_check_on_wq = 0

"vim-go
" au FileType go let $GOPATH = go#path#Detect()
autocmd FileType go nmap <leader>b <plug>(go-build)
autocmd FileType go nmap <leader>t <plug>(go-test)
autocmd FileType go nmap <leader>ga :GoAltnernate<cr>


" Allow copy and paste between vim instances
" copy the current visual to ~/.vbuf
vmap <leader>y :w! ~/.vbuf<cr>

" copy the current line to vbuf if no visual
nmap <leader>y :.w! ~/.vbuf<cr>

" paste the contents of the buffer file
nmap <leader>p :r ~/.vbuf<cr>

" Vimwiki options
let g:vimwiki_folding=''
au BufRead,BufNewFile *.wiki setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" NERDTree

" Open NERDTree if no file specified
" autocmd VimEnter * if !argc() | NERDTree | endif

let NERDTreeShowLineNumbers=1
let NERDTreeWinSize=41

map <leader>T :NERDTreeFind<cr>
nmap <leader>o :NERDTreeToggle<cr>

" Open NERDTree at the current file's directory
autocmd BufEnter * lcd %:p:h

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -c --exclude-standard --recurse-submodules']

" JS
au BufRead,BufNewFile *.js setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Markdown
let g:vim_markdown_folding_disabled = 1

" tmux perf things
"set lazyredraw
"set ttyfast

" ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

let g:rooter_silent_chdir = 1

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" always show signcolumns
set signcolumn=yes

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

:highlight Pmenu ctermbg=white guibg=white
