vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'go' },
  sync_install = false,
  auto_install = true,
  ignore_install = {},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },

  modules = {}, -- 👈 necesario aunque no uses módulos personalizados
})
