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

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep\ $*
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
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
hi Cursor ctermbg=magenta ctermfg=magenta
hi Visual cterm=reverse ctermbg=black
hi Folded ctermbg=None ctermfg=lightgrey
hi FoldColumn ctermbg=None ctermfg=lightgrey
" highlight OverLength ctermbg=red
" match OverLength /\%89v.\+/
highlight ExtraWhitespace cterm=bold ctermfg=red
2match ExtraWhitespace /\s\+$/
set list listchars=tab:\ \ ,trail:·

highlight Pmenu ctermbg=None ctermfg=white
highlight PmenuSel ctermbg=magenta ctermfg=white
" PmenuSbar – scrollbar
" PmenuThumb – thumb of the scrollbar

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <space> :nohlsearch<Bar>:echo<CR>

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
" nmap <C-B> :Lexplore `dirname %`<CR>
nmap <C-B> :Lexplore<CR>
" nmap <C-B> :Vexplore<CR>

"" }}}

"" LSP {{{
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<C-r>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-q>', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<C-f>', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'gopls', 'tsserver', 'elmls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" format on save
autocmd BufWritePre *.js lua vim.lsp.buf.format()
autocmd BufWritePre *.ts lua vim.lsp.buf.format()
autocmd BufWritePre *.elm lua vim.lsp.buf.format()
autocmd BufWritePre *.py lua vim.lsp.buf.format()
autocmd BufWritePre *.go lua vim.lsp.buf.format()

"" }}}

"" lualine {{{

" lua require('lsp-status')
" lua require('lsp-status/diagnostics')

lua << END
require'lualine'.setup {
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
lua require('telescope')
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>


nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap gi <cmd>Telescope lsp_implementations<cr>
nnoremap gd <cmd>Telescope lsp_definitions<cr>
nnoremap gt <cmd>Telescope lsp_type_definitions<cr>
nnoremap gs <cmd>Telescope lsp_document_symbols<cr>
nnoremap ge <cmd>Telescope diagnostics<cr>

"" }}}

"" treesitter {{{
" lua require('nvim-treesitter')

"" }}}

"" trouble {{{
" lua require("trouble")

"" }}}

"" git-blame {{{

let g:gitblame_enabled = 0
let g:gitblame_virtual_text_column = 50

"" }}}

"" }}}
