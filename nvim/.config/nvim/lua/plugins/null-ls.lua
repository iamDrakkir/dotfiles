return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "NullLsInfo", "NullLsAttach" },
  keys = {
    { "<leader>cn", "<cmd>NullLsInfo<cr>", desc = "NullLsInfo open" },
  },
  dependencies = {
    "williamboman/mason.nvim",
    { "jose-elias-alvarez/null-ls.nvim", config = true },
  },
  config = function()
    local null_ls = require("null-ls")
    local mason_null_ls = require("mason-null-ls")

    mason_null_ls.setup({
      ensure_installed = {
        "black",
        "stylua",
        "shfmt",
      },
      automatic_installation = true,
      handlers = {
        stylua = function()
          null_ls.register(null_ls.builtins.formatting.stylua.with({
            args = { "-s", "--indent-type", "Spaces", "--indent-width", "2", "-" },
          }))
        end,
      },
    })
  end,
}
