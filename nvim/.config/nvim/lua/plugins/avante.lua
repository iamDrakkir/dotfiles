return {
    {
        "yetone/avante.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        cond = vim.g.vscode == nil,
        cmd = { "AvanteAsk", "AvanteChat", "AvanteEdit", "AvanteToggle", "AvanteClear", "AvanteFocus", "AvanteRefresh", "AvanteSwitchProvider" },
        keys = {
            { "<leader>aa", desc = "Avante: Ask" },
            { "<leader>ad", desc = "Avante: Toggle Debug" },
            { "<leader>af", desc = "Avante: Focus" },
            { "<leader>ah", desc = "Avante: Toggle hints" },
            { "<leader>ar", desc = "Avante: Refresh" },
            { "<leader>aR", desc = "Avante: Display repo map" },
            { "<leader>as", desc = "Avante: Toggle suggestion" },
            { "<leader>aS", desc = "Avante: Toggle" },
            {
                "<leader>ad",
                function()
                    local avante_add_docstring = 'Add docstring to the following codes'
                    require('avante.api').ask { question = avante_add_docstring }
                end,
                mode = { 'n', 'v' },
                desc = 'Docstring(ask)',
            }
        },
        build = "make",
        opts = {
            provider = "azure",
            providers = {
                azure = {
                    endpoint = "https://ctek-ai-sf57piwqzokg6.openai.azure.com",
                    deployment = "gpt-4o",
                    api_version = "2024-08-01-preview",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 0,
                        max_tokens = 4096,
                    },
                },
            },
        },
    },
    -- {
    --   "CopilotC-Nvim/CopilotChat.nvim",
    --   enabled = false,
    --   dependencies = {
    --     { "zbirenbaum/copilot.lua" },
    --     { "nvim-lua/plenary.nvim", branch = "master" },
    --   },
    --   build = "make tiktoken",
    --   opts = {},
    -- },
}
