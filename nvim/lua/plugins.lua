return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- { "edolphin-ydf/goimpl.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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
  -- { "github/copilot.vim" },
  { "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
    condition = function()
      local name = vim.api.nvim_buf_get_name(0)
      local filename = vim.fn.fnamemodify(name, ":t")

      if filename == ".env" or filename:match("^%.env") then
        return false
      end
      return true
    end,
  }
  -- {"hrsh7th/cmp-nvim-lsp"},
  -- {"hrsh7th/cmp-buffer"},
  -- {"hrsh7th/cmp-path"},
  -- {"hrsh7th/cmp-cmdline"},
  -- {"hrsh7th/nvim-cmp"}
}
