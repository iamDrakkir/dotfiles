vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local opt            = vim.opt

opt.autowrite        = true                    -- Enable auto write
opt.clipboard        = "unnamedplus"           -- Sync with system clipboard
opt.completeopt      = "menu,menuone,noselect" -- mostly for cmp
opt.confirm          = true                    -- Confirm to save changes before exiting modified buffers
opt.cursorline       = true                    -- Highligting the current line
opt.diffopt:append {
  "internal",
  "algorithm:patience",
  "linematch:60"
}
opt.expandtab  = true           -- Use spaces instead of tabs
opt.grepformat = "%f:%l:%c:%m"  -- fileneme:line:column:error
opt.grepprg    = "rg --vimgrep" -- use rg for grep
opt.hlsearch   = true           -- Highlight all matches from search pattern
opt.ignorecase = true           -- Ignore case in search pattern
opt.inccommand = "nosplit"      -- Preview incremental substitue
opt.iskeyword:append("-")       -- Treat words with - aTreat words with - as ones one
opt.list           = true       -- Show invisible charachters (tabs, space...)
opt.listchars      = {
  tab = ">-",
  extends = ">",
  precedes = "<",
  nbsp = "+",
  space = "⋅",
  trail = "⋅"
}
opt.mouse          = "a"         -- Allow mouse in to be used
opt.number         = true        -- Show line number
opt.pumblend       = 10          -- Make popup menu slightly transparent
opt.pumheight      = 10          -- Maximum number of entries in popup
opt.relativenumber = true        -- Use relative line number
opt.scrolloff      = 8           -- Lines of context
opt.shiftround     = true        -- Round indent to multiple of 'shiftwidth'.
opt.shiftwidth     = 2           -- Size of indents
opt.shortmess:append { W = true, -- Disable "writen" message
  I = true,                      -- Disable into messages
  c = true }                     -- Disable "match 1 of 2" and simular messages
opt.showmode      = false        -- Dont show mode in cmd line, It is in statusline
opt.sidescrolloff = 8            -- Columns of context
opt.signcolumn    = "yes"        -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase     = true         -- Don't ignore case in seaches if capitalization is used
opt.smartindent   = true         -- Insert indentation automatically
opt.spelllang     = { "en" }     -- Add english spelling
opt.splitbelow    = true         -- Put new windows below current
opt.splitright    = true         -- Put new windows right of current
opt.swapfile      = false        -- Don't use swapfile
opt.tabstop       = 2            -- Number of spasec tabs count for
opt.termguicolors = true         -- True color support
opt.undofile      = true         -- Persistant unto
opt.updatetime    = 200          -- Faster completion
opt.virtualedit   = "onemore"    -- Allow cusor to move 1 char after new line
opt.wildmode      = { "longest:full", "full" }
opt.wrap          = false        -- No line wrap
