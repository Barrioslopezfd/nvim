-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.env.PATH = vim.env.PATH .. ":" .. os.getenv("HOME") .. "/.local/share/nvim/lazy-rocks/hererocks/bin"

-- vim.g.clipboard = {
--   name = "xclip",
--   copy = {
--     ["+"] = { "xclip", "-selection", "clipboard" },
--     ["*"] = { "xclip", "-selection", "primary" },
--   },
--   paste = {
--     ["+"] = { "xclip", "-selection", "clipboard", "-o" },
--     ["*"] = { "xclip", "-selection", "primary", "-o" },
--   },
--   cache_enabled = false,
-- }


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- { "rmehri01/onenord.nvim",  config = function() vim.cmd.colorscheme "onenord" end },
    -- { "shaunsingh/nord.nvim",   config = function() vim.cmd.colorscheme "nord" end },
    -- { "folke/tokyonight.nvim",  config = function() vim.cmd.colorscheme "tokyonight" end },
    {
      "rebelot/kanagawa.nvim",
      config = function()
        -- Default options:
        require('kanagawa').setup({
          compile = true,   -- enable compiling the colorscheme
          undercurl = true, -- enable undercurls
          commentStyle = { italic = true },
          functionStyle = {},
          keywordStyle = { italic = true },
          statementStyle = { bold = true },
          typeStyle = {},
          transparent = true,    -- do not set background color
          dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
          terminalColors = true, -- define vim.g.terminal_color_{0,17}
          colors = {             -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
          },
          overrides = function(colors) -- add/modify highlights
            return {}
          end,
          theme = "wave",  -- Load "wave" theme
          background = {   -- map the value of 'background' option to a theme
            dark = "wave", -- try "dragon" !
            light = "lotus"
          },
        })
        vim.cmd.colorscheme "kanagawa"
      end
    },
    -- import your plugins
    { import = "config.plugins" },
  },
})
