return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { 
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
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
  },
  { "mfussenegger/nvim-dap" },
  { 
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" }
  },
  { "leoluz/nvim-dap-go" },
  { "rinx/nvim-dap-rego" }
  -- {"hrsh7th/cmp-nvim-lsp"},
  -- {"hrsh7th/cmp-buffer"},
  -- {"hrsh7th/cmp-path"},
  -- {"hrsh7th/cmp-cmdline"},
  -- {"hrsh7th/nvim-cmp"}
}
