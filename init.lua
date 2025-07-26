require("config.lazy").setup({}, {
  checker = {
    enabled = false,
  },
})

vim.cmd("source ~/.dotfiles/init.vim")
