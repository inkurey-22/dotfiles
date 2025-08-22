-- Terminal configuration using toggleterm.nvim
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local tt = require('toggleterm')

    tt.setup({
      size = 20,
      open_mapping = [[<A-i>]], -- Alt+i to toggle terminal
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = false, -- we'll manage mappings ourselves
      terminal_mappings = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    })

    -- Set terminal keymaps. Keep <Tab> working for shell completion.
    local function set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- Exit to normal from terminal
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

      -- Window navigation from terminal (go to other windows)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

      -- Keep <Tab> and <S-Tab> for terminal usage (do not remap to buffer next/prev)
      -- If the user or other configs set <Tab> globally, buffer navigation mappings
      -- are in normal mode only; ensure terminal mode preserves Tab.

      -- Ctrl-w from terminal to operate on windows
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- Apply mappings when a terminal opens
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*',
      callback = function() set_terminal_keymaps() end,
    })

    -- Optional helper to open a floating terminal (similar to NvChad's custom toggles)
    local Terminal = require('toggleterm.terminal').Terminal
    local lazyterm = Terminal:new({
      cmd = vim.o.shell,
      hidden = true,
      direction = 'float',
    })

    -- Expose a global toggle function bound to Alt+i so users can call it too
    _G._TOGGLE_TERM = function()
      lazyterm:toggle()
    end

    -- Map Alt+i in normal and terminal modes to toggle the terminal
    vim.keymap.set({'n', 't'}, '<A-i>', _G._TOGGLE_TERM, { noremap = true, silent = true, desc = 'Toggle terminal' })
  end,
}
