local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local function lsp_text_provider()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
      return buf_ft
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes
    and vim.fn.index(filetypes, buf_ft) ~= -1
    and client.name ~= "null-ls" then
      return buf_ft .. " - " .. client.name
    end
  end
  return buf_ft
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
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
	end
}

local location = {
	"location",
	padding = 0,
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	-- local chars = {" ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"}
	local chars = {"█", "▇", "▆", "▅", "▄", "▃", "▂", "▁", " "}
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

lualine.setup {
  options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '\\', right = '/'},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { {'b:gitsigns_head', icon = ''} },
    lualine_c = { diff },
    lualine_x = {'diagnostics' },
    lualine_y = { lsp_text_provider, 'encoding' },
    lualine_z = { location, progress }
  },
  inactive_sections = {},
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'},
  },
  extensions = {}
}
