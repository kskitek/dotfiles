setlocal autoindent
setlocal foldmethod=syntax
setlocal foldlevel=0

set updatetime=500
set balloondelay=250

call govim#config#Set("ExperimentalProgressPopups", 1)
call govim#config#Set("FormatOnSave", "goimports-gofmt")

nnoremap <buffer> gd :hide GOVIMGoToDef<CR>
nnoremap <buffer> gb :hide GOVIMGoToPrevDef<CR>
nnoremap <buffer> rn :GOVIMRename<CR>
nnoremap <buffer> tst :GOVIMGoTest<CR>
nnoremap <buffer> imp :GOVIMImplements<CR>
nnoremap <buffer> ref :GOVIMReferences<CR>

nmap <buffer> <leader>q :echo GOVIMHover()<CR>

nmap <buffer> <leader>c :copen<CR>:set nobuflisted<CR>\\
" autocmd FileType go :TagbarToggle
" autocmd FileType go TODO !find * -type f -name "*_test.go" | entr make test

command! Cnext try | cbelow | catch | cabove 9999 | catch | endtry
nnoremap <leader>m :Cnext<CR>

if has("patch-8.1.1904")
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif

