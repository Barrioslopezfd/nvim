vim.lsp.enable('ts_ls')
vim.api.nvim_create_autocmd("FileType", {
  -- pattern = { "tsx", "ts" },
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt.cindent = true
  end,
})
