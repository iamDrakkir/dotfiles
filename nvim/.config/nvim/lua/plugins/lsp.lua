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

		local servers = {
			"ansiblels",
			"azure_pipelines_ls",
			"bashls",
			"jsonls",
			"lua_ls",
			"rust_analyzer",
			-- "yamlls",
			"bicep",
			"ruff",
			"basedpyright",
			"copilot",
		}

		mason.setup({
			ui = {
				border = "rounded",
			},
		})

		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_installation = false,
		})

		-- Customize server configs via vim.lsp.config (merges with lsp/*.lua from nvim-lspconfig)
		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "off",
					},
				},
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})

		-- Enable all configured servers
		vim.lsp.enable(servers)
	end,
}
