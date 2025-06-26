local dap_package = {
  "codelldb", -- C/C++/Rust
  "python",   -- Python
}

local compile = function()
  vim.cmd("write")
  local filetype = vim.bo.filetype
  if filetype == "cpp" or filetype == "c" then
    os.execute("gcc " .. vim.fn.expand("%") .. " -g -o " .. vim.fn.expand("%<"))
  end
end

return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio"
        },
      },
    },
    keys = {
      {
        ",c",
        function()
          compile();
          require("dap").continue()
        end
      },
      { ",b", function() require("dap").toggle_breakpoint() end },
      { ",j", function() require("dap").step_over() end },
      { ",u" },
      { ",q" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   dapui.close()
      -- end

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            local exe = vim.g.c_debug_program or vim.fn.expand("%:r")
            return vim.fn.getcwd() .. '/' .. exe
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      -- dap.configurations.rust = dap.configurations.cpp

      vim.keymap.set("n", ",q", dap.terminate)
      vim.keymap.set("n", ",u", dapui.toggle)

      vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

      vim.fn.sign_define("DapBreakpoint", { text = "󰝥", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "󰟃", texthl = "DapBreakpointCondition", numhl = "DapBreakpointCondition" }
      )
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "DapStopped" })
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    opts = {
      ensure_installed = dap_package,
      automatic_installation = true,
      handlers = {},
    }
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {
      all_references = true
    },
  },
}
