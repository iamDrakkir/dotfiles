local status_ok, lightspeed = pcall(require, "lightspeed")
if not status_ok then
  return
end

lightspeed.setup {
  ignore_case = true,
  exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },

  -- s/x
  jump_to_unique_chars = true,
  match_only_the_start_of_same_char_seqs = true,
  substitute_chars = { ['\r'] = '¬' },
  -- Leaving the appropriate list empty effectively disables
  -- "smart" mode, and forces auto-jump to be on or off.
  -- safe_labels = { . . . },
  -- labels = { . . . },

  -- f/t
  limit_ft_matches = 4,
  repeat_ft_with_target_char = true,
}
