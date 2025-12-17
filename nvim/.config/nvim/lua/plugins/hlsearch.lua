return {
    "nvimdev/hlsearch.nvim",
    cond = vim.g.vscode == nil,
    event = "BufReadPost",
    config = true,
}
