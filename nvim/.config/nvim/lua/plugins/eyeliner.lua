return {
  "jinh0/eyeliner.nvim",
  event = "BufReadPre",

  config = function()
    local status_ok, eyeliner = pcall(require, "eyeliner")
    if not status_ok then
      return
    end
    eyeliner.setup {
      -- highlight_on_key = true, -- show highlights only after keypress
      -- dim = true              -- dim all other characters if set to true (recommended!)
    }
  end
}
