return {
  "stevearc/oil.nvim",
  cond = vim.g.vscode == nil,
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory" },
  },
  opts = {},
}
