local copilot = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = false },
  },
}

local mcp = {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
    config = function()
      require("mcphub").setup({
        use_bundled_binary = true, -- Use local `mcp-hub` binary
      })
    end,
  }
}

local companion = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    {
      "HakonHarnes/img-clip.nvim",
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim"
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" }, noremap = true, silent = true },
    { "<leader>ad", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, noremap = true, silent = true },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, noremap = true, silent = true },
    -- ga in visual mode
    { "ga",         "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          noremap = true, silent = true },
  },
  opts = {
    language = "Simplified Chinese",
    send_code = true,
    prompt_library = {
      ["Code Review by Linus"] = {
        strategy = "chat",
        description = "以 Linus Torvalds 的方式严厉的批判你的代码",
        opts = {
          ignore_system_prompt = true,
        },
        prompts = {
          {
            role = "system",
            content = require("env/prompt/code_review_by_linus")
          },
        },
      },
    },
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          model = "claude-sonnet-4",
        },
        opts = {
          system_prompt = require("env/prompt/system_prompt"),
        }
      },
      inline = {
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            opts = { nowait = true },
            description = "Reject the suggested change",
          },
        },
      },
    },
    display = {
      diff = {
        enabled = true,
        provider = "mini_diff", -- mini_diff|split|inline
      },
      chat = {
        -- Options to customize the UI of the chat buffer
        window = {
          -- layout = "vertical", -- float|vertical|horizontal|buffer
          layout = "float", -- float|vertical|horizontal|buffer
          -- width = 0.25,
          border = "single",
        },
      },
      action_palette = {
        prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
        provider = "telescope",               -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true,        -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          title = "CodeCompanion actions",    -- The title of the action palette
        },
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      }
    }
  },
}

return {
  copilot,
  mcp,
  companion
}
