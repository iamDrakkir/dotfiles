return {
  {
    "sainnhe/gruvbox-material",
    cond = vim.g.vscode == nil,
    enabled = true,
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

      -- vim.cmd("colorscheme gruvbox-material")
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
        dark_variant = "main",
        styles = {
          bold = true,
          italic = false,
          transparency = false,
        },
      })
      -- vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme tokyonight-night")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        color_overrides = {
          mocha = {
            base = "#191724",
          },
        }
      }
      vim.cmd("colorscheme catppuccin")
    end
  },
}
