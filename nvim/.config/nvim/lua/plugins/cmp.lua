return {
  "hrsh7th/nvim-cmp",
  cond = vim.g.vscode == nil,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Lsp completion
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- Path completions
    "hrsh7th/cmp-cmdline", -- Cmdline completions
    "hrsh7th/cmp-nvim-lua", -- Nvim api competions
    "hrsh7th/cmp-git", -- Git completions
    "L3MON4D3/LuaSnip", -- Snippets
    "saadparwaiz1/cmp_luasnip", -- Snippets completion
    {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end,
    }, -- Copilot completions
  },
  event = "InsertEnter",
  config = function()
    local status_ok, cmp = pcall(require, "cmp")
    if not status_ok then
      return
    end

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
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
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        fields = { "abbr", "menu", "kind" },
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
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
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
