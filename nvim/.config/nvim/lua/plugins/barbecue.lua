return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- configurations go here
  },
}
