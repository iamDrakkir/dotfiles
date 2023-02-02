return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = { 'TSUpdate', 'TSUpdateSync' },
  cond = vim.g.vscode == nil,

  config = function()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end
    treesitter.setup {
      ensure_installed = "all",  -- one of "all", or a list of languages (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
      sync_install     = false,  -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install   = { "" }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable  = true,   -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true,
        disable = { "yaml" }
      },
    }
  end
}

