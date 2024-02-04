local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
local yankGroup = augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = yankGroup,
  pattern = "*",
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  desc = "Go to last loc when opening a buffer",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespaces
local removeTrailingGroup = augroup("RemoveTrailing", {})
local function trim_trailing_whitespaces()
  if not vim.o.binary and vim.o.filetype ~= "diff" then
    local current_view = vim.fn.winsaveview()
    vim.api.nvim_command([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(current_view)
  end
end
autocmd({ "BufWritePre" }, {
  group = removeTrailingGroup,
  pattern = "*",
  desc = "Remove trailing whitespaces",
  callback = trim_trailing_whitespaces,
})

-- spell correction and wrap for git commits and markdown files
local wrapSpellGroup = augroup("WrapSpell", {})
autocmd("FileType", {
  group = wrapSpellGroup,
  pattern = { "gitcommit", "markdown" },
  desc = "Wrap and check for spell in text filetypes",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Remove some formatoptions
autocmd("BufWinEnter", {
  pattern = "*",
  desc = "Remove some formatoptions",
  callback = function()
    vim.opt.formatoptions:remove({
      "c", -- No autowrap comments
      "r", -- No commet leader on 'enter'
      "o", -- No comment leader on o/O
      "q", -- No formatting of comments
    })
  end,
})

-- Close more filetypes with <q> and <esc>
local closeWithQGroup = augroup("CloseWithQ", {})
autocmd("FileType", {
  group = closeWithQGroup,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "lazy",
    "oil",
  },
  desc = "Close more filetypes with <q> and <esc>",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
