return {
  "nvim-lualine/lualine.nvim",
  cond = vim.g.vscode == nil,
  event = "VeryLazy",
  config = function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
      return
    end

    local function lsp_text_provider()
      local filetype = vim.api.nvim_get_option_value("filetype", {})
      local clients = vim.lsp.get_clients()
      local lsp_info = ""
      local copilot_icon = ""
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, filetype) ~= -1 and client.name ~= "null-ls" then
          lsp_info = lsp_info .. " - " .. client.name
        end
        if client.name == "copilot" then
          copilot_icon = " "
        end
      end
      return filetype .. lsp_info .. copilot_icon
    end

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    local diff = {
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
      source = diff_source,
    }

    local mode = {
      "mode",
      fmt = function(str)
        return str:sub(1, 3)
      end,
    }

    local location = {
      "location",
      padding = 0,
    }

    local lazy = {
      require("lazy.status").updates,
      cond = require("lazy.status").has_updates,
    }

    lualine.setup({
      options = {
        theme = "auto",
        component_separators = { left = "/", right = "/" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { mode, lazy },
        lualine_b = { { "b:gitsigns_head", icon = "" } },
        lualine_c = { diff },
        lualine_x = { "diagnostics" },
        lualine_y = { lsp_text_provider, "encoding" },
        lualine_z = { location, "progress" },
      },
      inactive_sections = {},
      tabline = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
      winbar = {},
      extensions = { "lazy", "quickfix" },
    })
  end,
}
