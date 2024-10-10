vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- UI
opt.termguicolors = true  -- True color support
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Use relative line number
opt.scrolloff = 8         -- Lines of context
opt.showmode = false      -- Dont show mode in cmd line, It is in statusline
opt.cursorline = true     -- Highligting the current line
opt.signcolumn = "yes"    -- Always show the signcolumn, otherwise it would shift the text each time
opt.conceallevel = 1      -- conceral text
opt.wrap = false          -- No line wrap
opt.splitbelow = true     -- Put new windows below current
opt.splitright = true     -- Put new windows right of current
opt.list = true           -- Show invisible charachters (tabs, space...)

-- if vim.fn.has('termguicolors') == 1 then
--   opt.listchars = {
--     tab = ">-",
--     extends = ">",
--     precedes = "<",
--     nbsp = "+",
--     space = "⋅",
--     trail = "⋅",
--     -- eol = "↴",
--   }
-- end
-- opt.fillchars = { eob = " " } -- No tilde at the end of the file

-- Search
opt.hlsearch = true            -- Highlight all matches from search pattern
opt.ignorecase = true          -- Ignore case in search pattern
opt.smartcase = true           -- Don't ignore case in seaches if capitalization is used
opt.iskeyword:append("-")      -- Treat words with - as one word
opt.grepformat = "%f:%l:%c:%m" -- fileneme:line:column:error
opt.grepprg = "rg --vimgrep"   -- use rg for grep

-- Tabs and spaces
opt.expandtab = true   -- Use spaces instead of tabs
opt.smartindent = true -- Insert indentation automatically
opt.shiftround = true  -- Round indent to multiple of 'shiftwidth'.
opt.tabstop = 2        -- Number of spaces tabs count for
opt.shiftwidth = 2     -- Size of indents

-- System
opt.completeopt = "menu,menuone,noselect" -- mostly for cmp
opt.autowrite = true                      -- Enable auto write
opt.clipboard = "unnamedplus"             -- Sync with system clipboard
opt.swapfile = false
opt.undofile = true                       -- Persistant unto
opt.updatetime = 200                      -- Faster completion
opt.diffopt:append({
  "algorithm:patience",
  "linematch:60",
})          -- Better diff options
opt.shortmess:append({
  W = true, -- Disable "writen" message
  I = true, -- Disable into messages
  c = true, -- Disable "match 1 of 2" and simular messages
})

vim.g.python_host_prog = "python"
vim.g.python3_host_prog = "python3"
