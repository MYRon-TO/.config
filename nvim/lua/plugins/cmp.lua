-- for rime_ls
vim.opt.iskeyword = "_,49-57,A-Z,a-z"

local luasnip = {
  'L3MON4D3/LuaSnip',
  -- version = "v2.*",
  dependencies = { "rafamadriz/friendly-snippets" }, -- 可选
  config = function()
    local ls = require("luasnip")

    -- 加载 vscode 风格的 snippets（如 friendly-snippets）
    require("luasnip.loaders.from_vscode").lazy_load()

    -- 加载你自己写的 snippets
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
  end,
}

local blink = {
  'saghen/blink.cmp',
  lazy = true,
  event = { "InsertEnter", "CmdlineEnter" },
  -- optional: provides snippets for the snippet source
  dependencies = {
    -- 'rafamadriz/friendly-snippets',
    "kdheepak/cmp-latex-symbols",
    -- 'Kaiser-Yang/blink-cmp-avante',
    luasnip,
    {
      'nvim-tree/nvim-web-devicons',
      opts = {
        variant = "dark",
      }
    },
    -- 'onsails/lspkind.nvim',
    "fang2hou/blink-copilot",
  },
  -- use a release tag to download pre-built binaries
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    snippets = {
      preset = 'luasnip'
    },

    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      ---@alias preset "defualt" | "super-tab"| "enter"
      preset = "enter",

      ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-p>'] = { 'fallback' },
      ['<C-n>'] = { 'fallback' },
      ['<C-space>'] = { 'fallback' },
    },

    cmdline = {
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = false },
      },
      keymap = {
        preset = 'none',
        ['<C-j>'] = {
          'show_and_insert',
          'select_next',
        },
        ['<C-k>'] = { 'show_and_insert', 'select_prev' },

        ['<Tab>'] = { 'accept' },
        ['<CR>'] = { 'fallback' },
        ['<C-e>'] = { 'cancel' },
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = { window = { border = 'rounded' } },
      menu = {
        border = 'rounded',
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
        }
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true
        }
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        "lazydev",
        "copilot",
        "lsp",
        "path",
        "snippets",
        "buffer",
        "latex_symbols",
      },
      providers = {
        lsp = {
          score_offset = 0,
          transform_items = function(_, items)
            -- the default transformer will do this
            for _, item in ipairs(items) do
              if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
                item.score_offset = item.score_offset - 3
              end
            end
            -- you can define your own filter for rime item
            return items
          end
        },
        snippets = {
          module = 'blink.cmp.sources.snippets',
          score_offset = -1,
          -- score_offset = -1, -- receives a -3 from top level snippets.score_offset

          -- For `snippets.preset == 'luasnip'`
          opts = {
            -- Whether to use show_condition for filtering snippets
            use_show_condition = true,
            -- Whether to show autosnippets in the completion list
            show_autosnippets = true,
            -- Whether to prefer docTrig placeholders over trig when expanding regTrig snippets
            prefer_doc_trig = false,
          }

          -- -- For `snippets.preset == 'default'`
          -- opts = {
          -- friendly_snippets = true,
          -- search_paths = { vim.fn.stdpath('config') .. '/snippets' },
          -- extended_filetypes = {},
          -- ignored_filetypes = {},
          -- -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
          -- clipboard_register = '+',
          -- }
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        latex_symbols = {
          name = 'latex_symbols',
          module = "blink.compat.source",
          score_offset = 100,
          opts = {
          },
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = -99,
          async = true,
          opts = {
            -- Local options override global ones
            max_completions = 3, -- Override global max_completions

            -- Final settings:
            -- * max_completions = 3
            -- * max_attempts = 2
            -- * all other options are default
          }
        },
      },
    },
  },
  opts_extend = { "sources.default" }
}

local blink_compat = {
  'saghen/blink.compat',
  -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
  version = '*',
  -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
  lazy = true,
  -- make sure to set opts so that lazy.nvim calls blink.compat's setup
  opts = {},
}

local lazydev = {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

return {
  blink_compat,
  blink,
  lazydev
}
