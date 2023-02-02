return {
  "j-hui/fidget.nvim",
  cond = vim.g.vscode == nil,
  event = "BufReadPre",
  config = true,
}
