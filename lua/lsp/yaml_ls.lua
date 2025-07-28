local lspconfig = require("lspconfig")

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      format = {
        enable = false, -- lo maneja yamlfmt
      },
      validate = false, -- lo maneja yamllint
      hover = true,
      completion = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Deshabilitamos el formateo del LSP
    client.server_capabilities.documentFormattingProvider = false

    -- Opcional: autocmd para formatear con yamlfmt al guardar
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.cmd("silent! !yamlfmt %")
      end,
    })

    -- Opcional: comando para lint con yamllint
    vim.api.nvim_buf_create_user_command(bufnr, "YamlLint", function()
      vim.cmd("cclose")
      local fname = vim.api.nvim_buf_get_name(bufnr)
      vim.cmd("cexpr system('yamllint ' .. shellescape('" .. fname .. "'))")
      vim.cmd("copen")
    end, { desc = "Run yamllint and open quickfix" })
  end,
})
