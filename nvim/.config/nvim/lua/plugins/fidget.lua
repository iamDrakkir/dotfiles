return {
  "j-hui/fidget.nvim",
  cond = vim.g.vscode == nil,
  event = "LspAttach",
  config = true,
}
