return {
  "yetone/avante.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "AvanteAsk", "AvanteChat", "AvanteEdit", "AvanteToggle", "AvanteClear", "AvanteFocus", "AvanteRefresh", "AvanteSwitchProvider" },
  build = "make",
  opts = {
    provider = "azure",
    azure = {
      endpoint = "https://ctek-openai-test.openai.azure.com",
      deployment = "gpt-4o",
      api_version = "2024-06-01",
      timeout = 30000,
      temperature = 0,
      max_tokens = 4096,
    },
  },
}
