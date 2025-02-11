return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    enabled = true,
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {}
        }
      }

      require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
      -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })   -- Changed with multigrep
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })

      vim.keymap.set('n', '<leader>nvim', function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)

      vim.keymap.set('n', '<leader>sp', function()
        builtin.find_files {
          ---@diagnostic disable-next-line: param-type-mismatch
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      require "config.telescope.multigrep".setup()

      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end
  }
}
