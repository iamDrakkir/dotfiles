return {
  "sindrets/diffview.nvim",
  cond = vim.g.vscode == nil,
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>",        desc = "Diffview open" },
    { "<leader>gdc", "<cmd>DiffviewClose<cr>",       desc = "Diffview close" },
    { "<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", desc = "Diffview toggle files" },
    { "<leader>gdf", "<cmd>DiffviewFocusFiles<cr>",  desc = "Diffview focus files" },
  },
}
