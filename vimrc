set nocompatible

" MOVEMENT

nnoremap j jzz
nnoremap k kzz

" MISCLEANUOUS

" nrformats-=octal
set nrformats= " set nr format to decimal. Default is octal
" remove timeout for mode switching with ESC
set timeout ttimeout timeoutlen=1000 ttimeoutlen=0

set tabstop=4 softtabstop=0 shiftwidth=4
set expandtab smarttab

set backspace=indent,eol,start

set noswapfile
set nobackup

" use system copy clipboard
set clipboard=unnamed

" SEARCH

set wildmenu
set path=**
set wildignore+=node_modules/*,.git


" RANDOM SHORTCUTS
nmap ! :!

" BUFFERS

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>
" see also CtrlPBuffer
set autowrite

" HL AND SEARCH

set number relativenumber
set numberwidth=5
set colorcolumn=90,110
"let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=darkgray guibg=darkgray

set cursorline
hi CursorColumn cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white

set incsearch
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" PER FileType SETTINGS
autocmd FileType go :TagbarToggle
autocmd FileType markdown :TagbarToggle
autocmd BufWritePre,BufRead *.env.local :set filetype=sh

" PLUGINS

filetype plugin on
syntax on

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
nmap <C-B> :Lexplore<CR>

" lightline
set laststatus=2

" ctrlP
nmap <Leader>b :CtrlPBuffer<CR>
nmap <C-E> :CtrlPBuffer<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" typescript-vim
let g:typescript_indent_disable = 1

let base16colorspace=256
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif
