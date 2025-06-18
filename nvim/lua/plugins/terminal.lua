return {
  'akinsho/toggleterm.nvim',
  version = "*",
  lazy = true,
  config = function()
    local map = vim.keymap.set
    map('t', '<c-Esc>', '<C-\\><C-n>', { noremap = true })
    map({'n','t'}, '<c-\\><c-\\>','<cmd>ToggleTerm direction=float<CR>')

    require('toggleterm').setup {
      winbar = { enabled = true, }
    }
  end,
  keys = {
    '<c-\\><c-\\>',
  }
}
