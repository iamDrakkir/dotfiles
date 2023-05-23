return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "NullLsInfo", "NullLsAttach" },
  keys = {
    { "<leader>cn", "<cmd>NullLsInfo<cr>", desc = "NullLsInfo open" },
  },
  dependencies = {
    "williamboman/mason.nvim",
    { "jose-elias-alvarez/null-ls.nvim", config = true },
  },
  config = function()
    -- local null_ls = require("null-ls")
    local mason_null_ls = require("mason-null-ls")

    mason_null_ls.setup({
      ensure_installed = {
        "black",
        "shfmt",
      },
      automatic_installation = true,
      handlers = {
        -- stylua = function()
        --   null_ls.register(null_ls.builtins.formatting.stylua.with({
        --     args = { "-s", "--indent-type", "Spaces", "--indent-width", "2", "-" },
        --   }))
        -- end,
      },
    })

    -- Create an augroup that is used for managing our formatting autocmds.
    --  We need one augroup per client to make sure that multiple clients
    --  can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = "rochakgupta-lsp-format-" .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        if client.name == "copilot" then
          return
        end

        if client.name == "null-ls" then
          return
        end

        local client_name
        -- Fallback to null-ls if client does not support formatting
        if not client.supports_method("textDocument/formatting") then
          print(client.name .. " does not support formatting, using null-ls")
          client_name = "null-ls"
        end

        -- Use formatter provided by null-ls for lua
        -- if client.name == "lua_ls" then
        --   client_name = "null-ls"
        -- end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              filter = function(c)
                if client_name then
                  return c.name == client_name
                end
                return c.id == client.id
              end,
            })
          end,
        })
      end,
    })
  end,
}
