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
    "ravitemer/mcphub.nvim",
    "ravitemer/codecompanion-history.nvim",
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
      ["Code With Socratic Teacher"] = {
        strategy = "chat",
        description = "向苏格拉底式教师学习编程",
        opts = {
          ignore_system_prompt = true,
        },
        prompts = {
          {
            role = "system",
            content = require("env/prompt/socrates")
          },
        },
      },
    },
    strategies = {
      chat = {
        -- adapter = {
        --   name = "copilot",
        --   model = "claude-sonnet-4",
        -- },
        adapter = "gemini_cli",
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
      },
      history = {
        enabled = true,
        opts = {
          keymap = "gh",           -- Keymap to open history from chat buffer (default: gh)
          save_chat_keymap = "gs", -- Keymap to save the current chat manually (when auto_save is disabled)
          auto_save = true,        -- Save all chats by default (disable to save only manually using 'sc')
          expiration_days = 0,     -- Number of days after which chats are automatically deleted (0 to disable)
          picker = "telescope",    -- Picker interface (auto resolved to a valid picker)
          ---Optional filter function to control which chats are shown when browsing
          chat_filter = nil,       -- function(chat_data) return boolean end
          -- Customize picker keymaps (optional)
          picker_keymaps = {
            rename = { n = "r", i = "<M-r>" },
            delete = { n = "d", i = "<M-d>" },
            duplicate = { n = "<C-y>", i = "<C-y>" },
          },
          ---Automatically generate titles for new chats
          auto_generate_title = true,
          title_generation_opts = {
            ---Adapter for generating titles (defaults to current chat adapter)
            adapter = "copilot",
            ---Model for generating titles (defaults to current chat model)
            model = "gpt-4o",
            ---Number of user prompts after which to refresh the title (0 to disable)
            refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
            ---Maximum number of times to refresh the title (default: 3)
            max_refreshes = 3,
            format_title = function(original_title)
              -- this can be a custom function that applies some custom
              -- formatting to the title.
              return original_title
            end
          },
          ---On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          ---When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = false,
          ---Directory path to save the chats
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          ---Enable detailed logging for history extension
          enable_logging = false,

          -- Summary system
          summary = {
            -- Keymap to generate summary for current chat (default: "gcs")
            create_summary_keymap = "gcs",
            -- Keymap to browse summaries (default: "gbs")
            browse_summaries_keymap = "gbs",

            generation_opts = {
              adapter = "copilot",
              model = "gpt-4o",
              context_size = 90000,        -- max tokens that the model supports
              include_references = true,   -- include slash command content
              include_tool_outputs = true, -- include tool execution results
              system_prompt = nil,         -- custom system prompt (string or function)
              format_summary = nil,        -- custom function to format generated summary e.g to remove <think/> tags from summary
            },
          },

          -- Memory system (requires VectorCode CLI)
          memory = {
            -- Automatically index summaries when they are generated
            auto_create_memories_on_summary_generation = true,
            -- Path to the VectorCode executable
            vectorcode_exe = "vectorcode",
            -- Tool configuration
            tool_opts = {
              -- Default number of memories to retrieve
              default_num = 10
            },
            -- Enable notifications for indexing progress
            notify = true,
            -- Index all existing memories on startup
            -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
            index_on_startup = false,
          },
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
