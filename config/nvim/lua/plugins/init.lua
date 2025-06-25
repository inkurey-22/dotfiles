return {
--[[   {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  }, ]]
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        -- your configuration comes here
        -- for example
        enabled = true,  -- if you want to enable the plugin
        message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    }
  },

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
      enable_line_number = false,  -- Show the current line number in the presence
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
