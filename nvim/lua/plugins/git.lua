return {
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    -- keys = {
    --   { "clg", ":LazyGit<CR>", "n" },
    -- },
    cmd = {"LazyGit"}
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    -- event = "UIEnter"
  },
}
