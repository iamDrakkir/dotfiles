return {
  "sindrets/diffview.nvim",
  cond = vim.g.vscode == nil,
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },

  config = function()
    local status_ok, diffview = pcall(require, "diffview")
    if not status_ok then
      return
    end

    diffview.setup {
      use_icons = false,
    }
  end
}
