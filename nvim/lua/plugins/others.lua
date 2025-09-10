return {
  {
    "nvim-lua/plenary.nvim", branch = "master"
  },
  {
    "willothy/flatten.nvim",
    -- A plugin that avoids nested opening of nvim
    -- config = true,
    -- or pass configuration with
    opts = { window = { open = "alternate" } },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    event = "VeryLazy",
    priority = 1001,
  },
  -- {
  --   'nvim-tree/nvim-web-devicons',
  --   lazy = true,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    event = "UIEnter",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_filetypes = {
        ["mcphub"] = true,
        ["Outline"] = true,
      }
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  -- {
  --   "kawre/leetcode.nvim",
  --   -- event = "VeryLazy",
  --   build = ":TSUpdate html",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim", -- telescope 所需
  --     "MunifTanjim/nui.nvim",

  --     -- 可选
  --     "nvim-treesitter/nvim-treesitter",
  --     "rcarriga/nvim-notify",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   opts = {
  --     -- 配置放在这里
  --     arg = "leetcode",
  --     cn = {
  --       enabled = true,
  --     },
  --     injector = { ---@type table<lc.lang, lc.inject>
  --       ["python3"] = {
  --         before = true
  --       },
  --       ["cpp"] = {
  --         before = { "#include <bits/stdc++.h>", "using namespace std;" },
  --         after = "int main() {}",
  --       }
  --     },
  --     image_support = false,
  --   },
  -- }
}
