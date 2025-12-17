return {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    cond = vim.g.vscode == nil,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    ft = { "markdown" },
    opts = {
        code = {
            width = 'block',
            left_pad = 2,
            right_pad = 4,
        },
        render_modes = true,
        heading = {
            width = "block",
        },
        pipe_table = { preset = 'round' },
    },
}
