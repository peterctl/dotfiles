return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["<CR>"] = cmp.mapping({
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
      opts.mapping["<C-Space>"] = cmp.mapping({
        i = function()
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
          else
            cmp.complete()
          end
        end,
      })
      opts.mapping["<Esc>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.close()
          else
            fallback()
          end
        end,
      })
      return opts
    end,
  },
}
