return {
  "nvim-treesitter/nvim-treesitter",
  cond = vim.g.vscode == nil,
  build = ":TSUpdate",
  cmd = { 'TSUpdate', 'TSUpdateSync' },
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPre",
      opts = {
        max_lines = 4, -- how many lines the window should span. Values <= 0 mean no limit.
      },
    }
  },
  config = function()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end
    treesitter.setup {
      ensure_installed = "all",  -- one of "all", or a list of languages (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
      sync_install     = true,   -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install   = { "" }, -- List of parsers to ignore installing
      highlight        = {
        enable = true,
      },
      indent           = {
        enable = true,
        disable = { "yaml" }
      },
    }
  end
}
