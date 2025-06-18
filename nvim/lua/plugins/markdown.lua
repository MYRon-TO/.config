return {
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   lazy = true,
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && yarn install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
  {
    'Kicamon/markdown-table-mode.nvim',
    lazy = true,
    ft = { 'markdown', 'txt' },
    config = function()
      require('markdown-table-mode').setup({
        options = {
          insert = false, -- when typeing "|"
          insert_leave = true, -- when leaveing insert
        },
      })
    end
  },
  {
    "bullets-vim/bullets.vim",
    lazy = true,
    ft = { "markdown", "txt" },
    config = function()
      vim.cmd [[
        let g:bullets_set_mappings = 0

        " \ ['inoremap', '<cr>', '<cr>'],
        let g:bullets_custom_mappings = [
          \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
          \ ['inoremap', '<C-cr>', '<cr>'],
          \
          \ ['nmap', 'o', '<Plug>(bullets-newline)'],
          \
          \ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
          \ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
          \
          \ ['imap', '<C-t>', '<Plug>(bullets-demote)'],
          \ ['nmap', '>>', '<Plug>(bullets-demote)'],
          \ ['vmap', '>', '<Plug>(bullets-demote)'],
          \ ['imap', '<C-d>', '<Plug>(bullets-promote)'],
          \ ['nmap', '<<', '<Plug>(bullets-promote)'],
          \ ['vmap', '<', '<Plug>(bullets-promote)'],
          \ ]
      ]]
    end,
  },
}
