return {
  "ja-ford/delaytrain.nvim",
  cond = vim.g.vscode == nil,
  event = "BufEnter",
  opts = {
    grace_period = 5,
  },
}
