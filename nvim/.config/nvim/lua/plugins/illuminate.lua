return {
  "RRethy/vim-illuminate",
  cond = vim.g.vscode == nil,
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "]]", function() require("illuminate").goto_next_reference(true) end, desc = "Next Reference" },
    { "[[", function() require("illuminate").goto_prev_reference(true) end, desc = "Prev Reference" },
  },
  config = function()
    require("illuminate").configure() -- illuminate does not use setup, so we need to call configure directly
  end
}
