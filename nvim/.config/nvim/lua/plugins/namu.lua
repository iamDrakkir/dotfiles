return {
    "bassamsdata/namu.nvim",
    cond = vim.g.vscode == nil,
    config = function()
        require("namu").setup({
            -- Enable the modules you want
            namu_symbols = {
                enable = true,
                options = {},
            },
            -- Optional: E
            ui_select = { enable = false }, -- vim.ui.select() wrapper
        })
        -- === Suggested Keymaps: ===
        vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
            desc = "Jump to LSP symbol",
            silent = true,
        })
        vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
            desc = "Colorscheme Picker",
            silent = true,
        })
    end,
}
