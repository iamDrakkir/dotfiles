return {
    "saghen/blink.cmp",
    version = "1.*",
    cond = vim.g.vscode == nil,
    enabled = true,
    dependencies = { "fang2hou/blink-copilot" },
    event = "InsertEnter",
    cmd = "BlinkCmp",
    opts = {
        keymap = {
            preset = "default",
            ["<Tab>"] = {
                "snippet_forward",
                function() -- sidekick next edit suggestion
                    return require("sidekick").nes_jump_or_apply()
                end,
                function() -- if you are using Neovim's native inline completions
                    return vim.lsp.inline_completion.get()
                end,
                "fallback",
            },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        signature = {
            window = {
                border = "single",
            },
        },
        completion = {
            menu = {
                border = "single",
            },
            documentation = {
                auto_show = false,
                window = { border = "single" },
            },
            ghost_text = {
                enabled = true,
            },
        },
        sources = {
            default = { "lsp", "copilot", "path", "snippets", "buffer" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-copilot",
                    async = true,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
