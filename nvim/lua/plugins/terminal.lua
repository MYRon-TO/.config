return {
  'akinsho/toggleterm.nvim',
  version = "*",
  lazy = true,
  config = function()
    require('toggleterm').setup {
      winbar = { enabled = true, },
      open_mapping = [[<c-t>]],
    }
    -- vim.cmd[[autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>]]
  end,
  keys = {
    { '<c-t><c-t>', mode = { 't', 'n' }, "<cmd>ToggleTerm direction=float<CR>",      desc = "Toggle Termianal" },
    { '<c-t>j',     mode = { 't', 'n' }, "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Termianal" },
    { '<c-Esc>',    mode = { 't' },      "<C-\\><C-n>",                              desc = "Normal mode in Termianal" },
  }
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
