vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.stdpath('config')] = true,
          [vim.fn.stdpath('data') .. '/site'] = true,
          [vim.env.VIMRUNTIME] = true
        },
      },
    },
  },
})

vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd('FileType', {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- vim.lsp.config['lua-language-server'] = {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.vim', 'nvim' }, { upward = true })[1]),
--   root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       workspace = {
--         library = {
--           ["/home/barrioslopezfd/.config/nvim"] = true,
--           ["/usr/local/share/nvim/runtime"] = true,
--         },
--       },
--       checkThirdParty = false,
--     }
--   }
-- }
--
-- vim.lsp.enable('lua-language-server')
