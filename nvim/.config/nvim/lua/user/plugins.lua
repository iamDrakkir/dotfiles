local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins

  -- Colorschemes
  use "sainnhe/gruvbox-material"
  use "rose-pine/neovim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- Path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"     -- Lsp completion

  -- LSP
  use "neovim/nvim-lspconfig"           -- Enable LSP
  use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
  use "tamago324/nlsp-settings.nvim"    -- Language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- Formatter and linter

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use "cljoly/telescope-repo.nvim"
  use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make' }

  -- Treesitter
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

  -- Navigaton
  use "ggandor/leap.nvim"
  use 'jinh0/eyeliner.nvim' -- f indicators for each work on line
  use "nacitar/a.vim"       -- Switch between header and source 

  -- Pretty
  use "lewis6991/gitsigns.nvim" -- Git status in signcolum
  use "j-hui/fidget.nvim"       -- Lsp progress
  use "feline-nvim/feline.nvim" -- Statusline
  use "machakann/vim-highlightedyank"

  -- Other
  use "sindrets/diffview.nvim"
  use "numToStr/Comment.nvim"
  use "akinsho/toggleterm.nvim" 

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
