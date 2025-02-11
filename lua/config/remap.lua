-- Move lines up/down in Visual Mode
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv")

-- Quickfix Diagnostic
vim.keymap.set('n', '<leader>q', function()
  local is_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "" then
      local bufnr = vim.api.nvim_win_get_buf(win)
      if vim.bo[bufnr].buftype == "quickfix" then
        is_open = true
        break
      end
    end
  end
  if is_open then
    vim.cmd("cclose")
  else
    vim.diagnostic.setqflist()
  end
end)

-- Navigating the Quickfix
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')

-- Remove highlight after searching
vim.keymap.set('n', '<esc>', '<cmd>noh<CR>')

-- Move lines left/right in Visual Mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
