return {
  "lewis6991/gitsigns.nvim",
  cond = vim.g.vscode == nil,
  event = "BufReadPre",
  keys = {
    { "]h",          ":Gitsigns next_hunk<cr>",       desc = "Next Hunk" },
    { "[h",          ":Gitsigns prev_hunk<cr>",       desc = "Prev Hunk" },
    { "<leader>ghs", ":Gitsigns stage_hunk<cr>",      mode = { "n", "v" },     desc = "Stage Hunk" },
    { "<leader>ghr", ":Gitsigns reset_hunk<cr>",      mode = { "n", "v" },     desc = "Reset Hunk" },
    { "<leader>ghS", ":Gitsigns stage_buffer<cr>",    desc = "Stage Buffer" },
    { "<leader>ghu", ":Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
    { "<leader>ghR", ":Gitsigns reset_buffer<cr>",    desc = "Reset Buffer" },
    { "<leader>ghp", ":Gitsigns preview_hunk<cr>",    desc = "Preview Hunk" },
    { "<leader>ghd", ":Gitsigns diffthis<cr>",        desc = "Diff This" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "┆" },
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  }
}
