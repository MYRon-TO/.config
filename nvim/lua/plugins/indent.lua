local Color = "#cba6f7"
local ErrorColor = "#ff5555"
-- local Color = "#8DD8CA"
-- local ErrorColor = "#ff2222"
return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = true,
          use_treesitter = true,
          -- excluded_filetypes = {"*.dart"},
          notify = true,           -- notify if some situation(like disable chunk mod double time)
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          style = {
            { fg = Color },
            { fg = ErrorColor },
          },
        },

        indent = {
          enable = true,
          use_treesitter = false,
          chars = {
            "│",
            -- "¦",
            -- "┆",
            "┊",
          },
          style = {
            { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") }
          },
        },

        line_num = {
          enable = true,
          use_treesitter = true,
          style = Color,
        },

        blank = {
          enable = false,
        },
      }
    end,
  },
  -- {
  --     "lukas-reineke/indent-blankline.nvim",
  --     config = function ()
  --         vim.opt.list = true
  --         -- vim.opt.listchars:append "space:⋅"
  --         vim.opt.listchars:append "eol:↴"
  --         require("indent_blankline").setup {
  --             char = "│",
  --             space_char_blankline = " ",
  --             show_current_context = true,
  --             show_current_context_start = false,
  --             vim.cmd ([[
  --                 highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine
  --                 " highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline
  --             ]])
  --         }
  --     end,
  -- },
}
