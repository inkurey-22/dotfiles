return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'github/copilot.vim',
    config = function()
      -- Optionally configure Copilot settings here
    end,
    lazy = false
  },

-- Add this entry to the plugins list
{
  "andweeb/presence.nvim",
  config = function()
    require("presence"):setup({
      -- You can configure various options here. Here's a simple example:
      auto_update = true,       -- Automatically update rich presence
      neovim_image_text = "Neovim",  -- Image text (e.g., "Neovim")
      main_image = "file",      -- Use "file" to display the current file as the image
      log_level = nil,          -- Set log level for debugging (optional)
      debounce_timeout = 10,    -- Time in seconds to wait before refreshing
      enable_line_number = true,  -- Show the current line number in the presence
      blacklist = {},           -- List of filetypes to blacklist
      workspace_text = "Working on %s",  -- workspace_text = "Working on %s"
    })
  end,
  lazy = false
}

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
