return {
  "nvim-treesitter/nvim-treesitter",
  cond = vim.g.vscode == nil,
  build = ":TSUpdate",
  cmd = { "TSUpdate", "TSUpdateSync" },
  event = { "BufReadPost", "BufNewFile" },
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPre",
      opts = {
        max_lines = 4, -- how many lines the window should span. Values <= 0 mean no limit.
      },
    },
  },
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
-- return {
--   'nvim-treesitter/nvim-treesitter',
--   build = ':TSUpdate',
--   main = 'nvim-treesitter.configs', -- Sets main module to use for opts
--   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
--   opts = {
--     ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
--     -- Autoinstall languages that are not installed
--     auto_install = true,
--     highlight = {
--       enable = true,
--       -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--       --  If you are experiencing weird indenting issues, add the language to
--       --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--       additional_vim_regex_highlighting = { 'ruby' },
--     },
--     indent = { enable = true, disable = { 'ruby' } },
--   },
-- }
