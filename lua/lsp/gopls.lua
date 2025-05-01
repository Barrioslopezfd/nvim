local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  vim.api.nvim_create_autocmd('LspAttach', {
    pattern = "*.go",
    callback = function()
      -- Quickfix functions
      vim.keymap.set({ 'n' }, '<leader>f', function()
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
          local bufnr = vim.api.nvim_get_current_buf()
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          local qflist = {}

          for i, line in ipairs(lines) do
            if line:match("%f[%a]func%f[%A]") then
              table.insert(qflist, {
                bufnr = bufnr,
                lnum = i,
                col = line:find("func"),
                text = line
              })
            end
          end

          vim.fn.setqflist(qflist, 'r')
          vim.cmd("copen")
        end
      end)
    end,
  })
})
