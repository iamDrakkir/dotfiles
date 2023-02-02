return {
  "VonHeikemen/lsp-zero.nvim",
  cond = vim.g.vscode == nil,
  branch = "v1.x",
  dependencies = {
    -- LSP Support
    {"neovim/nvim-lspconfig"},             -- Required
    {"williamboman/mason.nvim"},           -- Optional
    {"williamboman/mason-lspconfig.nvim"}, -- Optional

    -- Autocompletion
    {"hrsh7th/nvim-cmp"},         -- Required
    {"hrsh7th/cmp-nvim-lsp"},     -- Required
    {"hrsh7th/cmp-buffer"},       -- Optional
    {"hrsh7th/cmp-path"},         -- Optional
    {"saadparwaiz1/cmp_luasnip"}, -- Optional
    {"hrsh7th/cmp-nvim-lua"},     -- Optional

    -- Snippets
    {"L3MON4D3/LuaSnip"},             -- Required
    {"rafamadriz/friendly-snippets"}, -- Optional
  },

  config = function()
    local status_ok, lsp = pcall(require, "lsp-zero")
    if not status_ok then
      return
    end

    lsp.preset('recommended')
    -- (Optional) Configure lua language server for neovim
    lsp.nvim_workspace()
    lsp.setup()
    vim.diagnostic.config { virtual_text = true }
  end
}
