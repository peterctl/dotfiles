return {
  {
    "pablopunk/pi.nvim",
    keys = {
      { "<leader>a", desc = "+ai (pi)" },
      { "<leader>aa", ":PiAsk<CR>", desc = "Ask Pi" },
      { "<leader>aa", ":PiAskSelection<CR>", mode = "v", desc = "Ask Pi (selection)" },
      { "<leader>ac", ":PiCancel<CR>", desc = "Cancel the active Pi request immediately" },
      { "<leader>al", ":PiLog<CR>", desc = "Open the Pi session log in a new split" },
    },
  },
}
