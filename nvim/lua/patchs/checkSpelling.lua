vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { '*.md', '*.txt', '*.tex' },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en_us'
  end
})
