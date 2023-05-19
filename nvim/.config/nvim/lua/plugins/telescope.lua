return {
  "nvim-telescope/telescope.nvim",
  cond = vim.g.vscode == nil,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "cljoly/telescope-repo.nvim",
    "debugloop/telescope-undo.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = 'make', },
  },
  cmd = "Telescope",
  keys = {
    -- find/files
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                         desc = "Find Files (root dir)" },
    { "<leader>fb", "<cmd>Telescope buffers ignore_current_buffer=true<cr>", desc = "Switch Buffer" },
    { "<leader>,",  "<cmd>Telescope buffers ignore_current_buffer=true<cr>", desc = "Switch Buffer" },
    { "<Leader>fe", "<cmd>Telescope file_browser path=%:p:h<cr>",            desc = "Explore Files (cwd)" },
    { "<Leader>fE", "<cmd>Telescope file_browser<cr>",                       desc = "Explore Files (root dir)" },
    { "<Leader>fr", "<cmd>Telescope repo<cr>",                               desc = "Find Repos" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                           desc = "Old files" },
    { "<leader>/",  "<cmd>Telescope live_grep<cr>",                          desc = "Find in Files (Grep)" },
    -- { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<cr>",                        desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>",                         desc = "status" },
    -- search
    { "<leader>sa", "<cmd>Telescope autocommands<cr>",                       desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",          desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>",                    desc = "Command History" },
    { "<leader>s:", "<cmd>Telescope command_history<cr>",                    desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                           desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>",                        desc = "Diagnostics" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>",                          desc = "Grep (root dir)" },
    -- { "<leader>sG", "<cmd>Telescope live_grep cwd=false<cr>", desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                          desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>",                         desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                            desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                          desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                              desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>",                        desc = "Options" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>",                        desc = "Word (root dir)" },
    -- { "<leader>sW", "<cmd>Telescope grep_string cwd=false<cr>", desc = "Word (cwd)" },
    { "<leader>uC", "<cmd>Telescope colorscheme enable_preview=true<cr>",    desc = "Colorscheme with preview" },
    { "<leader>fu", "<cmd>Telescope undo<cr>",                               desc = "Undo tree" },
    -- {
    --   "<leader>ss",
    --   Util.telescope("lsp_document_symbols", {
    --     symbols = {
    --       "Class",
    --       "Function",
    --       "Method",
    --       "Constructor",
    --       "Interface",
    --       "Module",
    --       "Struct",
    --       "Trait",
    --       "Field",
    --       "Property",
    --     },
    --   }),
    --   desc = "Goto Symbol",
  },
  config = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
      return
    end
    local actions = require "telescope.actions"
    local action_layout = require "telescope.actions.layout"

    telescope.setup {
      defaults = {
        path_display = { "truncate" },
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<C-?>"] = actions.which_key, -- keys from pressing <C-/>
            ["<C-P>"] = action_layout.toggle_preview,
            ["<C-k>"] = actions.cycle_history_next,
            ["<C-j>"] = actions.cycle_history_prev,
          },
          n = {
            ["<C-P>"] = action_layout.toggle_preview,
            ["<C-k>"] = actions.cycle_history_next,
            ["<C-j>"] = actions.cycle_history_prev,
          },
        },
      },

      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
        },
        buffers = {
          sort_lastused = true,
          previewer = false,
          theme = "dropdown",
          mappings = {
            i = { ["<C-d>"] = actions.delete_buffer, },
            n = { ["<C-d>"] = actions.delete_buffer, }
          }
        },
      },

      extensions = {
        file_browser = {
          previewer = false,
          grouped = true,
          sorting_strategy = "ascending",
          hidden = true,
          display_stat = false,
          layout_config = {
            prompt_position = "top",
            anchor = "CENTER",
            width = 40,
            height = 40,
          },
        },
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
        },
        repo = {
          list = {
            fd_opts = { "-E", "packer" },
            -- search_dirs = {},
            tail_path = true,
            -- shorten_path = true,
          },
        },
      },
    }

    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    telescope.load_extension('repo')
    telescope.load_extension("undo")
  end
}
