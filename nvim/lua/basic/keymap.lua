local map = vim.keymap.set
local opts = { silent = false }
local opts_si = { silent = true }

vim.g.mapleader = ' '

map('n', 'c<space>', 'o<Esc>', opts_si)
map('n', 'cd', '0D', opts_si)
map('n', 'cnh', ':nohl<CR>', opts_si)

map({ 'n', 'v', 'x' }, '<c-j>', '10j', opts_si)
map({ 'n', 'v', 'x' }, '<c-k>', '10k', opts_si)
map({ 'n', 'v', 'x' }, '<c-h>', '10h', opts_si)
map({ 'n', 'v', 'x' }, '<c-l>', '10l', opts_si)

map('n', '<C-w>h', ':set nosplitright<CR>:vsplit<CR>', opts_si)
map('n', '<C-w>l', ':set splitright<CR>:vsplit<CR>', opts_si)
map('n', '<C-w>j', ':set splitbelow<CR>:split<CR>', opts_si)
map('n', '<C-w>k', ':set nosplitright<CR>:split<CR>', opts_si)
map('n', '<LEADER>h', '<C-w>h', opts_si)
map('n', '<LEADER>l', '<C-w>l', opts_si)
map('n', '<LEADER>j', '<C-w>j', opts_si)
map('n', '<LEADER>k', '<C-w>k', opts_si)
map('n', '<LEADER><left>', ':vertical resize-5<CR>', opts_si)
map('n', '<LEADER><right>', ':vertical resize+5<CR>', opts_si)
map('n', '<LEADER><down>', ':res +5<CR>', opts_si)
map('n', '<LEADER><up>', ':res -5<CR>', opts_si)

map('n', '<C-w>t', ':tabe<CR>', opts_si)
map('n', '<LEADER>J', ':-tabnext<CR>', opts_si)
map('n', '<LEADER>K', ':+tabnext<CR>', opts_si)
map('n', '<LEADER>H', ':-tabmove<CR>', opts_si)
map('n', '<LEADER>L', ':+tabmove<CR>', opts_si)

map('n', '<LEADER>F', ':bfirst<CR>', opts_si)
map('n', '<LEADER>B', ':blast<CR>', opts_si)

map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

map({ 'v', 'x' }, 'J', ":m '>+1<CR>gv=gv", opts)
map({ 'v', 'x' }, 'K', ":m '<-2<CR>gv=gv", opts)

map('v', 'y', '"+y', opts)
map('i', '<c-space>', '<c-space>', opts_si)
map('t', '<c-Esc>', '<C-\\><C-n>', opts_si)
