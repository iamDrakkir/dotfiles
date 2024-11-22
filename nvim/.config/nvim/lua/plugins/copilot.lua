return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    suggestion = {
      enabled = false,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        -- accept_line = "<M-l>",
        accept_word = "<S-Tab>",
        -- next = "<M-]>",
        -- prev = "<M-[>",
        -- dismiss = "<M-c>",
      },
    },
    panel = {
      enabled = false,
    },
    filetypes = {
      yaml = true,
      markdown = true,
    },
  }
}
