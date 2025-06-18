return {
  {
    "CRAG666/code_runner.nvim",
    lazy = true,
    config = function()
      require('code_runner').setup({
        filetype = {
          c = {
            "cd $dir &&",
            "gcc $fileName -o $fileNameWithoutExt &&",
            "time $dir/$fileNameWithoutExt",
          },
          cpp = {
            "cd $dir &&",
            "g++ $fileName -o $fileNameWithoutExt &&",
            "time $dir/$fileNameWithoutExt",
          },
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "time java $fileNameWithoutExt",
          },
          python = "time python3 -u",
          typescript = "time deno run",
          go = "time go run",
          sh = {
            "time bash",
          },
          rust = function()
            return "cd $dir &&"
                .. "rustc $fileName &&"
                .. "time $dir/$fileNameWithoutExt"
          end,
          lua = function()
            return "time lua $fileName"
          end,
          dart = "time dart",
          html = function()
            vim.cmd(":LiveServerStart")
          end,
          markdown = function()
            vim.cmd(":MarkdownPreview")
          end,
          tex = function()
            return "time xelatex $fileName"
          end,
          js = "time node $fileName",
          ts = {
            "time node $fileName",
          },
          typst = {
            "typst compile $fileName",
          },
        },
        project = {

        },
        before_run_filetype = function()
          vim.cmd(":w")
        end,

        mode = "term",
        startinsert = false,
        term = {
          position = "bot"
        },

        filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
        project_path = vim.fn.expand('~/.config/nvim/project_manager.json'),

      })
    end,
    keys = {
      { "<leader><CR>", ":RunCode<CR>", "n" },
    },
    cmd = {
      "CRFiletype",
      "CRProjects",
    },
  },
}
