-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Navigation
vim.keymap.set("n", "<A-Left>", ":tabprev<CR>")
vim.keymap.set("n", "<A-Right>", ":tabnext<CR>")
vim.keymap.set("n", "<A-Down>", ":tabnew<CR>")

-- Ctrl-s to save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Ctrl-z to undo
vim.keymap.set({ "i", "n" }, "<C-z>", "<esc><cmd>u<cr><esc>", { desc = "Undo", remap = true })

-- Ctrl-d to duplicate line
vim.keymap.set({ "i", "n" }, "<C-d>", "<esc>yyp<esc>i", { desc = "Duplicate line", remap = true })
vim.keymap.set({ "v" }, "<C-d>", "yp<esc>", { desc = "Duplicate selection", remap = true })

vim.keymap.set({ "i", "n" }, "<C-a>", "<esc>ggVGy", { desc = "Select all an copy", remap = true })
vim.keymap.set({ "v" }, "<C-a>", "nggVGy", { desc = "Select all an copy", remap = true })

-- F4 to do global search, same as Mac search icon
vim.keymap.set({ "i", "n" }, "<F4>", "<esc><leader>sg", { desc = "Search in workspace", remap = true })

-- Moving line one at a time
vim.keymap.set({ "i", "n" }, "<CS-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set({ "i", "n" }, "<CS-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Visual move down/up command, counts number of selected lines
-- this does depend on terminal (wizterm) to not intercept ctrl+shift+up/down
vim.keymap.set({ "v" }, "<CS-Down>", ":m '>+1<CR>gv=gv", { desc = "Visual Move Down", remap = true })
vim.keymap.set({ "v" }, "<CS-Up>", ":m '<-2<CR>gv=gv", { desc = "Visual Move Up", remap = true })

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
