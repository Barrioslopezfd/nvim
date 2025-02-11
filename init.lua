require("config")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("n", "<space>eq", ":Ex<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
