require "nvchad.options"

-- add yours here!

local aug = vim.api.nvim_create_augroup("MyTabSettings", { clear = true })

-- Makefiles: real tabs
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "make" }, -- 'make' filetype
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4          -- typical Makefile expectation
    vim.bo.shiftwidth = 4
  end,
})

-- Lua: 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "lua" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

-- Others: 4 spaces (fallback)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = aug,
  pattern = "*",
  callback = function()
    -- If buffer already has filetype-specific autocmd set, don't override it.
    local ft = vim.bo.filetype
    if ft == "make" or ft == "lua" then
      return
    end
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
