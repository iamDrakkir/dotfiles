vim.diagnostic.config({
	virtual_text = false,
	-- virtual_text = {
	--   prefix = '●', -- Could be '●', '▎', 'x'
	--   source = true,
	-- }, -- handled by tiny-inline-diagnostic.nvim",
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
