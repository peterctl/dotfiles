return {
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    opts = {
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
    },
    keys = {
      { "<leader>aM", "<cmd>MCPHub<cr>", desc = "MCP Hub" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "yetone/avante.nvim",
    opts = {
      provider = "opencode",
      acp_providers = {
        opencode = {
          command = "opencode",
          args = { "acp" },
        },
      },
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
  },
}
