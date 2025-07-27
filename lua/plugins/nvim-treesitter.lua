return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath('data') .. '/site',
    }
    local languages = {
      'rust', 'javascript', 'zig', 'go',
      'yaml', 'toml', 'json', 'jsonnet',
      'java', 'markdown', 'bash', 'sh', 'lua'
    }
    require('nvim-treesitter').install(languages):wait(300000)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
