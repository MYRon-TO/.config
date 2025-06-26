return {
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup(
        {
          -- Add custom surroundings to be used on top of builtin ones. For more
          -- information with examples, see `:h MiniSurround.config`.
          custom_surroundings = nil,

          mappings = {
            add = '<CR>a',            -- Add surrounding in Normal and Visual modes
            delete = '<CR>d',         -- Delete surrounding
            find = '<CR>f',           -- Find surrounding (to the right)
            find_left = '<CR>F',      -- Find surrounding (to the left)
            highlight = '<CR>h',      -- Highlight surrounding
            replace = '<CR>r',        -- Replace surrounding
            update_n_lines = '<CR>n', -- Update `n_lines`

            suffix_last = 'l',     -- Suffix to search with "prev" method
            suffix_next = 'n',     -- Suffix to search with "next" method
          },

          -- Number of lines within which surrounding is searched
          n_lines = 30,

          -- Whether to respect selection type:
          -- - Place surroundings on separate lines in linewise mode.
          -- - Place surroundings on each line in blockwise mode.
          respect_selection_type = false,

          -- How to search for surrounding (first inside current line, then inside
          -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
          -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
          -- see `:h MiniSurround.config`.
          search_method = 'cover',

          -- Whether to disable showing non-error feedback
          -- This also affects (purely informational) helper messages shown after
          -- idle time if user input is required.
          silent = false,
        })
    end
  },

  -- {
  --   "sustech-data/wildfire.nvim",
  --   lazy = true,
  --   keys = { "<CR>" },
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require("wildfire").setup({
  --       surrounds = {
  --         { "(", ")" },
  --         { "{", "}" },
  --         { "<", ">" },
  --         { "[", "]" },
  --         { "`", "`" },
  --       },
  --       keymaps = {
  --         init_selection = "<CR>",
  --         node_incremental = "<CR>",
  --         node_decremental = "<BS>",
  --       },
  --       -- filetype_exclude = { "qf" }, --keymaps will be unset in excluding filetypes
  --       filetype_exclude = {}, --keymaps will be unset in excluding filetypes
  --     })
  --   end,
  -- },
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*",   -- Use for stability; omit to use `main` branch for the latest features
  --   lazy = true,
  --   event = "VeryLazy",
  --   config = function()
  --     require("nvim-surround").setup({
  --       -- Configuration here, or leave empty to use defaults
  --       keymaps = {
  --         insert = "<C-g>r",
  --         insert_line = "<C-g>R",
  --         normal = "yr",
  --         normal_cur = "yrr",
  --         normal_line = "yR",
  --         normal_cur_line = "yRR",
  --         visual = "yr",
  --         visual_line = "yR",
  --         delete = "dr",
  --         change = "cr",
  --         change_line = "cR",
  --       },
  --     })
  --   end
  -- },
}
