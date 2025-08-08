-- Git integration
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
      vim.keymap.set('n', '<leader>hb', function()
        require('gitsigns').blame_line { full = false }
      end, { buffer = bufnr, desc = 'Git blame line' })
    end,
  },
}
