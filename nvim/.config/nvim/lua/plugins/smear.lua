return {
    "sphamba/smear-cursor.nvim",
    enabled = false,
    cond = vim.g.vscode == nil,
    opts = {
        smear_insert_mode = false
    },
}
