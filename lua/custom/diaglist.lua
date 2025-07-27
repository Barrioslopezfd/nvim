local open = false
vim.keymap.set('n', "<leader>q", function()
  if open == false then
    vim.diagnostic.setqflist()
    open = true
  else
    vim.cmd('cclose')
    open = false
  end
end)
