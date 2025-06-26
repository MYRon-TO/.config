return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  config = function()

    require("outline").setup {
      preview_window = {
        live = true,
        auto_preview = true,
      },
      -- keymaps = {
      --   -- up_and_jump = 'k',
      --   -- down_and_jump = 'j',
      -- } -- Your setup opts here (leave empty to use defaults)
    }
  end,
}
