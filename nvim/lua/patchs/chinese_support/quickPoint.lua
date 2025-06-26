local leaderkey = "<c-p>"

local fullPoint = {
    { from = leaderkey .. ",",       to = "，"    },
    { from = leaderkey .. ".",       to = "。"    },
    { from = leaderkey .. ";",       to = "；"    },
    { from = leaderkey .. ":",       to = "："    },
    { from = leaderkey .. "<",       to = "《"    },
    { from = leaderkey .. ">",       to = "》"    },
    { from = leaderkey .. "|",       to = "·"     },
    { from = leaderkey .. "^",       to = "……"    },
    { from = leaderkey .. "\\",      to = "、"    },
    { from = leaderkey .. "`",      to = "·"    },
    { from = leaderkey .. "?",      to = "？"    },
    { from = leaderkey .. "\"",      to = "“”"    },
    { from = leaderkey .. "(",      to = "（"    },
    { from = leaderkey .. ")",      to = "）"    },

}

local quickFullPoint = function()
    vim.keymap.set({"i", "c"}, leaderkey, "", { noremap = true, buffer = true })
    for _, mapping in ipairs(fullPoint) do
        vim.keymap.set({"i", "c"}, mapping.from, mapping.to, { noremap = true, buffer = true })
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    -- pattern = { '*' },
    callback = function()
        quickFullPoint()
    end
})
