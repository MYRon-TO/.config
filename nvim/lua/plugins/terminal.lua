local kitty = {
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    version = "*", -- use stable release
    config = function()
      require("kitty-scrollback").setup()
    end,
  }
}

if ENV.enable_kitty_smart_splits then
  table.insert(kitty, {
    'mrjones2014/smart-splits.nvim',
    event = 'VeryLazy',
    dependencies = {
      'pogyomo/submode.nvim',
    },
    config = function()
      -- Resize
      local submode = require 'submode'
      submode.create('WinResize', {
        mode = 'n',
        enter = '<C-w>r',
        leave = { '<Esc>', 'q', '<C-c>' },
        hook = {
          on_enter = function()
            vim.notify 'Use { h, j, k, l } or { <Left>, <Down>, <Up>, <Right> } to resize the window'
          end,
          on_leave = function()
            vim.notify 'Leaved window resize mode'
          end,
        },
        default = function(register)
          register('h', require('smart-splits').resize_left, { desc = 'Resize left' })
          register('j', require('smart-splits').resize_down, { desc = 'Resize down' })
          register('k', require('smart-splits').resize_up, { desc = 'Resize up' })
          register('l', require('smart-splits').resize_right, { desc = 'Resize right' })
          register('<Left>', require('smart-splits').resize_left, { desc = 'Resize left' })
          register('<Down>', require('smart-splits').resize_down, { desc = 'Resize down' })
          register('<Up>', require('smart-splits').resize_up, { desc = 'Resize up' })
          register('<Right>', require('smart-splits').resize_right, { desc = 'Resize right' })
        end,
      })
    end,
  })
end

return {
  -- {
  --   'akinsho/toggleterm.nvim',
  --   version = "*",
  --   lazy = true,
  --   config = function()
  --     require('toggleterm').setup {
  --       winbar = { enabled = true, },
  --       open_mapping = [[<c-t>]],
  --     }
  --     -- vim.cmd[[autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>]]
  --   end,
  --   keys = {
  --     { '<c-t><c-t>', mode = { 't', 'n' }, "<cmd>ToggleTerm direction=float<CR>",      desc = "Toggle Termianal" },
  --     { '<c-t>j',     mode = { 't', 'n' }, "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Termianal" },
  --     { '<c-Esc>',    mode = { 't' },      "<C-\\><C-n>",                              desc = "Normal mode in Termianal" },
  --   },
  -- },
  kitty
}

-- return {
--   {
--     "nvzone/floaterm",
--     dependencies = "nvzone/volt",
--     cmd = "FloatermToggle",
--     opts = {
--       border = false,
--       size = { h = 60, w = 70 },

--       -- to use, make this func(buf)
--       mappings = { sidebar = nil, term = nil },

--       -- Default sets of terminals you'd like to open
--       terminals = {
--         { name = "Terminal" },
--         -- cmd can be function too
--         { name = "Terminal", cmd = "neofetch" },
--         -- More terminals
--       },
--     }
--   },
-- }
