-- Quickfix diagnostic
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set({ 'n' }, '<leader>q', function()
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
