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
set foldcolumn=2

set linebreak

set showcmd " TODO does not work with COC
set hidden

" delve experimental mappings
" start debugger
nmap <silent> <leader>s :let p=test<CR>system("dlv exec p --headless --listen=:2345 --log --accept-multiclient > /tmp/$(date +%s)&"<CR>:echo "Started at :2345"<CR>
" set breakpoint
" nmap <silent> <leader>d !dlv connect --init f
sign define delve_breakpoint text=●
" nmap <silent> <leader>D

"" }}}
"" CLIPBOARD {{{
" use system copy clipboard
set clipboard=unnamed,unnamedplus
vnoremap y "+y
" vnoremap d "+d

"" }}}
"" MOVEMENT {{{

" nnoremap j jzz
" nnoremap k kzz
set scrolloff=999

vmap < <gv
vmap > >gv
nnoremap H ^
nnoremap L $

" Make [[ and ]] work even if the { is not in the first column
" nnoremap <silent> [[ :call search('^\S\@=.*{\s*$', 'besW')<CR>
" nnoremap <silent> ]] :call search('^\S\@=.*{\s*$', 'esW')<CR>

"" }}}
"" MISCLEANUOUS {{{
set backspace=indent,eol,start

set nobackup noswapfile nowritebackup
set undofile undodir=/tmp/vim-undo undolevels=9999

"" }}}
"" PERFORMANCE {{{
" Do not redraw screen in the middle of a macro. Makes them complete faster.
set lazyredraw
" remove timeout for mode switching with ESC
set timeout ttimeout timeoutlen=999 ttimeoutlen=0
set ttyfast
"" }}}
"" SEARCH {{{

set wildmenu
set path=**
set wildignore+=node_modules/*,.git
set wildmode=longest:full,full

nmap <C-o> :find *

set incsearch hlsearch ignorecase smartcase

" when searching with lgrep jump with below. <C-h> or <C-g> defined it ft section
nmap <silent> <leader>[ :lprevious<CR>
nmap <silent> <leader>] :lnext<CR>
nmap <C-s> :%s/\<<C-r><C-w>\>/
nmap <silent> <C-h> :lgrep <C-r><C-w> ./**<CR>:lopen<CR>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep\ $*
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif


"" }}}
"" RANDOM SHORTCUTS {{{
nmap ! :!
" when playing with .vimrc this one is usefull to apply command from current line
nmap <leader>; yyq:p<CR>
" nnoremap <leader>e :exe getline(line('.'))<cr>

nnoremap <silent> <Leader>- :vertical resize +9<CR>
nnoremap <silent> <Leader>= :vertical resize -9<CR>

vnoremap <leader>d c<c-r>=system('base64 --decode', @")<cr><esc>gv<left>
" vnoremap <leader>e c<c-r>=system('base64 -w 0', @")<cr><esc>gv
vnoremap <leader>e c<c-r>=system('base64', @")<cr><BS><esc>gv<left>

" nmap <C-k> :make test
" nmap <C-j> :make build run
" inoremap <Nul> <C-x><C-o>
inoremap <C-f> <C-x><C-f>

nmap <C-k> ddkP
nmap <C-j> ddp

"" }}}
"" BUFFERS {{{

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap <C-w>x :bdelete<CR>
" see also CtrlPBuffer
set noequalalways

"" }}}
"" COLORS and HIGHLIGHT {{{

set t_Co=256
colorscheme pencil
if $KITTY_SCHEME == "light"
  set background=light
else
  set background=dark
endif

set number relativenumber
set numberwidth=4

set cursorline
set cursorcolumn
set colorcolumn=90
hi CursorColumn ctermbg=lightgray ctermfg=black
hi CursorLine ctermbg=lightgray ctermfg=black
hi Cursor ctermbg=magenta ctermfg=magenta
hi Visual cterm=reverse ctermbg=black
highlight OverLength ctermbg=red
match OverLength /\%89v.\+/
highlight ExtraWhitespace cterm=bold ctermfg=red
2match ExtraWhitespace /\s\+$/
set list listchars=tab:\ \ ,trail:·

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <space> :nohlsearch<Bar>:echo<CR>

"" }}}
"" FOLDING, WRAPPING, FORMATTING {{{
set foldmethod=syntax
set foldlevelstart=99
" This allows to fold only top level (functions)
set foldnestmax=1

set nowrap

" nrformats-=octal
set nrformats= " set nr format to decimal. Default is octal

set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab smarttab autoindent

"" }}}
"" FileType FT SETTINGS {{{

" markdown
" autocmd FileType markdown :set spell
autocmd BufWritePre,BufRead *.env.local :set filetype=sh

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent

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

" fern {{{
nmap <C-B> :Fern . -drawer -toggle <CR>
let g:fern#disable_viewer_hide_cursor = 1
" }}}

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
" nmap <Leader>b :CtrlPBuffer<CR>
nmap <C-E> :CtrlPBuffer<CR>
nmap <S-P> :CtrlP ./<CR>
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

"" vim-markdown {{{
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 2
"" }}}

"" simplenote-vim {{{
let g:SimplenoteUsername = "krzysztof.skitek@gmail.com"
let g:SimplenoteSingleWindow = 1
let g:SimplenoteNoteFormat = "[%T] %N%>[%D]"
"" }}}

"" }}}
"" {{{ ABBREVIATIONS
iab <expr> dts strftime("%c")
"" }}}
" {{{ PRESENTATION MODE
nmap <silent> <leader>t :.!figlet -f small<CR>
nmap <silent> <leader>b :.!toilet -f term -F border<CR>


nmap <silent> <F5> :call ToggleStatusLine()<CR>
nmap <silent> <F3> :call FindExecuteCommand()<CR>

let s:status=2
function! ToggleStatusLine()
  set relativenumber! number! showmode! showcmd! hidden! list!
  " set ruler!
  if s:status == 2
    set laststatus=0
    set nospell
    syntax off
    let s:status=0
  else
    set laststatus=2
    set spell
    syntax on
    let s:status=2
  endif
endfunction

function! FindExecuteCommand()
  let line = search('\S*!'.'!:.*')
  if line > 0
    let command = substitute(getline(line), "\S*!"."!:*", "", "")
    execute "silent !". command
    execute "normal gg0"
    redraw
  endif
endfunction
"" }}}
