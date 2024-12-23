return {
  "folke/which-key.nvim",
  cond = vim.g.vscode == nil,
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.add({
      mode = { "n", "v" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>a",     group = "ai" },
      { "<leader>c",     group = "code" },
      { "<leader>f",     group = "file/find" },
      { "<leader>g",     group = "git" },
      { "<leader>gd",    group = "diffview" },
      { "<leader>gh",    group = "hunks" },
      { "<leader>q",     group = "quit/session" },
      { "<leader>s",     group = "search" },
      { "<leader>u",     group = "ui" },
      { "<leader>w",     group = "windows" },
      { "<leader>x",     group = "diagnostics/quickfix" },
      { "[",             group = "prev" },
      { "]",             group = "next" },
      { "g",             group = "goto" },
      { "gz",            group = "surround" },
    })
    wk.setup {
      preset = 'helix',
      show_help = false,
      show_keys = false,
    }
  end,
}
