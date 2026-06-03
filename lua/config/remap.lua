vim.keymap.set({ 'n' }, '<leader>eq', '<Cmd>Ex<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 'n', 't' }, '<Esc>', '<Cmd>set hlsearch!<CR>', { noremap = true })

vim.keymap.set('n', '<M-k>', '<Cmd>m .-2<CR>')
vim.keymap.set('n', '<M-j>', '<Cmd>m .+1<CR>')
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv")

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- vim.keymap.set('n', '<leader>kj', ':w<CR>:!bash mk<CR>', { desc = 'Run build file' })

vim.keymap.set('n', '<leader>nvim', ':e ~/.config/nvim<CR>', { desc = 'Open nvim config dir' })

vim.keymap.set('n', '<leader>nw', ':set nowrap!<CR>', { desc = 'Invert no wrap setting' })
