local M = {}

local uv = vim.uv or vim.loop

local comMapNoShebang = {
  c = { b = '/*', m = '**', e = '*/' },
  cpp = { b = '/*', m = '**', e = '*/' },
  make = { b = '##', m = '##', e = '##' },
  java = { b = '//', m = '//', e = '//' },
  latex = { b = '%%', m = '%%', e = '%%' },
  html = { b = '<!--', m = '  --', e = '-->' },
  lisp = { b = ';;', m = ';;', e = ';;' },
  css = { b = '/*', m = '**', e = '*/' },
  pov = { b = '//', m = '//', e = '//' },
  pascal = { b = '{ ', m = '   ', e = '}' },
  haskell = { b = '{-', m = '-- ', e = '-}' },
  vim = { b = '""', m = '"" ', e = '""' },
}

local comMapShebang = {
  sh = { s = '#!/usr/bin/env bash', b = '##', m = '##', e = '##' },
  bash = { s = '#!/usr/bin/env bash', b = '##', m = '##', e = '##' },
  zsh = { s = '#!/usr/bin/env zsh', b = '##', m = '##', e = '##' },
  php = { s = '#!/usr/bin/env php', b = '/*', m = '**', e = '*/' },
  perl = { s = '#!/usr/bin/env perl', b = '##', m = '##', e = '##' },
  python = { s = '#!/usr/bin/env python3', b = '##', m = '##', e = '##' },
  ruby = { s = '#!/usr/bin/env ruby', b = '##', m = '##', e = '##' },
  node = { s = '#!/usr/bin/env node', b = '/*', m = '**', e = '*/' },
}

local function Epiyear()
  -- use os.date for year; locale not necessary here
  return os.date("%Y")
end

local function InsertFirst(lines, proj_name, file_desc)
  -- replace placeholders in the first few lines
  for i = 1, math.min(#lines, 6) do
    lines[i] = lines[i]:gsub('µPROJECTNAMEµ', proj_name or '')
    lines[i] = lines[i]:gsub('µYEARµ', Epiyear())
    lines[i] = lines[i]:gsub('µFILEDESCµ', file_desc or '')
  end
end

local function IsSupportedFt(ft)
  return comMapNoShebang[ft] ~= nil
end

local function IsSupportedFtShebang(ft)
  return comMapShebang[ft] ~= nil
end

function M.Epi_header()
  local ft = vim.bo.filetype
  local has_shebang = false

  if IsSupportedFt(ft) then
    has_shebang = false
  elseif IsSupportedFtShebang(ft) then
    has_shebang = true
  else
    vim.api.nvim_err_writeln("Epitech header: Unsupported filetype: " .. ft .. " If you think this an error or you want an additional filetype please contact me :)")
    return
  end

  local hdr_lines = {}

  if not has_shebang then
    local c = comMapNoShebang[ft]
    table.insert(hdr_lines, c.b)
    table.insert(hdr_lines, c.m .. " EPITECH PROJECT, µYEARµ")
    table.insert(hdr_lines, c.m .. " µPROJECTNAMEµ")
    table.insert(hdr_lines, c.m .. " File description:")
    table.insert(hdr_lines, c.m .. " µFILEDESCµ")
    table.insert(hdr_lines, c.e)
  else
    local s = comMapShebang[ft]
    table.insert(hdr_lines, s.s)
    table.insert(hdr_lines, s.b)
    table.insert(hdr_lines, s.m .. " EPITECH PROJECT, µYEARµ")
    table.insert(hdr_lines, s.m .. " µPROJECTNAMEµ")
    table.insert(hdr_lines, s.m .. " File description:")
    table.insert(hdr_lines, s.m .. " µFILEDESCµ")
    table.insert(hdr_lines, s.e)
  end

  -- prompt for project name and description
  local proj_name = vim.fn.input('Enter project name: ')
  local file_desc = vim.fn.input('Enter file description: ')

  InsertFirst(hdr_lines, proj_name, file_desc)

  -- insert at top of buffer
  vim.api.nvim_buf_set_lines(0, 0, 0, false, hdr_lines)
  -- move cursor to line 8 (like original Vimscript)
  pcall(vim.cmd, 'normal! 8G')
end

function M.Compile()
  local default = 'make'
  local ccommand = vim.fn.input('compile : ', default)
  if ccommand == nil or ccommand == '' then
    ccommand = default
  end
  vim.bo.makeprg = ccommand
  -- run makeprg
  vim.cmd('make')
end

function M.GotoLine()
  local n = vim.fn.input('Goto Line : ')
  if n and n ~= '' then
    -- use :<num>
    pcall(vim.cmd, tostring(n))
  end
end

local function setup_mappings()
  -- map keys in normal mode
  vim.keymap.set('n', '<C-c><C-h>', function() M.Epi_header() end, { noremap = true, silent = true })
  vim.keymap.set('n', '<C-c><C-c>', function()
    vim.cmd('write')
    M.Compile()
  end, { noremap = true, silent = true })
  vim.keymap.set('n', '<C-g>', function() M.GotoLine() end, { noremap = true, silent = true })
end

function M.setup()
  -- create user commands
  vim.api.nvim_create_user_command('EpiHeader', function() M.Epi_header() end, {})
  vim.api.nvim_create_user_command('Compile', function() M.Compile() end, {})
  vim.api.nvim_create_user_command('GotoLine', function() M.GotoLine() end, {})
  setup_mappings()
end

return M
