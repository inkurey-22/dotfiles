vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require "NVimTek"

vim.schedule(function()
  require "mappings"
end)

-- Set default indentation for all files
vim.o.tabstop = 4        -- Number of spaces that a tab character represents
vim.o.shiftwidth = 4     -- Number of spaces for each indentation level
vim.o.expandtab = true   -- Use spaces instead of tabs

-- Filetype-specific indentation overrides
vim.cmd [[
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType make setlocal tabstop=4 shiftwidth=4 noexpandtab
]]
