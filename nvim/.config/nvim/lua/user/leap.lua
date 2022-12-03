local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

leap.set_default_keymaps()

vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#707070' })
