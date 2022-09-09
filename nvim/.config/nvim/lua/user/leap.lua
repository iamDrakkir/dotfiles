local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

leap.set_default_keymaps()

vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#707070' })

-- leap.setup {
--   max_aot_targets = nil,
--   highlight_unlabeled = false,
--   case_sensitive = false,
--   -- Sets of characters that should match each other.
--   -- Obvious candidates are braces and quotes ('([{', ')]}', '`"\'').
--   equivalence_classes = { ' \t\r\n', },
--   -- Leaving the appropriate list empty effectively disables "smart" mode,
--   -- and forces auto-jump to be on or off.
--   -- safe_labels = { . . . },
--   -- labels = { . . . },
--   special_keys = {
--     repeat_search = '<enter>',
--     next_match    = '<enter>',
--     prev_match    = '<tab>',
--     next_group    = '<space>',
--     prev_group    = '<tab>',
--   },
-- }
