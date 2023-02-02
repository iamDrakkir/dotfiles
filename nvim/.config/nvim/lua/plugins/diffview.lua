return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  cond = vim.g.vscode == nil,

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
