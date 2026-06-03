vim.lsp.config('hls', {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})
vim.lsp.enable('hls')
vim.api.nvim_create_autocmd("FileType", {
  pattern = "hs",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = false
  end,
})
