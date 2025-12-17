return {
    "rachartier/tiny-inline-diagnostic.nvim",
    cond = vim.g.vscode == nil,
    event = "LspAttach",
    enabled = true,
    priority = 900,
    opts = {
        options = {
            multilines = {
                enable = true
            }
        }
    },
}
