local status_ok, feline = pcall(require, "feline")
if not status_ok then
  return
end

local status_gruvbox, colors = pcall(require, "gruvbox.colors")
if not status_gruvbox then
  print("no load")
 colors = {
   dark0_hard = "#1d2021",
   dark0      = "#282828",
   dark0_soft = "#32302f",
   dark1      = "#3c3836",
   dark2      = "#504945",
   dark3      = "#665c54",
   dark4      = "#7c6f64",
   red        = "#cc241d",
   green      = "#98971a",
   yellow     = "#d79921",
   blue       = "#458588",
   purple     = "#b16286",
   aqua       = "#689d6a",
   orange     = "#d65d0e",
   grey14     = "#242932",
 }
end

local vi_mode_colors = {
  NORMAL        = colors.yellow,
  INSERT        = colors.orange,
  VISUAL        = colors.yellow,
  LINES         = colors.yellow,
  OP            = colors.green,
  BLOCK         = colors.blue,
  REPLACE       = colors.purple,
  ['V-REPLACE'] = colors.purple,
  ENTER         = colors.red,
  MORE          = colors.red,
  SELECT        = colors.orange,
  COMMAND       = colors.green,
  SHELL         = colors.green,
  TERM          = colors.green,
  NONE          = colors.yellow
}

local vi_mode_utils = require 'feline.providers.vi_mode'
local lsp = require "feline.providers.lsp"

local conditions = {
  diagnostic_enable = function(fn, type)
    return function()
      local diagnostics_count = fn()[type]
      return diagnostics_count and diagnostics_count ~= 0
    end
  end,
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end
}

local block = {
  provider = " ",
  hl = function()
    return {
      name = vi_mode_utils.get_mode_highlight_name(),
      bg = vi_mode_utils.get_mode_color()
    }
  end
}

local vi_mode_text = {
  provider = function()
    return vi_mode_utils.get_vim_mode() .. " "
  end,
  hl = function()
    return {
      name = vi_mode_utils.get_mode_highlight_name(),
      fg = vi_mode_utils.get_mode_color(),
      bg = colors.dark0,
      style = "bold"
    }
  end,
  left_sep = {
    str = " ",
    hl = {
      bg = colors.dark0,
    },
  },
  right_sep = ''
}

local file = {
  info = {
    provider = "file_info",
    icon = '',
    left_sep = " ",
    right_sep = " ",
    hl = {
      fg = colors.yellow,
      style = "bold",
    },
    enabled = conditions.buffer_not_empty
  },
  winbar_info = {
    provider = "file_info",
    left_sep = " ",
    right_sep = " ",
    enabled = conditions.buffer_not_empty
  },
  encoding = {
    provider = "file_encoding",
    left_sep = " ",
    right_sep = " ",
    enabled = conditions.buffer_not_empty
  },
  type = {
    provider = "file_type",
    left_sep = " ",
    right_sep = " ",
    enabled = conditions.buffer_not_empty
  },
  indent_size = {
    icon = "הּ",
    provider = function()
      return " " .. vim.opt.tabstop:get()
    end,
    left_sep = " ",
    right_sep = " ",
    hl = { fg = colors.grey9 },
    enabled = conditions.buffer_not_empty
  },
  size = {
    provider = "file_size",
    left_sep = " ",
    right_sep = " ",
    enabled = conditions.buffer_not_empty
  },
  position = {
    provider = "position",
    left_sep = " ",
    right_sep = " ",
    enabled = conditions.buffer_not_empty
  },
}

local positions = {
  line_percentage = {
    provider = 'line_percentage',
    left_sep = ' ',
    hl = {
      style = 'bold'
    },
    enabled = conditions.buffer_not_empty
  },
  position = {
    provider = 'position',
    left_sep = ' ',
    hl = {
      style = 'bold'
    },
    enabled = conditions.buffer_not_empty
  },
  scroll_bar = {
    provider = 'scroll_bar',
    left_sep = ' ',
    hl = {
      fg = colors.yellow,
      style = 'bold'
    },
    enabled = conditions.buffer_not_empty
  }
}

local diagnostics = {
  error = {
    provider = 'diagnostic_errors',
    enabled = function()
      return lsp.diagnostics_exist('ERROR')
    end,
    hl = {
      fg = colors.red
    }
  },
  warn = {
    provider = 'diagnostic_warnings',
    enabled = function()
      return lsp.diagnostics_exist('WARN')
    end,
    hl = {
      fg = colors.yellow
    }
  },
  info = {
    provider = 'diagnostic_info',
    enabled = function()
      return lsp.diagnostics_exist('INFO')
    end,
    hl = {
      fg = colors.orange
    }
  },
  hint = {
    provider = 'diagnostic_hints',
    enabled = function()
      return lsp.diagnostics_exist('HINT')
    end,
    hl = {
      fg = colors.blue
    }
  }
}

local lsp_name = {
  provider = "lsp_client_names",
  left_sep = " ",
  right_sep = " ",
  -- icon = '' .. " ",
  icon = '' .. " ",
  hl = {
    fg = colors.green
  }
}

local git_utils = require "feline.providers.git"

local powerline = {
  left = {
    provider = function()
      if git_utils.git_info_exists() then
        return ''
      else
        return ""
      end
    end,
    hl = {
      fg = colors.dark0_hard,
      bg = colors.dark0
    }
  }
}

local git = {
  branch = {
    provider = "git_branch",
    icon = '' .. " ",
    hl = {
      fg = colors.magenta,
      bg = colors.grey14,
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = {
        bg = colors.grey14,
      },
    },
    right_sep = {
      str = " ",
      hl = {
        bg = colors.grey14,
      },
    },
  },
  add = {
    provider = "git_diff_added",
    hl = {
      fg = colors.green,
      bg = colors.grey14,
    },
    icon = '洛',
    left_sep = {
      str = " ",
      hl = {
        bg = colors.grey14,
      },
    },
  },
  change = {
    provider = "git_diff_changed",
    hl = {
      fg = colors.orange,
      bg = colors.grey14,
    },
    icon = ' ',
    left_sep = {
      str = " ",
      hl = {
        bg = colors.grey14,
      },
    },
  },
  remove = {
    provider = "git_diff_removed",
    hl = {
      fg = colors.red,
      bg = colors.grey14,
    },
    icon = ' ',
    left_sep = {
      str = " ",
      hl = {
        bg = colors.grey14,
      }
    }
  }
}

feline.setup {
  colors = { bg = colors.bg, fg = colors.fg },
  components = {
    active = {
      {
        block,
        vi_mode_text,
        file.type,
        file.info,
        file.size,
        positions.line_percentage,
        positions.scroll_bar,
        positions.position,
        diagnostics.error,
        diagnostics.warn,
        diagnostics.info,
        diagnostics.hint
      },
      {
        lsp_name,
        file.encoding,
        file.indent_size,
        powerline.left,
        git.add,
        git.change,
        git.remove,
        git.branch,
        block
      }
    },
    inactive = {
      {
        block,
        vi_mode_text,
        file.info,
      },
      {},
    },
  },
  vi_mode_colors = vi_mode_colors,
}
