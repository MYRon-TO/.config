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
    -- 在缺少 vim.list.unique 的 Neovim 中兼容插件的依赖展开。
    -- if not (vim.list and vim.list.unique) then
    --   vim.list = vim.list or {}
    --   -- 原地去重并保留顺序，兼容安装器和界面的调用。
    --   vim.list.unique = function(list)
    --     local seen, index = {}, 1
    --     for _, value in ipairs(list) do
    --       if not seen[value] then
    --         seen[value] = true
    --         list[index] = value
    --         index = index + 1
    --       end
    --     end
    --     for i = #list, index, -1 do
    --       list[i] = nil
    --     end
    --     return list
    --   end
    --   local config = require("tree-sitter-manager.config")
    --   require("tree-sitter-manager.util").get_requires = function(lang)
    --     local deps, seen = {}, { [lang] = true }
    --     local function collect(name)
    --       local entry = config.effective_repos[name]
    --       for _, dep in ipairs(type(entry) == "table" and entry.requires or {}) do
    --         if not seen[dep] then
    --           seen[dep] = true
    --           deps[#deps + 1] = dep
    --           collect(dep)
    --         end
    --       end
    --     end
    --     collect(lang)
    --     return deps
    --   end
    -- end
    require("tree-sitter-manager").setup(opts)
  end,
}
