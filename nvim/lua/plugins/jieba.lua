return {
  {
    "kkew3/jieba.vim",
    branch = "release",
    build = ":call jieba_vim#install()",
    lazy = false,
    dependencies = { "tpope/vim-repeat" },
    init = function()
      vim.g.jieba_vim_keymap = 0
    end,
    config = function()
      -- 按词移动覆盖普通、可视和操作符等待模式。
      for _, motion in ipairs({ "w", "W", "e", "E", "b", "B", "ge", "gE" }) do
        vim.keymap.set({ "n", "x", "o" }, motion, "<Plug>(Jieba_" .. motion .. ")", {
          remap = true,
          silent = true,
        })
      end
      for _, object in ipairs({ "iw", "aw" }) do
        vim.keymap.set({ "x", "o" }, object, "<Plug>(Jieba_" .. object .. ")", {
          remap = true,
          silent = true,
        })
      end
    end,
  },
}
