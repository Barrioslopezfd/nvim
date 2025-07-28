vim.keymap.set({ 'n' }, '<leader>eq', '<Cmd>Ex<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 'n', 't' }, '<Esc>', '<Cmd>set nohlsearch<CR>', { noremap = true })

vim.keymap.set('n', '<M-k>', '<Cmd>m .-2<CR>')
vim.keymap.set('n', '<M-j>', '<Cmd>m .+1<CR>')
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
