vim.lsp.config['lua-language-server'] = {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },
  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains either a ".luarc.json" or a
  -- ".luarc.jsonc" file. Files that share a root directory will reuse
  -- the connection to the same LSP server.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.vim', 'nvim' }, { upward = true })[1]),
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  -- Srecific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for lua-language-server
  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      -- format = {
      --   enable = true,
      -- },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = {
          ["/home/barrioslopezfd/.config/nvim"] = true,
          ["/usr/local/share/nvim/runtime"] = true,
        },
      },
      checkThirdParty = false,
    }
  }
}

vim.lsp.enable('lua-language-server')

vim.api.nvim_create_autocmd('FileType', {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
