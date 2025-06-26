local default_formatters = {
  "prettierd",
  "prettier",
  stop_after_first = true,
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {

      -- * config/data
      json = { "dprint" },
      toml = { "dprint" },

      -- * web
      -- ** xml
      xml = default_formatters,
      html = default_formatters,
      svelte = { "prettierd" },
      -- ** css
      css = default_formatters,
      scss = default_formatters,
      -- ** js/ts
      javascript = default_formatters,
      typescript = default_formatters,

      -- * markup
      latex = { "latexindent" },
      tex = { "latexindent" },
      ["markdown"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },

      -- * code
      lua = { "stylua" },
      python = { "isort", "black" }, -- isort first, then black
      shell = { "shfmt" },

      -- rust = { "dprint", "rustfmt", stop_after_first = true },
      rust = { "rustfmt", stop_after_first = true },

    },
    -- Set up format-on-save
    -- format_on_save = { timeout_ms = 500, lsp_fallback = true },

    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
