-- Buffer line (tab bar) like VSCode
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = require("bufferline").style_preset.default, -- or style_preset.minimal,
        themable = true,
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon', -- | 'underline' | 'none',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 21,
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        color_icons = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
        separator_style = "slant", -- | "slope" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        sort_by = 'insert_after_current', -- |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      }
    })

    -- Keymaps for buffer navigation
    vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true, desc = 'Go to buffer 1' })
    vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true, desc = 'Go to buffer 2' })
    vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true, desc = 'Go to buffer 3' })
    vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true, desc = 'Go to buffer 4' })
    vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true, desc = 'Go to buffer 5' })
    vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true, desc = 'Go to buffer 6' })
    vim.keymap.set('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true, desc = 'Go to buffer 7' })
    vim.keymap.set('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true, desc = 'Go to buffer 8' })
    vim.keymap.set('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true, desc = 'Go to buffer 9' })
    vim.keymap.set('n', '<leader>$', '<Cmd>BufferLineGoToBuffer -1<CR>', { noremap = true, silent = true, desc = 'Go to last buffer' })

    -- Buffer moving
    vim.keymap.set('n', '<leader>bb', '<Cmd>BufferLinePick<CR>', { noremap = true, silent = true, desc = 'Pick buffer' })
    vim.keymap.set('n', '<leader>bc', '<Cmd>BufferLinePickClose<CR>', { noremap = true, silent = true, desc = 'Pick buffer to close' })
    vim.keymap.set('n', '<leader>bmn', '<Cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true, desc = 'Move buffer next' })
    vim.keymap.set('n', '<leader>bmp', '<Cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true, desc = 'Move buffer prev' })

    -- Close buffers
    vim.keymap.set('n', '<leader>bcr', '<Cmd>BufferLineCloseRight<CR>', { noremap = true, silent = true, desc = 'Close buffers to the right' })
    vim.keymap.set('n', '<leader>bcl', '<Cmd>BufferLineCloseLeft<CR>', { noremap = true, silent = true, desc = 'Close buffers to the left' })
    vim.keymap.set('n', '<leader>bco', '<Cmd>BufferLineCloseOthers<CR>', { noremap = true, silent = true, desc = 'Close other buffers' })
  end,
}
