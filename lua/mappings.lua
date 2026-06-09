require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "jk", "<C-\\><C-n>", { desc = "Terminal normal mode" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Obsidian keymaps
map("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "Obsidian: New Note" })
map("n", "<leader>oo", "<cmd>Obsidian open<cr>", { desc = "Obsidian: Open in App" })
map("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Obsidian: Search Notes" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<cr>", { desc = "Obsidian: Quick Switch" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Obsidian: Backlinks" })
map("n", "<leader>ot", "<cmd>Obsidian tags<cr>", { desc = "Obsidian: Search Tags" })

