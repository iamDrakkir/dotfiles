return {
    "codethread/qmk.nvim",
    cmd = "QMKFormat",
    cond = vim.g.vscode == nil,
    opts = {
        name = "meh",
        variant = "zmk",
        layout = {
            "_ x x x x x _ _ _ x x x x x _",
            "x x x x x x _ _ _ x x x x x x",
            "x x x x x x _ _ _ x x x x x x",
            "_ _ _ _ x x x _ x x x _ _ _ _",
        }
    },
}
