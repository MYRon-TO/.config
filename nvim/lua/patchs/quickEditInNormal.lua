local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<c-w>', 'diw', opts)
map('n', '<c-c>', 'ciw', opts)

