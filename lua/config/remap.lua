vim.keymap.set({ 'n' }, '<leader>eq', '<Cmd>Ex<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 'n', 't' }, '<Esc>', '<Cmd>set nohlsearch<CR>', { noremap = true })

vim.keymap.set('n', '<M-k>', '<Cmd>m .-2<CR>')
vim.keymap.set('n', '<M-j>', '<Cmd>m .+1<CR>')
vim.keymap.set('v', '<M-k>', function()
  local ok = pcall(function() vim.cmd([['<,'>m '<-2]]) end)
  if ok then vim.cmd([[ normal! gv=gv ]]) end
end)
vim.keymap.set('v', '<M-j>', function()
  local ok = pcall(function() vim.cmd([['<,'>m '>+1]]) end)
  if ok then vim.cmd([[ normal! gv=gv ]]) end
end)

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
