return {
  'echasnovski/mini.files',
  version = false,
  opts = {
    windows = {
      preview = true,
      width_preview = 50,
      width_focus = 25
    }
  },
  keys = {
    { "-", "<cmd>lua MiniFiles.open()<CR>", desc = "Open parent directory" },
  },
}
