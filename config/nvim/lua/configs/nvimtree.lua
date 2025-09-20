local options = {
  filters = {
    dotfiles = false,  -- Show dotfiles like .gitignore, .env
    git_clean = false,
    no_buffer = false,
    custom = {
      -- Hide these specific directories and files
      "^\\.git$",           -- Hide .git directory
      "^__pycache__$",      -- Hide Python cache
      "^\\.pytest_cache$",  -- Hide pytest cache
      "^node_modules$",     -- Hide Node.js modules
      "^\\.next$",          -- Hide Next.js build files
      "^\\.nuxt$",          -- Hide Nuxt.js files
      "^dist$",             -- Hide build distributions
      "^build$",            -- Hide build directories
      "^\\.DS_Store$",      -- Hide macOS files
      "^Thumbs%.db$",       -- Hide Windows thumbnails
      "^\\.vscode$",        -- Hide VS Code settings (optional)
      "^\\.idea$",          -- Hide IntelliJ settings (optional)
    },
    exclude = {},
  },
  
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

return options