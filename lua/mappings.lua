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

-- Editing quality of life
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Indent left, keep selection" })
map("v", ">", ">gv", { desc = "Indent right, keep selection" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down, centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up, centered" })
map("n", "n", "nzzzv", { desc = "Next match, centered" })
map("n", "N", "Nzzzv", { desc = "Prev match, centered" })
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "LSP line diagnostics" })
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end, { desc = "LSP toggle inlay hints" })

-- Obsidian keymaps
map("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "Obsidian: New Note" })
map("n", "<leader>oo", "<cmd>Obsidian open<cr>", { desc = "Obsidian: Open in App" })
map("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Obsidian: Search Notes" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<cr>", { desc = "Obsidian: Quick Switch" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Obsidian: Backlinks" })
map("n", "<leader>ot", "<cmd>Obsidian tags<cr>", { desc = "Obsidian: Search Tags" })

-- Markdown Preview keymaps
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown: Toggle Preview" })


