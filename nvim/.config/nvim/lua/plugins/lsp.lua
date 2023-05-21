return {
  "neovim/nvim-lspconfig",
  cond = vim.g.vscode == nil,
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      config = true
    },
    "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim", config = true },
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local lsp_config = require("lspconfig")
    local lsp_defaults = lsp_config.util.default_config

    lsp_defaults.capabilities = vim.tbl_deep_extend(
      "force",
      lsp_defaults.capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    mason_lspconfig.setup({
      ensure_installed = {
        "pylsp",
        "bashls",
        "dockerls",
        "jsonls",
        "yamlls",
        "lua_ls",
        "azure_pipelines_ls",
        "rust_analyzer",
        "ansiblels",
      },
      automatic_installation = true
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lsp_config[server_name].setup {}
      end,

      ["pyright"] = function()
        lsp_config.pyright.setup({
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
              }
            }
          }
        })
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Format on Save",
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
      pattern = { "*" }
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      desc = 'LSP Attach',
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>cf', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end
}
