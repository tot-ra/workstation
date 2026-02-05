-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--
vim.opt.swapfile = false
vim.opt.encoding = "utf-8"
vim.opt.scrolloff = 10

vim.opt.conceallevel = 0
-- vim.g.tokyonight_colors = { border = "orange" }

-- Clipboard configuration for SSH/tmux
-- Use OSC 52 for clipboard integration over SSH
vim.opt.clipboard = "unnamedplus"

-- Configure clipboard provider to use OSC 52
-- This allows copying from nvim over SSH to local clipboard
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
