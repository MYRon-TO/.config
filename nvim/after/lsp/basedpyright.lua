return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "on",
        configFilePath = vim.fn.getcwd() .. "/backend",
        inlayHints = {
          callArgumentNamesMatching = true,
          functionReturnTypes = true
        }
      },
    },
  },
}
