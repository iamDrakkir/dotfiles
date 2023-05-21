return {
  "stevearc/oil.nvim",
  cond = vim.g.vscode == nil,
  opts = {},
  cmd = "Oil",
  keys = {"-", "<cmd>lua require('oil').open()<CR>", desc = "Open parent directory"},
}
