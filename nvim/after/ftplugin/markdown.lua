local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node

local function markdown_keymap(key, value)
  vim.keymap.set("i", key, function()
    ls.snip_expand(value)
  end, { buffer = true, silent = true }) -- 不要 expr = true
end

local function snip_around_with(arround)
  return s("", { t(arround), i(1), t(arround) })
end

markdown_keymap("<C-p>b", snip_around_with("**"))
markdown_keymap("<C-p>i", snip_around_with("*"))
markdown_keymap("<C-p>c", snip_around_with("`"))
markdown_keymap("<C-p>C", s("", { t("```"), i(1), t({ "", "" }), i(2), t({ "", "```" }) }))
markdown_keymap("<C-p>m", snip_around_with("$"))
markdown_keymap("<C-p>M", s("", { t("$$"), t({ "", "" }), i(1), t({ "", "$$" }) }))
