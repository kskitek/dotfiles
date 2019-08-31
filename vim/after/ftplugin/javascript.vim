let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
" let b:ale_fixers = ['prettier', 'eslint']
let b:ale_completion_enabled = 1

let g:ale_sign_column_always = 1
let g:ale_open_list = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
