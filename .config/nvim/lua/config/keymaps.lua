-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Ctrl-s to save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Ctrl-z to undo
vim.keymap.set({ "i", "n" }, "<C-z>", "<cmd>u<cr><esc>", { desc = "Undo", remap = true })

-- Ctrl-d to duplicate line
vim.keymap.set({ "i", "n" }, "<C-d>", "<esc>yyp<esc>i", { desc = "Duplicate line", remap = true })
vim.keymap.set({ "v" }, "<C-d>", "yp<esc>", { desc = "Duplicate selection", remap = true })

-- F4 to do global search, same as Mac search icon
vim.keymap.set({ "i", "n" }, "<F4>", "<esc><leader>sg", { desc = "Search in workspace", remap = true })

-- moving lines
vim.keymap.set({ "i", "n" }, "<CS-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set({ "i", "n" }, "<CS-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- selecting
vim.keymap.set("i", "<S-Up>", "<esc>v<Up>", { desc = "Select Up" })
vim.keymap.set("i", "<S-Down>", "<esc>v<Down>", { desc = "Select Down" })
vim.keymap.set("i", "<S-Left>", "<esc>v<Left>", { desc = "Select Left" })
vim.keymap.set("i", "<S-Right>", "<esc>v<Right>", { desc = "Select Right" })

vim.keymap.set("n", "<S-Up>", "v<Up>", { desc = "Select Up" })
vim.keymap.set("n", "<S-Down>", "v<Down>", { desc = "Select Down" })
vim.keymap.set("n", "<S-Left>", "v<Left>", { desc = "Select Left" })
vim.keymap.set("n", "<S-Right>", "v<Right>", { desc = "Select Right" })

vim.keymap.set("v", "<S-Up>", "<Up>", { desc = "Select Up" })
vim.keymap.set("v", "<S-Down>", "<Down>", { desc = "Select Down" })
vim.keymap.set("v", "<S-Left>", "<Left>", { desc = "Select Left" })
vim.keymap.set("v", "<S-Right>", "<Right>", { desc = "Select Right" })
