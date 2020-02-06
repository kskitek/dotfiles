" packadd govim
" autocmd FileType go packadd govim

setlocal autoindent
setlocal foldmethod=syntax
setlocal foldlevel=0

set updatetime=500
set balloondelay=250
" setlocal balloonexpr=GOVIMBalloonExpr()

" TODO think about localleader instead of <buffer> <leader> - mby `
" nnoremap <buffer> <silent> <leader>' :hide GOVIMGoToDef<CR>
" nnoremap <buffer> <silent> <leader>; :hide GOVIMGoToPrevDef<CR>
nmap <buffer> <localleader>q :<C-u>echo GOVIMHover()<CR>
nmap <buffer> <leader>c :copen<CR>:set nobuflisted<CR>\\
" autocmd FileType go :TagbarToggle
" autocmd FileType go TODO !find * -type f -name "*_test.go" | entr make test
nmap <C-h> "yyiw:lgrep <C-r>y **/*.go<CR>:lopen<CR><C-w><C-w>
nmap <C-g> "yyiwmygg/package<CR>w"pyiw'y:lgrep <C-r>p.<C-r>y **/*.go<CR>:lopen<CR><C-w><C-w>
nmap <leader>f /func (?:\(.*\))? ()<left>

ab sout fmt.Println

if has("patch-8.1.1904")
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif
