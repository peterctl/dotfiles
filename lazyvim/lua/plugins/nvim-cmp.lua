return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Prevents <CR> from confirming completion unless an entry was actively selected.
      local cr_mapping = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      })

      -- If open, selects the current item. If closed, opens the completion window.
      local confirm_or_complete_mapping = cmp.mapping({
        i = function()
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
          else
            cmp.complete()
          end
        end,
      })

      opts.mapping["<CR>"] = cr_mapping
      opts.mapping["<C-Space>"] = confirm_or_complete_mapping
      opts.mapping["<C-K>"] = confirm_or_complete_mapping

      return opts
    end,
  },
}
