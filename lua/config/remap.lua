-- Move lines up/down in Visual Mode
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv")

-- Disable arrows
-- vim.keymap.set({ 'n', 'i', 'v', 'c', 'x', 't' }, '<Up>', '<Nop>', { noremap = true })
-- vim.keymap.set({ 'n', 'i', 'v', 'c', 'x', 't' }, '<Down>', '<Nop>', { noremap = true })
-- vim.keymap.set({ 'n', 'i', 'v', 'c', 'x', 't' }, '<Left>', '<Nop>', { noremap = true })
-- vim.keymap.set({ 'n', 'i', 'v', 'c', 'x', 't' }, '<Right>', '<Nop>', { noremap = true })

-- Navigating the Quickfix
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')

-- Remove highlight after searching
vim.keymap.set('n', '<esc>', '<cmd>noh<CR>')

-- Move lines left/right in Visual Mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
