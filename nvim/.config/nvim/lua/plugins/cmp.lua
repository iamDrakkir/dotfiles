return {
  "hrsh7th/nvim-cmp",
  cond = vim.g.vscode == nil,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- Lsp completion
    "hrsh7th/cmp-buffer",       -- buffer completions
    "hrsh7th/cmp-path",         -- Path completions
    "hrsh7th/cmp-cmdline",      -- Cmdline completions
    "hrsh7th/cmp-nvim-lua",     -- Nvim api competions
    "hrsh7th/cmp-git",          -- Git completions
    "L3MON4D3/LuaSnip",         -- Snippets
    "saadparwaiz1/cmp_luasnip", -- Snippets completion
    {
      "zbirenbaum/copilot-cmp",
      config = true,
    },
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-y>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formattingConfig = {
        fields = { "abbr", "menu", "kind" },
        format = function(_, item)
          local kinds = {
            Array = "",
            boolean = "",
            Class = "󰌗",
            Color = "",
            Constant = "",
            Constructor = "",
            Copilot = "",
            Enum = "",
            EnumMember = "",
            Event = "",
            Field = "",
            File = "",
            Folder = "󰉋",
            Function = "󰊕",
            Interface = "",
            Key = "",
            Keyword = "󰌋",
            Method = "m",
            Module = "",
            Namespace = "",
            Null = "",
            Number = "",
            Object = "",
            Operator = "",
            Package = "",
            Property = "",
            Reference = "",
            Snippet = "",
            String = "",
            Struct = "",
            Text = "󰉿",
            TypeParameter = "",
            Unit = "",
            Value = "󰎠",
            Variable = "󰆧",
          }
          if kinds[item.kind] then
            item.kind = kinds[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
