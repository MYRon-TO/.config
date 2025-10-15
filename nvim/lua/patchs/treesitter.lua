local ts = require("nvim-treesitter")

-- 收集所有可安装的语言
local available_langs = ts.get_available()

-- 收集它们的 filetype
local supported_filetypes = {}
for _, lang in ipairs(available_langs) do
  local ok, parser = pcall(function()
    return vim.treesitter.language.get_lang(lang)
  end)
  if ok and parser then
    -- 注意：不是所有 lang 都有对应 ft，这里用 nvim 内置映射
    local fts = vim.treesitter.language.get_filetypes(lang)
    for _, ft in ipairs(fts) do
      table.insert(supported_filetypes, ft)
    end
  end
end

-- 去重
local dedup, unique_filetypes = {}, {}
for _, ft in ipairs(supported_filetypes) do
  if not dedup[ft] then
    table.insert(unique_filetypes, ft)
    dedup[ft] = true
  end
end

-- 注册自动命令
vim.api.nvim_create_autocmd("FileType", {
  pattern = unique_filetypes,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if lang and not vim.tbl_contains(ts.get_installed("parsers"), lang) then
      -- 异步安装缺失的 parser
      ts.install { lang }
    end

    -- 启动 treesitter 语法高亮
    pcall(vim.treesitter.start, args.buf, lang)
  end,
})
