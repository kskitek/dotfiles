return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "edolphin-ydf/goimpl.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- TODO check if you want it. See https://github.com/nvim-neotest/neotest
  -- { "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter"
  --   }
  -- },
  -- TODO setup it
  -- { "olimorris/codecompanion.nvim" },
  { "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  { "f-person/git-blame.nvim" },
  { "github/copilot.vim" },
}
