return {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cond = vim.g.vscode == nil,
    enabled = true,
    setup = true,
}
