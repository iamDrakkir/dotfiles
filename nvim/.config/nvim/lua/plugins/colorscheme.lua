return {
  {
    "sainnhe/gruvbox-material",
    cond = vim.g.vscode == nil,
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_sign_column = "bg0"
      vim.g.gruvbox_italicize_comments = 0
      vim.g.gruvbox_material_foreground = "original"

      vim.cmd("colorscheme gruvbox-material")
    end,
    --vim.cmd([[
    --    function! s:gruvbox_material_custom() abort
    --        " Link a highlight group to a predefined highlight group.
    --        " See `colors/gruvbox-material.vim` for all predefined highlight groups.
    --        highlight! link TSString Yellow
    --        highlight! link TelescopeSelection ColorColumn
    --
    --        " Initialize the color palette.
    --        " The first parameter is a valid value for `g:gruvbox_material_background`,
    --        " and the second parameter is a valid value for `g:gruvbox_material_palette`.
    --        let l:palette = gruvbox_material#get_palette('hard', 'original', {})
    --
    --        " Define a highlight group.
    --        "  The first parameter is the name of a highlight group,
    --        "  the second parameter is the foreground color,
    --        "  the third parameter is the background color,
    --        "  the fourth parameter is for UI highlighting which is optional,
    --        "  and the last parameter is for `guisp` which is also optional.
    --        " See `autoload/gruvbox_material.vim` for the format of `l:palette`.
    --        call gruvbox_material#highlight('String', l:palette.yellow, l:palette.none)
    --    endfunction
    --
    --    augroup GruvboxMaterialCustom
    --        autocmd!
    --        autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
    --    augroup END
    --
    --    colorscheme gruvbox-material
    --]])
  },
  {
    "rose-pine/neovim",
    cond = vim.g.vscode == nil,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        dark_variant = "main", -- "main" | "moon"
      })
      vim.cmd("colorscheme rose-pine")

      local p = require('rose-pine.palette')
      local h = require('rose-pine.util').highlight

      h("Whitespace", { fg = p.overlay })
      h("EndOfBuffer", { fg = p.base })

      h("IndentBlanklineChar", { fg = p.overlay })
      h("IndentBlanklineSpaceChar", { fg = p.overlay })
      h("IndentBlanklineContextChar", { fg = p.muted })
    end,
  },
  {
    "arturgoms/moonbow.nvim",
    cond = vim.g.vscode == nil,
    enabled = false,
    lazy = false,
    priority = 1000,
  },
}
