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
      "towolf/vim-helm",
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
      --
      --[[ ======= LUA ======= ]] --
      --
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.expandtab = true
        end,
      })
      --
      --[[ ======= GO ======= ]] --
      --
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
      --
      --[[ ======= HELM ======= ]] --
      --
      lspconfig.helm_ls.setup {
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = "yaml-language-server",
            }
          }
        }
      }
      --
      --[[ ======= JAVA ======= ]] --
      --
      local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

      -- Find project root dir
      local root_markers = { ".git", "build.gradle", "pom.xml", ".project" }
      local root_dir = lspconfig.util.root_pattern(unpack(root_markers))(vim.fn.getcwd()) or vim.fn.getcwd()

      lspconfig.jdtls.setup({
        cmd = {
          jdtls_path .. "/bin/jdtls", -- path to executable
          "-data", vim.fn.stdpath("data") .. "/jdtls-workspace"
        },
        root_dir = root_dir,
        settings = {
          java = {
            project = {
              sourcePaths = { "src" } -- set src as root
            }
          }
        }
      })
    end
  }
}
