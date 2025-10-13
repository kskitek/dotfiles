" vim:fdm=marker:fdl=0

set nocompatible
set encoding=utf-8

" To open a fold type za or zR to open all folds.
" Remember to not put any settings you don't understand in your .vimrc.
" In case you don't understand what given setting does,
" type `:help <setting>` - vim has pretty good help :)

" In case something is fundamentally not working check if vim is linked.
" Next step is to comment out all experimental options and check your plugins.

"" EXPERIMENTAL {{{
set noequalalways

let g:netrw_keepdir = 0

" temporary disable trouble plugin

"" }}}
"" CONFIG {{{
nmap <silent> <leader>; yyq:p<CR>

"" }}}
"" CLIPBOARD {{{
" use system copy clipboard
set clipboard=unnamed,unnamedplus
vnoremap y "+y

"" }}}
"" BUFFERS {{{
set hidden

" see also CtrlPBuffer
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nmap <leader>x :bdelete<CR>
nmap <Leader>f :let @/=expand("%:t") <Bar> execute 'Lexplore' expand("%:h") <Bar> normal n<CR>

"" }}}
"" MOVEMENT {{{
" keep cursor vertically centered; use either jk mapping or scrolloff
" - jk mapping is slower but works regardles of filesize
" - scrolloff works only for files not longer than x
" nnoremap j jzz
" nnoremap k kzz
set scrolloff=9999
set sidescrolloff=10

vmap < <gv
vmap > >gv
nnoremap H ^
nnoremap L $
set backspace=indent,eol,start
set linebreak

"" }}}
"" SEARCH {{{
" TODO
" set wildmenu
" set path=**
" set wildignore+=node_modules/*,.git
" set wildmode=longest:full,full

" nmap <C-o> :find *
set incsearch hlsearch ignorecase smartcase

nnoremap <C-r> :%s/\<<C-r><C-w>\>/
" TODO
"nnoremap <C-h> :grep! <C-r><C-w> <CR>:copen<CR>

if executable('rg')
  set grepprg=rg\ --nogroup\ --nocolor\ --vimgrep\ $*
  let g:ctrlp_user_command = 'rg %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

"" }}}
"" COLORS and HIGHLIGHT {{{
set number relativenumber
set numberwidth=4

set cursorline
"set cursorcolumn
set colorcolumn=90
" hi CursorColumn ctermbg=gray ctermfg=black
" hi CursorLine ctermbg=lightgray ctermfg=black

highlight Normal ctermbg=NONE guibg=NONE
highlight NormalNC ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
" hi Cursor ctermbg=magenta ctermfg=magenta
" hi Visual cterm=reverse ctermbg=black
" hi Folded ctermbg=None ctermfg=lightgrey
" hi FoldColumn ctermbg=None ctermfg=lightgrey
"" highlight OverLength ctermbg=red
"" match OverLength /\%89v.\+/
"highlight ExtraWhitespace cterm=bold ctermfg=red
"2match ExtraWhitespace /\s\+$/
"set list listchars=tab:\ \ ,trail:·
"
"highlight Pmenu ctermbg=None ctermfg=white
"highlight PmenuSel ctermbg=magenta ctermfg=white
" PmenuSbar – scrollbar
" PmenuThumb – thumb of the scrollbar

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <space> :nohlsearch<Bar>:echo<CR>
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme tomorrow-night

"" }}}
"" QUICKFIX NAVIGATION {{{
" Quickfix list navigation
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" Location list navigation
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" Toggle quickfix window
function! ToggleQuickfix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction
nnoremap <leader>q :call ToggleQuickfix()<CR>

" Toggle location list window
function! ToggleLocationList()
  if empty(filter(getwininfo(), 'v:val.loclist'))
    lopen
  else
    lclose
  endif
endfunction
nnoremap <leader>l :call ToggleLocationList()<CR>

" Auto-open quickfix window when populated
augroup quickfix_auto_open
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" Quickfix window settings
autocmd FileType qf setlocal winheight=10
autocmd FileType qf set nobuflisted

"" }}}
"" FOLDING, WRAPPING, FORMATTING {{{
set foldcolumn=2
set foldmethod=syntax
set foldlevelstart=99
" This allows to fold only top level (functions)
set foldnestmax=1

set nowrap

set nrformats= " set nr format to decimal. Default is octal

set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab smarttab
set autoindent
set smartindent

"" }}}
"" MOUSE {{{
set mouse=a

"" }}}
"" BACKUP {{{
set nobackup noswapfile nowritebackup
set undofile undodir=/tmp/vim-undo undolevels=9999

"" }}}
"" PERFORMANCE {{{
" Do not redraw screen in the middle of a macro. Makes them complete faster.
set lazyredraw
" remove timeout for mode switching with ESC
set timeout ttimeout timeoutlen=999 ttimeoutlen=0

"" }}}
"" PLUGINS {{{

syntax on

filetype indent on
filetype plugin on

" this package improves search matchings. E.g. type % anywhere in the code
packadd matchit

"" netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
let g:netrw_altv = 1
" open directory of current file - just like :Sex but in left split
" nmap <C-G> :Lexplore `dirname %`<CR>
nmap <C-G> :Vexplore!<CR>
nmap <C-B> :Lexplore<CR>

"" }}}

