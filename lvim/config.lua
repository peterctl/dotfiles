--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

vim.opt.relativenumber = true

-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "onedarker"

-- Keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.local_leader = "\\"

-- WhichKey mappings
lvim.builtin.which_key.on_config_done = function (wk)
  for _, mode in ipairs({ "n", "x" }) do
    wk.register({
      -- Mappings for Hop
      s = {
        name = "+Hop Motions",
        a = { function() require("hop").hint_char1() end, "Hop search 1 character" },
        s = { function() require("hop").hint_char2() end, "Hop search 2 characters" },
        w = { function() require("hop").hint_words() end, "Hop search words" },
        l = { function() require("hop").hint_lines_skip_whitespace() end, "Hop search lines ( ^ )" },
        L = { function() require("hop").hint_lines() end, "Hop search lines ( 0 )" },
        ["/"] = { function() require("hop").hint_pattern() end, "Hop search pattern" },
      },
    }, { prefix = nil, mode = mode })
  end
  wk.register({
    -- Mappings for surround.nvim
    S = {
      name = "+Surround",
      a = { "<Cmd>set operatorfunc=SurroundAddOperatorMode<CR>g@", "Add" },
      d = { function() require("surround").surround_delete() end, "Delete" },
      r = { function() require("surround").surround_replace() end, "Replace" },
      S = { function() require("surround").repeat_last() end, "Repeat last" },
      t = {
        name = "+Toggle",
        b = {
          function() require("surround").toggle_brackets(0) end,
          "Toggle Brackets"
        },
        B = {
          function() require("surround").toggle_brackets(1) end,
          "Toggle Brackets"
        },
        q = {
          function() require("surround").toggle_quotes() end,
          "Toggle Quotes"
        },
      },
    },
  }, { prefix = nil, mode = "n" })
end
lvim.builtin.which_key.mappings["l"]["D"] = {
  function()
    vim.lsp.diagnostic.show_line_diagnostics({
      show_header = false, border = "single"
    })
  end,
  "Show line diagnostics",
}

-- After changing plugin config: exit and reopen LunarVim, then
-- run :PackerInstall :PackerCompile to update the plugins.

-- Additional Plugins
lvim.plugins = {
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  {
    "glepnir/lspsaga.nvim",
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({
          icons = { expanded = "⯆", collapsed = "⯈" },
          mappings = {
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              edit = "e"
          },
          sidebar = {
              elements = { "scopes", "breakpoints", "stacks", "watches" },
              size = 40,
              position = "left"
          },
          tray = {
              elements = { "repl" },
              size = 10,
              position = "bottom"
          },
          floating = { max_height = nil, max_width = nil }
      })
      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.after.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()
    end,
  },
  {
    "blackCauldron7/surround.nvim",
    config = function()
      require("surround").setup({
        load_keymaps = false, -- These are loaded above manually
      })
      vim.api.nvim_set_keymap(
        "v", "S", "<Esc>gv<Cmd>lua require('surround').surround_add()<CR>",
        { noremap = true }
      )
    end,
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
    end,
  },
}

lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.project.active = false
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- Turn on wrapping on the quickfix window
  { "FileType", "qf", "setlocal wrap" },
}

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }
