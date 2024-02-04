return {
  {
    "ja-ford/delaytrain.nvim",
    enabled = false,
    cond = vim.g.vscode == nil,
    event = "bufreadpost",
    opts = {
      grace_period = 5,
    },
  },
  {
    "m4xshen/hardtime.nvim",
    event = "bufReadPost",
    enabled = false,
    opts = {
      max_time = 1000,
      max_count = 5,
      disable_mouse = false,
      hint = true,
      allow_different_key = false,
      resetting_keys = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "c", "d", "x", "X", "p", "P" },
      restricted_keys = { "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" },
      hint_keys = { "k", "j", "^", "$", "a", "i", "d", "y", "c", "l" },
      disabled_keys = {},
      disabled_filetypes = { "telescope", "qf", "netrw", "NvimTree", "lazy", "mason" }
    }
  },
}