"" LSP {{{
lua << EOF
local servers = {
  pyright = {},
  gopls = {},
  ts_ls = {},
  elmls = {},
}

for name, config in pairs(servers) do
  vim.lsp.config[name] = vim.tbl_extend('force', config, {
    cmd = { name },
    root_markers = { '.git' },
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap=true, silent=true, buffer=bufnr }

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    -- vim.keymap.set('n', '<C-q>', vim.diagnostic.setloclist, opts)
    -- vim.keymap.set('n', '<C-f>', vim.lsp.buf.format, opts)
  end,
})

vim.lsp.enable(vim.tbl_keys(servers))

vim.keymap.set('n', 'ge', function()
  local qf_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_open = true
      break
    end
  end

  if qf_open then
    vim.cmd('cclose')
  else
    vim.diagnostic.setqflist({
      open = true,
      severity = { min = vim.diagnostic.severity.WARN },
    })
  end
end, { desc = 'Show errors and warnings in quickfix list' })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    vim.diagnostic.setqflist({
      open = false,
      severity = { min = vim.diagnostic.severity.WARN },
    })
  end,
})

vim.keymap.set('n', '<c-e>', function()
  vim.diagnostic.open_float(nil, {
    scope = "line",
    focusable = true,
  })
end, { desc = 'Show diagnostics for current line' })
EOF

" format on save
autocmd BufWritePre *.js lua vim.lsp.buf.format()
autocmd BufWritePre *.ts lua vim.lsp.buf.format()
autocmd BufWritePre *.elm lua vim.lsp.buf.format()
autocmd BufWritePre *.py lua vim.lsp.buf.format()
autocmd BufWritePre *.go lua vim.lsp.buf.format()
autocmd BufWritePre *.java lua vim.lsp.buf.format()
autocmd BufWritePre *.kt lua vim.lsp.buf.format()
autocmd BufWritePre *.scala lua vim.lsp.buf.format()

"" }}}

"" lualine {{{

" lua require('lsp-status')
" lua require('lsp-status/diagnostics')

lua << END
require 'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename', 'diff'},
    lualine_c = {'diagnostics'},
    lualine_c = {},
    lualine_x = {'branch', 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END


"" }}}

"" telescope {{{{

lua << END
require('telescope').setup({
  defaults = {
    color_devicons = true,
    sorting_strategy = "ascending",
    borderchars = { "", "", "", "", "", "", "", "" },
    path_display = "smart",
    layout_strategy = "horizontal",
    layout_config = {
      width = 400,
      height = 100,
      prompt_position = "top",
    },
  }
})
END

nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>

nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap gi <cmd>Telescope lsp_implementations<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gt <cmd>Telescope lsp_type_definitions<cr>
nnoremap gs <cmd>Telescope lsp_document_symbols<cr>
" nnoremap ge <cmd>Telescope diagnostics<cr> -- use LSP instead

"" }}}

"" treesitter {{{
" lua require('nvim-treesitter')

"" }}}

"" git-blame {{{

let g:gitblame_enabled = 0
let g:gitblame_virtual_text_column = 70

"" }}}

"" }}}
