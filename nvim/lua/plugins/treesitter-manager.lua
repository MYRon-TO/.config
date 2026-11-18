return {
  "romus204/tree-sitter-manager.nvim",
  lazy = false,
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "sql",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    auto_install = true,
  },
  config = function(_, opts)
    require("tree-sitter-manager").setup(opts)
  end,
}
