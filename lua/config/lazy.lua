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
    -- { "rmehri01/onenord.nvim", config = function() vim.cmd.colorscheme "onenord" end },
    -- { "shaunsingh/nord.nvim", config = function() vim.cmd.colorscheme "nord" end },
    -- { "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end },
    -- { "rebelot/kanagawa.nvim",  config = function() vim.cmd.colorscheme "kanagawa" end },
    -- import your plugins
    { import = "config.plugins" },
  },
})
