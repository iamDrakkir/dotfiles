local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

telescope.setup {
  defaults = {
    path_display = { "truncate" },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '-g',
      '!.git/'
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-P>"] = action_layout.toggle_preview,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-P>"] = action_layout.toggle_preview,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {"fdfind", "--type", "f", "--strip-cwd-prefix"}
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
      layout_strategy = "horizontal",
      hidden = true,
      display_stat = false,
      layout_config = {
        prompt_position = "top",
        anchor = "W",
        width = 40,
        height = 40,
      },
      path_display = { truncate = 1 }
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    repo = {
      list = {
        fd_opts = {"-E", "packer"},
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

if vim.fn.has('win32') == 1 then
  CWD_PATH = "~/AppData/Local/nvim/"
else
  CWD_PATH = "~/.dotfiles/nvim/.config/nvim/"
end

local M = {}
M.edit_neovim = function()
    require("telescope.builtin").find_files({
        prompt_title = "< edit neovim >",
        follow = true,
        cwd = CWD_PATH,
        hidden = false,
    })
end

M.project_files = function()
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M
