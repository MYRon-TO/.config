local nvim_lspconfig = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  -- init = function()
  --   local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
  --   vim.opt.runtimepath:prepend(lspConfigPath)
  -- end,
}

function nvim_lspconfig.config()
  local lsp = {
    "lua_ls",
    "clangd",
    "basedpyright",
    -- "texlab",
    "tinymist",
  }

  vim.lsp.enable(lsp)

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      -- vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      -- vim.keymap.set('n', '<space>f', function()
      --     vim.lsp.buf.format { async = true }
      -- end, opts)
    end,
  })
end

local mason = {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    cmd = { "Mason" },
    lazy = true,
    config = function()
      require("mason").setup()
      local mason_packages = {
        "sqlfmt",      -- SQL
        "isort",       -- Python
        "black",       -- Python
        "latexindent", -- tex
        "prettierd",

        "rust-analyzer",
        "basedpyright",
        "lua-language-server",
        "tinymist",
      }
      local function ensure_installed(packages)
        local registry = require("mason-registry")

        for _, pkg_name in ipairs(packages) do
          if registry.has_package(pkg_name) then
            local pkg = registry.get_package(pkg_name)
            if not pkg:is_installed() then
              pkg:install()
              vim.notify(
                "Installing " .. pkg_name .. " via mason.nvim",
                vim.log.levels.INFO
              )
            end
          else
            vim.notify(
              "Package " .. pkg_name .. " not found in registry",
              vim.log.levels.WARN
            )
          end
        end
      end

      vim.defer_fn(function()
        require("mason-registry").refresh(function()
          ensure_installed(mason_packages)
        end)
      end, 200)
    end,
  },
}

local action_preview = {
  "aznhe21/actions-preview.nvim",
  lazy = true,
  keys = {
    {
      "<leader>fa",
      function() require("actions-preview").code_actions() end,
      mode = { "n", "v" },
      desc = "Actions Preview",
    },
  },
  config = function()
    require("actions-preview").setup {

      highlight_command = {
        require("actions-preview.highlight").delta(ENV.delta_path),
      },

      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    }
  end,
}

return {
  mason,
  nvim_lspconfig,
  action_preview,
}
