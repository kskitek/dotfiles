set nocompatible

" MOVEMENT

nnoremap j jzz
nnoremap k kzz
vmap < <gv
vmap > >gv
nnoremap H ^
nnoremap L $

" MISCLEANUOUS

let base15colorspace=256

" nrformats-=octal
set nrformats= " set nr format to decimal. Default is octal
" remove timeout for mode switching with ESC
set timeout ttimeout timeoutlen=999 ttimeoutlen=0

set tabstop=3 softtabstop=0 shiftwidth=4
set expandtab smarttab

set backspace=indent,eol,start

set noswapfile
set nobackup

" use system copy clipboard
" set clipboard=unnamed

" SEARCH

set wildmenu
set path=**
set wildignore+=node_modules/*,.git

set incsearch
set hlsearch

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif


" RANDOM SHORTCUTS
nmap ! :!
nnoremap <silent> <Leader>- :vertical resize +9<CR>
nnoremap <silent> <Leader>= :vertical resize -9<CR>

nmap <C-k> :make test
nmap <C-r> :make build run

" BUFFERS

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>
" see also CtrlPBuffer
set autowrite

" HL

set number relativenumber
set numberwidth=4

set cursorline
hi CursorColumn ctermbg=gray ctermfg=black
hi Cursor ctermbg=magenta ctermfg=magenta
hi CursorLine ctermbg=gray ctermfg=black
hi Visual cterm=reverse ctermbg=NONE
highlight OverLength cterm=reverse
match OverLength /\%89v.\+/

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <space> :nohlsearch<Bar>:echo<CR>

" PER FileType SETTINGS
augroup golang
    autocmd!
    packadd govim
    autocmd FileType go :TagbarToggle
    " autocmd FileType go TODO !find * -type f -name "*.go" | entr make test
augroup END

autocmd FileType markdown :TagbarToggle
autocmd BufWritePre,BufRead *.env.local :set filetype=sh

" PLUGINS

filetype plugin on
syntax on

packadd matchit

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 5
let g:netrw_winsize = 25
nmap <C-B> :Lexplore<CR>

" quickfix
map <F2> :cnext<CR>
map <S-F2> :cnext<CR>

" lightline
set laststatus=2

" ctrlP
nmap <Leader>b :CtrlPBuffer<CR>
nmap <C-E> :CtrlPBuffer<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" typescript-vim
let g:typescript_indent_disable = 1

" vim-commentary
vnoremap <C-x> :Commentary<CR>
nnoremap <C-x> :Commentary<CR>j

" govim
" minimal govim settings
set nocompatible
set nobackup
set nowritebackup
set noswapfile
" set mouse=a
" set ttymouse=sgr
set updatetime=500
" set balloondelay=250
" custom govim
" setlocal balloonexpr=GOVIMBalloonExpr()
setlocal omnifunc=GOVIMComplete
nmap <buffer> <Leader>h : <C-u>echo GOVIMHover()<CR>
" default mappings are overwriten in vim/after/ftplugin/go.vim

