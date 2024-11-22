return {
  "nvim-treesitter/nvim-treesitter",
  cond = vim.g.vscode == nil,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPre",
      opts = {
        max_lines = 4,
      },
    },
  },
  main = 'nvim-treesitter.configs',
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSUpdateSync" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    sync_install = true,     -- install languages synchronously (only applied to `ensure_installed`)
    auto_install = true,     -- automatically install or update missing parsers
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "yaml" },
    },
  }
}
