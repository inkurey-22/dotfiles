vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.background = "light"

local ok_catppuccin, catppuccin = pcall(require, "catppuccin")
if ok_catppuccin then
  catppuccin.setup({
    flavour = "latte",
  })
  vim.cmd.colorscheme("catppuccin")
end

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "81"

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.fileformat = "unix"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h",
  callback = function()
    vim.bo.filetype = "c"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "nix" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.comments = "s:/*,m:**,ex:*/"
  end,
})

local ok_pairs, npairs = pcall(require, "nvim-autopairs")
if ok_pairs then
  npairs.setup({})
end

local no_shebang = {
  c = { b = "/*", m = "**", e = "*/" },
  cpp = { b = "//", m = "//", e = "//" },
  lua = { b = "--", m = "--", e = "--" },
  vim = { b = '""', m = '"" ', e = '""' },
  make = { b = "##", m = "##", e = "##" },
  nix = { b = "#", m = "#", e = "#" },
}

local shebang = {
  sh = { s = "#!/usr/bin/env sh", b = "##", m = "##", e = "##" },
  bash = { s = "#!/usr/bin/env bash", b = "##", m = "##", e = "##" },
  zsh = { s = "#!/usr/bin/env zsh", b = "##", m = "##", e = "##" },
  python = { s = "#!/usr/bin/env python3", b = "##", m = "##", e = "##" },
  ruby = { s = "#!/usr/bin/env ruby", b = "##", m = "##", e = "##" },
  node = { s = "#!/usr/bin/env node", b = "/*", m = "**", e = "*/" },
}

local function epi_year()
  return os.date("%Y")
end

local function make_header_lines(style, with_shebang)
  local lines = {}
  if with_shebang then
    table.insert(lines, style.s)
  end
  table.insert(lines, style.b)
  table.insert(lines, style.m .. " EPITECH PROJECT, " .. epi_year())
  table.insert(lines, style.m .. " " .. vim.fn.input("Enter project name: "))
  table.insert(lines, style.m .. " File description:")
  table.insert(lines, style.m .. " " .. vim.fn.input("Enter file description: "))
  table.insert(lines, style.e)
  return lines
end

local function epi_header()
  local ft = vim.bo.filetype
  local style = no_shebang[ft]
  local with_shebang = false

  if not style then
    style = shebang[ft]
    with_shebang = style ~= nil
  end

  if not style then
    vim.notify("Epitech header: unsupported filetype " .. ft, vim.log.levels.ERROR)
    return
  end

  local lines = make_header_lines(style, with_shebang)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  vim.api.nvim_win_set_cursor(0, { math.min(#lines + 1, vim.api.nvim_buf_line_count(0)), 0 })
end

local function compile()
  local cmd = vim.fn.input("compile: ", "make")
  if cmd ~= nil and cmd ~= "" then
    vim.opt.makeprg = cmd
    vim.cmd("make")
  end
end

local function goto_line()
  local line = vim.fn.input("Goto Line: ", "")
  local n = tonumber(line)
  if n ~= nil then
    vim.api.nvim_win_set_cursor(0, { n, 0 })
  end
end

vim.api.nvim_create_user_command("EpiHeader", epi_header, {})
vim.api.nvim_create_user_command("Compile", compile, {})
vim.api.nvim_create_user_command("GotoLine", goto_line, {})

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-c><C-h>", "<cmd>EpiHeader<CR>")
vim.keymap.set("n", "<C-c><C-c>", "<cmd>w | Compile<CR>")
vim.keymap.set("n", "<C-g>", "<cmd>GotoLine<CR>")

vim.cmd("syntax on")
