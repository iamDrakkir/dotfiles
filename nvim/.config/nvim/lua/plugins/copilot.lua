-- return {
--   "github/copilot.vim",
--   cond = vim.g.vscode == nil,
--   event = "VeryLazy",
-- }
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  build = ":Copilot auth",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          -- accept_line = "<M-l>",
          accept_word = "<S-Tab>",
          -- next = "<M-]>",
          -- prev = "<M-[>",
          -- dismiss = "<M-c>",
        },
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        yaml = true,
        markdown = true,
      },
    })
  end,
}
