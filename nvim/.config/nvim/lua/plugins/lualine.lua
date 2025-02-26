return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine"
  },
  cond = vim.g.vscode == nil,
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")

    local function lsp_provider()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ''
      end

      local c = {}
      for _, client in pairs(clients) do
        if client.name ~= "copilot" then
          table.insert(c, client.name)
        end
      end
      return table.concat(c, ' / ')
    end

    local function formatter()
      local status_ok, conform = pcall(require, "conform")
      if not status_ok then
        return
      end
      return table.concat(conform.list_formatters_for_buffer(0))
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
      on_click = function()
        require("telescope.builtin").git_status()
      end,
    }

    local mode = {
      "mode",
      fmt = function(str)
        return str:sub(1, 3)
      end,
    }

    local branch = {
      "branch",
      icon = "",
      on_click = function()
        require("telescope.builtin").git_branches()
      end
    }

    local copilot = {
      "copilot",
      symbols = {
        status = {
          icons = {
            enabled = "",
            disabled = "",
            warning = "",
            unknown = ""
          }
        }
      }
    }

    local location = {
      "location",
      padding = 0,
    }

    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      end
      return "Recording @" .. recording_register
    end

    local lazy = {
      require("lazy.status").updates,
      cond = require("lazy.status").has_updates,
    }

    local telescope_extension = {
      sections = {
        lualine_a = { mode },
        lualine_b = { function()
          return "Telescope"
        end
        }
      },
      filetypes = { "TelescopePrompt" }
    }

    local dashboard_extension = {
      sections = {
        lualine_a = { function()
          return "Dashboad"
        end
        },
        lualine_b = { branch },
      },
      filetypes = { "snacks_dashboard" }
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
        lualine_b = { branch },
        lualine_c = { diff, show_macro_recording },
        lualine_x = {
          {
            "diagnostics",
            on_click = function()
              require("telescope.builtin").diagnostics()
            end
          }
        },
        lualine_y = { "filetype", formatter, lsp_provider, copilot, "encoding" },
        lualine_z = { location, "progress" },
      },
      inactive_sections = {},
      -- tabline = {
      --   lualine_a = { "filename" },
      --   lualine_b = {},
      --   lualine_c = {},
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = { "tabs" },
      -- },
      -- winbar = {},
      extensions = { "lazy", "quickfix", "mason", telescope_extension, dashboard_extension },
    })
  end,
}
