local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

function OpenFloatingWindow(opts)
  opts = opts or {}
  local width = opts.widht or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- Create a buffer without an assigned file
  end


  local win_config = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded", -- Can be: none | single | double | rounded | solid | shadow
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('term_open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>')
  end,
})

vim.api.nvim_create_user_command('Termo', function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = OpenFloatingWindow { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end, {})

vim.keymap.set({ 'n' }, '<leader>te', '<cmd>Termo<CR>')
