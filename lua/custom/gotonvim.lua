vim.api.nvim_create_user_command('Gotonvim',
  function()
    Selected_path = ""
    Win = vim.api.nvim_get_current_win()
    Buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_open_win(Buf, true, {
      split = 'below',
      height = 10,
    })
    vim.fn.jobstart('fd . ./ | fzf', {
      term = true,
      on_stdout = function(_, data)
        if data and data[1] and data[1] ~= '' then
          -- local clean = data[1]:gsub('\27%[[0-9;?]*[a-zA-Z]', ''):gsub('\r', '')
          local inside = false
          for char in data[1]:gmatch('.') do
            if char == '.' then inside = true end
            if char == '^' then inside = false end
            if inside then
              Selected_path = Selected_path .. char
            end
          end
        end
      end,
      on_exit = function()
        local buff = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_call(buff, function()
          vim.cmd("edit " .. Selected_path)
        end)
        vim.api.nvim_win_set_buf(Win, buff)
      end,
    })
  end,
  {}
)
