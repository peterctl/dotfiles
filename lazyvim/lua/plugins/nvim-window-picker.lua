return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    opts = {
      hint = "floating-big-letter",
    },
    keys = {
      {
        "<Leader>ww",
        function()
          local picked_window_id = require("window-picker").pick_window()
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
          end
        end,
        desc = "Pick Window",
      },
    },
  },
}
