" movEMENT

nnoremap j jzz
nnoremap k kzz

" MISCLEANUOUS

" nrformats-=octal
set nrformats= " set nr format to decimal. Default is octal
" remove timeout for mode switching with ESC
set timeout ttimeout timeoutlen=1000 ttimeoutlen=0

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

set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" PLUGINS

filetype plugin on
syntax on

" lightline
set laststatus=2

" ctrlP
nmap <Leader>b :CtrlPBuffer<CR>
nmap <C-E> :CtrlPBuffer<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>
autocmd FileType go :TagbarToggle
autocmd FileType markdown :TagbarToggle
