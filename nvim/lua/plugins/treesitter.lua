return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "html",
      "javascript",
      "json",
      "python",
      "rust",
      "sql",
      "toml",
      "typescript",
      "yaml",
    }
    require 'nvim-treesitter'.setup {
      -- Directory to install parsers and queries to
      install_dir = vim.fn.stdpath('data') .. '/site',
    }
    require 'nvim-treesitter'.install(ensure_installed)
  end
}
