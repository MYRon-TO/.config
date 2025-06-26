-- vim.system({ 'awaken', '--listen' })

vim.lsp.config['awaken'] = {
  -- Command and arguments to start the server.
  cmd = { 'socat', 'STDIO', 'TCP:localhost:9527' },
  -- Filetypes to automatically attach to.
  -- filetypes = { 'txt' },

  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains
  -- root_markers = { '.git' },
}

vim.lsp.enable('awaken')
