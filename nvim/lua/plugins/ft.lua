local rust = {
  {
    'mrcjkb/rustaceanvim',
    lazy = true,
    ft = { 'rust' },
  },
  -- {
  --   'cordx56/rustowl',
  --   version = '*', -- Latest stable version
  --   build = 'cargo binstall rustowl',
  --   lazy = true,   -- This plugin is already lazy
  --   ft = { 'rust' },
  --   opts = {
  --     client = {
  --       on_attach = function(_, buffer)
  --         vim.keymap.set('n', '<leader>r', function()
  --           require('rustowl').toggle(buffer)
  --         end, { buffer = buffer, desc = 'Toggle RustOwl' })
  --       end
  --     },
  --   },
  -- }
}

local haskell = {
  'mrcjkb/haskell-tools.nvim',
  version = '^4', -- Recommended
  lazy = false,   -- This plugin is already lazy
  ft = { 'haskell' },
}

local tex = {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
}

local flutter = {
  'akinsho/flutter-tools.nvim',
  lazy = true,
  ft = { 'dart' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    -- alternatively you can override the default configs
    require("flutter-tools").setup {
      lsp = {
      }
    }
  end,
}

return {
  rust,
  haskell,
  -- tex,
  flutter,
}
