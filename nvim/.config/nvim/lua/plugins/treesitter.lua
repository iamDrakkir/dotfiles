return {
    "nvim-treesitter/nvim-treesitter",
    cond = vim.g.vscode == nil,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            event = "BufReadPre",
            opts = {
                max_lines = 4,
            },
        },
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSUpdateSync" },
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = true,
        auto_install = true,
    },
}
