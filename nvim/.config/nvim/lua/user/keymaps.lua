local opts = { noremap = true, silent = true }
local opts_remap = { noremap = false, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- telescope nevigation
keymap("n", "<leader>p", ":Telescope repo list<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua require('user.telescope').project_files()<CR>", opts)
keymap("n", "<leader>gg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>gt", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>b", ":Telescope buffers ignore_current_buffer=true<CR>", opts)
keymap("n", "<Leader>ca", ":Telescope lsp_code_actions theme=cursor<CR>", opts)
keymap("n", "<Leader>e", ":Telescope file_browser path=%:p:h<CR>", opts)
keymap("n", "<Leader>E", ":Telescope file_browser<CR>", opts)
keymap("n", "<leader>n", "<cmd>lua require('user.telescope').edit_neovim()<CR>", opts)
-- formatting
keymap("n", '==', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
keymap("v", '==', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

-- Insert --
-- Easy insertion of a trailing ; from insert mode
keymap("i", ";;", "<Esc>A;<Esc>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- better paste
keymap("v", "p", '"_dP', opts)
-- Maintain the cursor position when yanking a visual selection
keymap("v", "y", "myy`y", opts)
keymap("v", "Y", "myY`y", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
