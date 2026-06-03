local cfg = vim.lsp.config.clangd
if cfg == nil then return end
cfg.cmd = {
  "clangd",
  "--background-index",
  "--completion-style=detailed",
  "--header-insertion=never",
}
vim.lsp.config('clangd', cfg)

vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt.cindent = true
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.cc" },
--   callback = function()
--     local clients = vim.lsp.get_clients({ bufnr = 0, name = "clangd" })
--     if #clients > 0 then
--       vim.lsp.buf.format({ async = false })
--     end
--   end,
-- })
