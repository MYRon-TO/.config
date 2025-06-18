local telescope = {
  'nvim-telescope/telescope.nvim',
  -- tag = '0.1.3',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  lazy = true,
  event = "VeryLazy",
  keys = {
    { '<leader>fh',
      require('telescope.builtin').help_tags
    },
    { '<leader>fb',
      require('telescope.builtin').buffers
    },
    {
      '<leader>fg',
      require('telescope.builtin').live_grep
    },
    {
      "<leader>ff",
      require('telescope.builtin').git_files
    },
    {
      -- Warning: relative with plugin folke/todo-comments.nvim
      "<leader>ft",
      "<cmd>Telescope todo-comments todo<cr>",
      desc = "Find TODO",
    },
  },

  config = function()
    require('telescope').setup {
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<c-j>"] = require('telescope.actions').move_selection_next,
            ["<c-k>"] = require('telescope.actions').move_selection_previous,
            ["<esc>"] = require('telescope.actions').close,
            ["<cr>"] = require('telescope.actions').select_default + require('telescope.actions').center,
          }
        }
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        find_files = {
          -- theme = "ivy",
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      },
    }
    require('telescope').load_extension('fzf')
  end
}


local yank = {
  "gbprod/yanky.nvim",
  dependencies = {
    -- "kkharji/sqlite.lua",
    'nvim-telescope/telescope.nvim',
  },
  lazy = true,
  config = function()
    local mapping = require("yanky.telescope.mapping")
    local utils = require("yanky.utils")
    require("yanky").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
      },
      picker = {
        select = {
          action = nil, -- nil to use default put action
        },
        telescope = {
          use_default_mappings = false, -- if default mappings should be used
          mappings = {
            i = {
              ["<cr>"] = mapping.put("p"),
              ["<c-cr>"] = mapping.put("P"),
              ["<c-x>"] = mapping.delete(),
              ["<c-r>"] = mapping.set_register(utils.get_default_register()),
            },
          }
        },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    })
    require("telescope").load_extension("yank_history")
  end,
  keys = {
    { "p",         "<Plug>(YankyPutAfter)",       mode = { "n", "x" } },
    { "P",         "<Plug>(YankyPutBefore)",      mode = { "n", "x" } },
    { "gp",        "<Plug>(YankyGPutAfter)",      mode = { "n", "x" } },
    { "gP",        "<Plug>(YankyGPutBefore)",     mode = { "n", "x" } },
    { "<leader>y", ":Telescope yank_history<CR>", mode = { "n", "x" } },
  }
}

local trouble = {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },

    config = function()
      local actions = require("telescope.actions")
      local open_with_trouble = require("trouble.sources.telescope").open

      -- Use this to add more results without clearing the trouble list
      -- local add_to_trouble = require("trouble.sources.telescope").add

      local tel = require("telescope")

      tel.setup({
        defaults = {
          mappings = {
            i = { ["<c-t>"] = open_with_trouble },
            n = { ["<c-t>"] = open_with_trouble },
          },
        },
      })

      require("trouble").setup({
        signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "",
        },
      })
    end,
  }
}


return { telescope, yank, trouble }
