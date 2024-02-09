return {
  {
    "sainnhe/gruvbox-material",
    cond = vim.g.vscode == nil,
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_sign_column = "bg0"
      vim.g.gruvbox_italicize_comments = 0
      vim.g.gruvbox_material_foreground = "original"

      vim.cmd("colorscheme gruvbox-material")
    end,
  },
  {
    "rose-pine/neovim",
    cond = vim.g.vscode == nil,
    name = "rose-pine",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        dark_variant = "main", -- "main" | "moon"
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "arturgoms/moonbow.nvim",
    cond = vim.g.vscode == nil,
    enabled = false,
    lazy = false,
    priority = 1000,
  },
  {
    'ribru17/bamboo.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }
      require('bamboo').load()
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "luisiacc/gruvbox-baby",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rose-pine")
    end
  },
}
