return {
  "hrsh7th/nvim-cmp",
  cond = vim.g.vscode == nil,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Lsp completion
    "hrsh7th/cmp-buffer",   -- buffer completions
    "hrsh7th/cmp-path",     -- Path completions
    "hrsh7th/cmp-cmdline",  -- cmdline completions
    "hrsh7th/cmp-nvim-lua", -- nvim api competions
    "saadparwaiz1/cmp_luasnip",
  },
  event = "InsertEnter",
  config = function()
    local status_ok, cmp = pcall(require, "cmp")
    if not status_ok then
      return
    end
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = function(_, item)
          local kinds = {
            Array = " ",
            boolean = " ",
            Class = "",
            Color = " ",
            Constant = " ",
            Constructor = "",
            Copilot = " ",
            Enum = "",
            EnumMember = "",
            Event = " ",
            Field = "",
            File = " ",
            Folder = "",
            Function = "",
            Interface = "",
            Key = " ",
            Keyword = "",
            Method = "m",
            Module = "",
            Namespace = " ",
            Null = " ",
            Number = " ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            Reference = "",
            Snippet = "",
            String = " ",
            Struct = "",
            Text = "",
            TypeParameter = " ",
            Unit = "",
            Value = "",
            Variable = "",
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
    }
  end,
}
