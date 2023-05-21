return {
  "stevearc/oil.nvim",
  cond = vim.g.vscode == nil,
  opts = {},
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory" },
  },
}
