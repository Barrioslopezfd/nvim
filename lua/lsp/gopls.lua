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
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- if client:supports_method('textDocument/completion') then
      --   -- Enable auto-completion
      --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      -- end

      if client:supports_method('textDocument/formatting') then
        -- Format the current buffer on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            -- vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the file
            -- twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
            vim.lsp.buf.format({ async = false })
          end,
        })
      end

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
