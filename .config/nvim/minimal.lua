-- MINIMAL NVIM CONFIG - Emergency fallback
-- No plugins, no LazyVim, just basic settings

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.scrolloff = 10

-- Disable all providers that might cause issues
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Basic keymaps
vim.keymap.set('n', '<Space>', '', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

print("Minimal nvim config loaded - no plugins")
