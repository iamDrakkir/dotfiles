return {
  "ja-ford/delaytrain.nvim",
  cond = vim.g.vscode == nil,
  event = "bufreadpost",
  opts = {
    grace_period = 5,
  },
}
