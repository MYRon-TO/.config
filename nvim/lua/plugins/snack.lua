---@class snacks.indent.Config
---@field enabled? boolean
local indent = {
  enabled = true,
  scope = {
    enabled = true, -- enable highlighting the current scope
    priority = 200,
    char = "│",
    underline = false,    -- underline the start of the scope
    only_current = false, -- only show scope in the current window
    hl = {
      "SnacksIndentScope1",
      "SnacksIndentScope2",
      "SnacksIndentScope3",
      "SnacksIndentScope4",
      "SnacksIndentScope5",
    }, ---@type string|string[] hl group for scopes
  },
}

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>..", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
      { "<leader>.,", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = indent,
      input = { enabled = true },
      lazygit = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    init = function()
      vim.api.nvim_create_user_command("LazyGit", function()
        Snacks.lazygit()
      end, { desc = "Open LazyGit (Snacks)" })
    end,
  }
}
