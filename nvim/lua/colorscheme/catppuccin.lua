return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      -- flavour = "latte", -- latte, frappe, macchiato, mocha
      -- flavour = "frappe", -- latte, frappe, macchiato, mocha
      -- flavour = "macchiato", -- latte, frappe, macchiato, mocha
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {     -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
      term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,              -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,            -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,              -- Force no italic
      no_bold = false,                -- Force no bold
      no_underline = false,           -- Force no underline
      styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },      -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {
        mocha = {
          base = "#191929",
          -- surface0 = "#1e1e2e"
        }
      },
      custom_highlights = function(colors)
        return {
          CmpCopilot            = { fg = colors.sky },
          -- BlinkCmpMenu = { bg = colors.surface0 },
          -- BlinkCmpMenuBorder = { fg = colors.text, bg = colors.surface0 },

          BlinkCmpMenu          = { bg = colors.base },
          BlinkCmpMenuBorder    = { fg = colors.lavender, bg = colors.base },
          BlinkCmpMenuSelection = { fg = colors.text, bg = "#313244" },
          NoicePopupBorder      = { fg = colors.lavender },

          SnacksIndentScope1 = { fg = colors.pink},
          SnacksIndentScope2 = { fg = colors.peach},
          SnacksIndentScope3 = { fg = colors.yellow},
          SnacksIndentScope4 = { fg = colors.green},
          SnacksIndentScope5 = { fg = colors.teal},
          SnacksIndentChunk = { fg = colors.subtext1}
        }
      end,
      integrations = {
        cmp = false,
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        dap = true,
        dap_ui = true,
        telescope = {
          enabled = true,
          -- styles = "nvchad"
        },
        flash = true,
        notify = true,
        noice = true,
        treesitter = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })
    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
  end
}
