local leaderkey = "<c-g>"
-- local SIM = require("patchs/chinese_support/chinese_support")
local MdSnippets = {
  -- { from = leaderkey .. leaderkey, to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l" },
  -- { from = leaderkey .. "l",       to = "---<CR><CR>" },
  -- { from = leaderkey .. "b",       to = " **** <++><Esc>F*hi" },
  -- { from = leaderkey .. "s",       to = " ~~~~ <++><Esc>F~hi" },
  -- { from = leaderkey .. "i",       to = " ** <++><Esc>F*i" },
  -- { from = leaderkey .. "t",       to = "- [ ] " },
  -- { from = leaderkey .. "p",       to = "![](<++>) <++><Esc>F[a" },
  -- { from = leaderkey .. "a",       to = "[](<++>) <++><Esc>F[a" },
  -- { from = leaderkey .. "1",       to = "#<Space><CR><++><Esc>kA" },
  -- { from = leaderkey .. "2",       to = "##<Space><CR><++><Esc>kA" },
  -- { from = leaderkey .. "3",       to = "###<Space><CR><++><Esc>kA" },
  -- { from = leaderkey .. "4",       to = "####<Space><CR><++><Esc>kA" },
  -- { from = leaderkey .. "5",       to = "#####<Space><CR><++><Esc>kA" },
  -- { from = leaderkey .. "6",       to = "######<Space><CR><++><Esc>kA" },
  {
    from = leaderkey .. "m",
    to = function()
      -- SIM.ToEnglish()
      vim.api.nvim_feedkeys(" $$ <++>\x1bF$i", "i", false)
    end
  },
  {
    from = leaderkey .. "M",
    to = function()
      -- SIM.ToEnglish()
      vim.api.nvim_feedkeys("$$\n$$\n<++>\x1b?\\$\\$\n:nohlsearch\nO", "i", false)
    end
  },
  {
    from = leaderkey .. "c",
    to = function()
      -- SIM.ToEnglish()
      vim.api.nvim_feedkeys(" `` <++>\x1bF`i", "i", false)
    end
  },
  {
    from = leaderkey .. "C",
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

