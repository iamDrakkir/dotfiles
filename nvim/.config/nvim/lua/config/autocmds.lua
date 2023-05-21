local augroup             = vim.api.nvim_create_augroup
local autocmd             = vim.api.nvim_create_autocmd
local removeTrailingGroup = augroup('RemoveTrailing', {})
local yankGroup           = augroup('HighlightYank', {})
local wrapSpellGroup      = augroup('WrapSpell', {})
local closeWithQGroup     = augroup('CloseWithQ', {})
-- local startup             = augroup('telescope', {})

autocmd('TextYankPost', {
  group = yankGroup,
  pattern = '*',
  desc = 'Highlight yanked text',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40, })
  end,
})

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

local function trim_trailing_whitespaces()
  if not vim.o.binary and vim.o.filetype ~= 'diff' then
    local current_view = vim.fn.winsaveview()
    vim.api.nvim_command([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(current_view)
  end
end

autocmd({ "BufWritePre" }, {
  group = removeTrailingGroup,
  pattern = "*",
  desc = "Remove trailing whitespaces",
  callback = trim_trailing_whitespaces
})

autocmd("FileType", {
  group = wrapSpellGroup,
  pattern = { "gitcommit", "markdown" },
  desc = "Wrap and check for spell in text filetypes",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("BufWinEnter", {
  pattern = "*",
  desc = "Remove some formatoptions",
  callback = function()
    vim.opt.formatoptions:remove { 'c', -- No autowrap comments
      'r',                              -- No commet leader on 'enter'
      'o',                              -- No comment leader on o/O
      'q' }                             -- No formatting of comments
  end,
})

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
  },
  desc = "Close more filetypes with <q> and <esc>",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- autocmd("VimEnter", {
--   group = startup,
--   pattern = "*",
--   desc = "Open telescope on startup",
--   callback = function()
--     vim.defer_fn(function()
--       -- Dropdown menu
--       local opts = {
--         previewer = false,
--         shorten_path = false,
--         layout_config = {
--           prompt_position = "top",
--         },
--         sorting_strategy = "ascending",
--         prompt_prefix = "🔍 ",
--       }
--       require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false }))
--     end, 100)
--   end,
-- })
