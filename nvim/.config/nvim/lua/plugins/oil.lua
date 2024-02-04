return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cond = vim.g.vscode == nil,
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory" },
  },
  opts = {
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    keymaps = {
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-s>"] = "actions.select_split",
      ["<Esc>"] = "actions.close",
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 16,
    },
  },
}
