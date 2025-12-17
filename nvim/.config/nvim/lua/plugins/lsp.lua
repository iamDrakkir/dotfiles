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
      rust_analyzer = {},
      -- yamlls = {},
      bicep = {},
      ruff = {},
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "off",
        },

            },
            -- pyright = {},
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

        mason.setup {
            ui = {
                border = 'rounded'
            }
        }

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = false,
        }

        -- Setup each LSP server manually to avoid automatic_enable issues
        local lspconfig = require('lspconfig')
        for server_name, server_config in pairs(servers) do
            lspconfig[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = server_config,
            }
        end
        require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
}
