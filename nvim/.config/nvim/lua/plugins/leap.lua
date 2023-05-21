return {
  "ggandor/leap.nvim",
  cond = vim.g.vscode == nil,
  keys = {
    { "s",  mode = { "n", "v" } },
    { "S",  mode = { "n", "v" } },
    { "gs", mode = { "n", "v" } },
    { "gS", mode = { "n", "v" } },
  },
  config = function()
    local status_ok, leap = pcall(require, "leap")
    if not status_ok then
      return
    end

    leap.set_default_keymaps()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })
  end,
}
