" packadd govim
" autocmd FileType go packadd govim
" GOVIMQuickfixDiagnostics
" setlocal omnifunc=GOVIMComplete

setlocal autoindent

" set balloondelay=250
" custom govim
" setlocal balloonexpr=GOVIMBalloonExpr()

" TODO think about localleader instead of <buffer> <leader> - mby `
" nnoremap <buffer> <silent> <leader>' :hide GOVIMGoToDef<CR>
" nnoremap <buffer> <silent> <leader>; :hide GOVIMGoToPrevDef<CR>
nmap <buffer> <leader>h :<C-u>echo GOVIMHover()<CR>
nmap <buffer> <leader>c :copen<CR>:set nobuflisted<CR>\\
" autocmd FileType go :TagbarToggle
" autocmd FileType go TODO !find * -type f -name "*_test.go" | entr make test
nmap <C-h> "yyiw:lvimgrep <C-r>y **/*.go<CR>:lopen<CR><C-w><C-w>
nmap <C-g> "yyiwmygg/package<CR>w"pyiw'y:lvimgrep <C-r>p.<C-r>y **/*.go<CR>:lopen<CR><C-w><C-w>

ab gh github.com
ab gl gitlab.com
ab sout fmt.Println
