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


-- change colors of line and column on the quickfix list
-- 'qfLineNr' and 'qfFileName' are quickfix highligh groups
-- for more info refer to https://github.com/vim/vim/blob/master/runtime/syntax/qf.vim
vim.api.nvim_set_hl(0, "qfLineNr", { fg = "#7aa2f7", bold = true })
vim.api.nvim_set_hl(0, "qfFileName", { fg = "#e0af68" })
