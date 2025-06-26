vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.typ",
  command = "setfiletype typst"
})

return {
  settings = {
    exportPdf = "onSave",
    formatterMode= "typstyle"
  }
}
