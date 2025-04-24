return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      --[[ ======= LUA ======= ]] --
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.expandtab = true
        end,
      })
    end
  }
}
