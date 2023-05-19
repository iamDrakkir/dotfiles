local augroup             = vim.api.nvim_create_augroup
local autocmd             = vim.api.nvim_create_autocmd
local RemoveTrailingGroup = augroup('RemoveTrailing', {})
local yankGroup           = augroup('HighlightYank', {})
local wrapSpellGroup      = augroup('wrapSpell', {})
local closeWithQGroup     = augroup('closeWithQ', {})
local startup             = augroup('closeWithQ', {})

-- Highlight yanked text
autocmd('TextYankPost', {
  group = yankGroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40, })
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Trim whitespace without moving cursor on save
local function trim_trailing_whitespaces()
  if not vim.o.binary and vim.o.filetype ~= 'diff' then
    local current_view = vim.fn.winsaveview()
    vim.api.nvim_command([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(current_view)
  end
end

autocmd({ "BufWritePre" }, {
  group = RemoveTrailingGroup,
  pattern = "*",
  callback = trim_trailing_whitespaces
})

-- Wrap and check for spell in text filetypes
autocmd("FileType", {
  group = wrapSpellGroup,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Remove some formatoptions
autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove { 'c', -- No autowrap comments
      'r',                              -- No commet leader on 'enter'
      'o',                              -- No comment leader on o/O
      'q' }                             -- No formatting of comments
  end,
})

-- Close some filetypes with <q> and <esc>
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
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Open telescope on startup
-- autocmd("VimEnter", {
--   group = startup,
--   pattern = "*",
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
