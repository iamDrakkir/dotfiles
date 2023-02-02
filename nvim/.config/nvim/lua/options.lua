local options = {
  autowrite      = true,            -- Enable auto write
  backup         = false,           -- Creates a backup file
  clipboard      = "unnamedplus",   -- Allows neovim to access the system clipboard
  cmdheight      = 1,               -- More space in the neovim command line for displaying messages
  completeopt    = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel   = 0,               -- So that `` is visible in markdown files
  confirm        = true,            -- Confirm to save changes before exiting modified buffer
  cursorline     = true,            -- Highlight the current line
  expandtab      = true,            -- Convert tabs to spaces
  fileencoding   = "utf-8",         -- The encoding written to a file
  hlsearch       = true,            -- Highlight all matches on previous search pattern
  ignorecase     = true,            -- Ignore case in search patterns
  laststatus     = 3,               -- Use global status line
  list           = true,
  listchars      ="tab:>·,trail:⋅,extends:>,precedes:<,space:⋅",
  mouse          = "a",             -- Allow the mouse to be used in neovim
  number         = true,            -- Set numbered lines
  numberwidth    = 3,               -- Set number column width to 3 {default 4}
  pumheight      = 10,              -- Pop up menu height
  relativenumber = true,            -- Set relative numbered lines
  scrolloff      = 8,               -- Is one of my fav
  shiftwidth     = 2,               -- The number of spaces inserted for each indentation
  showmode       = false,           -- We don't need to see things like -- INSERT -- anymore
  showtabline    = 2,               -- Always show tabs
  signcolumn     = "yes",           -- Always show the sign column, otherwise it would shift the text each time
  smartcase      = true,            -- Smart case
  smartindent    = true,            -- Make indenting smarter again
  splitbelow     = true,            -- Force all horizontal splits to go below current window
  splitright     = true,            -- Force all vertical splits to go to the right of current window
  swapfile       = false,           -- Creates a swapfile
  tabstop        = 2,               -- Insert 2 spaces for a tab
  termguicolors  = true,            -- Set term gui colors (most terminals support this)
  timeoutlen     = 1000,            -- Time to wait for a mapped sequence to complete (in milliseconds)
  undofile       = true,            -- Enable persistent undo
  updatetime     = 200,             -- Faster completion (4000ms default)
  wildmenu       = true,
  wrap           = false,           -- Display lines as one long line
  writebackup    = false,           -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local RemoveTrailingGroup = augroup('RemoveTrailing', {})
local yankGroup           = augroup('HighlightYank', {})

-- highlight yanked text
autocmd('TextYankPost', {
  group = yankGroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40, })
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- trim whitespace without moving cursor on save
function trim_trailing_whitespaces()
  if not vim.o.binary and vim.o.filetype ~= 'diff' then
    local current_view = vim.fn.winsaveview()
    vim.api.nvim_command([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(current_view)
  end
end
autocmd({"BufWritePre"}, {
  group = RemoveTrailingGroup,
  pattern = "*",
  callback = function()
    trim_trailing_whitespaces()
  end,
})

if vim.g.neovide then
  vim.cmd "set guifont=JetBrainsMono_NF:h10"
  vim.g.neovide_cursor_trail_size=0.3
  vim.g.neovide_cursor_animation_length=0.03
  vim.g.neovide_cursor_vfx_mode="pixiedust"
  vim.g.neovide_cursor_vfx_particle_curl=3
end
