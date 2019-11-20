" vim:fdm=marker:fdl=0

set nocompatible
set encoding=utf-8

" To open a fold type za or zR to open all folds.
" Remember to not put any settings you don't understand in your .vimrc.
" In case you don't understand what given setting does, type `:help
" <setting>` - vim has pretty good help.

" In case something is fundamentally not working check if vim is linked.
" Next step is to comment out all experimental options.

"" EXPERIMENTAL {{{

nmap <C-t> !git pull<CR>

" set statusline=%=%m\ %c\ %P\ %f\

set showcmd
" set formatoptions+=t
noremap <leader><leader> <C-W><C-w>

" delve experimental mappings
" start debugger
nmap <silent> <leader>s :let p=test<CR>system("dlv exec p --headless --listen=:2345 --log --accept-multiclient > /tmp/$(date +%s)&"<CR>:echo "Started at :2345"<CR>
" set breakpoint
" nmap <silent> <leader>d !dlv connect --init f
sign define delve_breakpoint text=●
" nmap <silent> <leader>D

"" }}}
"" CLIPBOARD {{{
set clipboard=unnamedplus
vnoremap y "+y
" vnoremap d "+d

"" }}}
"" MOVEMENT {{{

nnoremap j jzz
nnoremap k kzz
vmap < <gv
vmap > >gv
nnoremap H ^
nnoremap L $
" Make [[ and ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{\s*$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{\s*$', 'esW')<CR>

"" }}}
"" MISCLEANUOUS {{{

" nrformats-=octal
set nrformats= " set nr format to decimal. Default is octal
" remove timeout for mode switching with ESC
set timeout ttimeout timeoutlen=999 ttimeoutlen=0
set ttyfast

set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab smarttab

set nowrap

set backspace=indent,eol,start

set noswapfile
set nobackup

" use system copy clipboard
" set clipboard=unnamed

"" }}}
"" SEARCH {{{

set wildmenu
set path=**
set wildignore+=node_modules/*,.git
set wildmode=longest:full,full

set incsearch
set hlsearch
set ignorecase
set smartcase

" when searching with lvimgrep jump with below. <C-h> or <C-g> defined it ft section asd
nmap <silent> <leader>[ :lprevious<CR>
nmap <silent> <leader>] :lnext<CR>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif


"" }}}
"" RANDOM SHORTCUTS {{{
nmap ! :!
" when playing with .vimrc this one is usefull to apply command from current line and 
nmap <leader>; yy:<C-f>p<CR>
nnoremap <silent> <Leader>- :vertical resize +9<CR>
nnoremap <silent> <Leader>= :vertical resize -9<CR>

vnoremap <leader>d c<c-r>=system('base64 --decode', @")<cr><esc>gv
vnoremap <leader>e c<c-r>=system('base64 -w 0', @")<cr><esc>gv

" nmap <C-k> :make test
" nmap <C-j> :make build run
inoremap <Nul> <C-x><C-o>
inoremap <C-f> <C-x><C-f>

nmap <C-k> ddkP
nmap <c-j> ddp

"" }}}
"" BUFFERS {{{

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>
" see also CtrlPBuffer
set noequalalways

"" }}}
"" COLORS and HL {{{

set t_Co=256
colorscheme pencil
" let scheme = $KITTY_SCHEME
let background = $KITTY_SCHEME
set background=dark

set number relativenumber
set numberwidth=4

set cursorline
set cursorcolumn
set colorcolumn=90
hi CursorColumn ctermbg=gray ctermfg=black
hi CursorLine ctermbg=gray ctermfg=black
hi Cursor ctermbg=magenta ctermfg=magenta
hi Visual cterm=reverse ctermbg=NONE
highlight OverLength ctermbg=red
match OverLength /\%89v.\+/
highlight ExtraWhitespace cterm=bold ctermfg=red
2match ExtraWhitespace /\s\+$/
set list listchars=tab:\ \ ,trail:·
autocmd InsertEnter * :set cursorline!
autocmd InsertLeave * :set cursorline!

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <space> :nohlsearch<Bar>:echo<CR>

"" }}}
"" FOLDING {{{
set foldmethod=syntax
set foldlevelstart=99
" This allows to fold only top level (functions)
set foldnestmax=1
" set foldmethod=indent
" set foldclose=all

"" }}}
"" LINE WRAPPING {{{
" set textwidth=90
" set wrap
" automatically wrap
"" }}}
"" FileType FT SETTINGS {{{
autocmd FileType markdown :TagbarToggle
autocmd FileType markdown :set spell
autocmd BufWritePre,BufRead *.env.local :set filetype=sh

"" }}}
"" PLUGINS {{{

filetype plugin indent on
syntax on

" this package improves search matchings. E.g. type % anywhere in the code
packadd matchit

"" spellchecker {{{
" set spell
set spelllang=en_gb
nmap <leader>en :set spelllang=en_gb<CR>
nmap <leader>pl :set spelllang=pl<CR>
"" }}}

" netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
" open directory of current file - just like :Sex but in left split
" nmap <C-B> :Lexplore `dirname %`<CR>
nmap <C-B> :Lexplore<CR>
"" }}}

"" quickfix {{{
map <F2> :cnext<CR>
map <S-F2> :cnext<CR>
"" }}}

"" lightline
set laststatus=2

"" ctrlP {{{
nmap <Leader>b :CtrlPBuffer<CR>
nmap <C-E> :CtrlPBuffer<CR>
"" }}}

"" tagbar {{{
nmap <F8> :TagbarToggle<CR>
"" }}}

"" typescript-vim {{{
let g:typescript_indent_disable = 1
"" }}}

"" vim-commentary {{{
vnoremap <C-x> :Commentary<CR>
nnoremap <C-x> :Commentary<CR>j
"" }}}

"" govim {{{
" minimal govim settings
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set mouse=a
set ttymouse=sgr
set updatetime=500
" default mappings are overwriten in vim/after/ftplugin/go.vim
"" }}}

"" vim-delve {{{
let g:delve_breakpoint_sign="⛔️"
" ❗️
"" }}}

"" hudigraphs {{{
source ~/.dotfiles/vim/pack/plugins/hudigraphs_utf8.vim
inoremap <expr>  <C-K>   HUDG_GetDigraph()
"" }}}

"" }}}
