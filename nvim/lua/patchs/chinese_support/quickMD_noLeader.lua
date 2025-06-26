-- local leaderkey = "<c-g>"

-- local SIM = require("patchs/chinese_support/chinese_support")
local MdSnippets = {
  { from =  "<c-g><c-g>", to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l" },
  { from =  "<c-l>",       to = "---<CR><CR>" },
  { from =  "<c-b>",       to = " **** <++><Esc>F*hi" },
  { from =  "<c-s>",       to = " ~~~~ <++><Esc>F~hi" },
  { from =  "<c-u>",       to = " ** <++><Esc>F*i" },
  -- { from =  "<c-t>",       to = "- [ ] " },
  -- { from =  "<c-p>",       to = "![](<++>) <++><Esc>F[a" },
  { from =  "<c-a>",       to = "[](<++>) <++><Esc>F[a" },
  { from =  "<c-1>",       to = "#<Space><Esc>A" },
  { from =  "<c-2>",       to = "##<Space><Esc>A" },
  { from =  "<c-3>",       to = "###<Space><Esc>A" },
  { from =  "<c-4>",       to = "####<Space><Esc>A" },
  { from =  "<c-5>",       to = "#####<Space><Esc>A" },
  { from =  "<c-6>",       to = "######<Space><Esc>A" },
  {
    from = "<c-l>",
    to = function()
      -- SIM.ToEnglish()
      vim.api.nvim_feedkeys(" $$ <++>\x1bF$i", "i", false)
    end
  },
  {
    from = "<c-m-l>",
    to = function()
      -- SIM.ToEnglish()
      vim.api.nvim_feedkeys("$$\n$$\n<++>\x1b?\\$\\$\n:nohlsearch\nO", "i", false)
    end
  },
  {
    from = "<c-c>",
    to = function()
      -- SIM.ToEnglish()
      vim.api.nvim_feedkeys(" `` <++>\x1bF`i", "i", false)
    end
  },
  {
    from = "<c-M-c>",
    to = function()
      vim.api.nvim_feedkeys("```\n```\n<++>\x1b?```\n:nohlsearch\nO", "i", false)
      -- SIM.ToEnglish()
    end
  },
}

local MdMapping = function()
  for _, mapping in ipairs(MdSnippets) do
    vim.keymap.set("i", mapping.from, mapping.to, { noremap = true, buffer = true })
  end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { '*.md' },
  callback = function()
    MdMapping()
  end
})

