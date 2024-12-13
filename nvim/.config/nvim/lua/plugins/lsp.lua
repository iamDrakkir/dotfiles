return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      keys = {
        { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason open" },
      },
      config = true,
    },
    "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim", config = true, },
  },
  cond = vim.g.vscode == nil,
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo" },
  keys = {
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "LspInfo open" },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local servers = {
      ansiblels = {},
      azure_pipelines_ls = {},
      bashls = {},
      jsonls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      ruff_lsp = {},
      rust_analyzer = {},
      -- yamlls = {},
      bicep = {},
    }

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>cr', vim.lsp.buf.rename, '[C]ode Rename')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = false,
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,
    }

    mason.setup {
      ui = {
        border = 'rounded'
      }
    }
    require('lspconfig.ui.windows').default_options.border = 'rounded'
  end,
}
