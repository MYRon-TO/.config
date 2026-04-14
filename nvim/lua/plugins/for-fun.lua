return {
  {
    -- A plugin make an Code rain
    "Eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = {
      {
        "<leader>fr",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Make it rain",
      }
    },
    cmd = {
      "CellularAutomaton make_it_rain",
      "CellularAutomaton game_of_life",
    },
  },
  {
    "jbyuki/venn.nvim",
    lazy = true,
    keys = {
      {
        "<leader>v",
        function()
          if not vim.b.venn_enabled then
            vim.b.venn_enabled = true
            vim.opt_local.virtualedit = "all"
            vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { buffer = true, noremap = true })
            vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { buffer = true, noremap = true })
            vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { buffer = true, noremap = true })
            vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { buffer = true, noremap = true })
            vim.keymap.set("v", "f", ":VBox<CR>", { buffer = true, noremap = true })
          else
            vim.opt_local.virtualedit = ""
            vim.keymap.del("n", "J", { buffer = 0 })
            vim.keymap.del("n", "K", { buffer = 0 })
            vim.keymap.del("n", "L", { buffer = 0 })
            vim.keymap.del("n", "H", { buffer = 0 })
            vim.keymap.del("v", "f", { buffer = 0 })
            vim.b.venn_enabled = nil
          end
        end,
      },
    },
  }
}
