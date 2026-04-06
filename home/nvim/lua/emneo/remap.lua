-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- space is the leader, so we disable its default behaviour
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- make j and k behave expectedly on wrapped lines
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- <C-[hjkl]> to move around windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { silent = true })

-- make some commands case insensitive because omfg!!!
vim.cmd "cnoreabbrev W w"
vim.cmd "cnoreabbrev Wa wa"
vim.cmd "cnoreabbrev WA wa"
vim.cmd "cnoreabbrev Q q"
vim.cmd "cnoreabbrev Qa qa"
vim.cmd "cnoreabbrev QA qa"
vim.cmd "cnoreabbrev E e"
vim.cmd "cnoreabbrev Vs vs"
