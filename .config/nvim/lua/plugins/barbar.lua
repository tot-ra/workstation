return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    icons = {
      pinned = { button = "", filename = true },

      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
    },

    sidebar_filetypes = {
      ["neo-tree"] = { event = "BufWipeout" },
    },

    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
  keys = {
    { "<A-Left>", "<cmd>BufferPrevious<cr>" },
    { "<A-Down>", "<cmd>BufferPin<cr>" },
    { "<A-Up>", "<cmd>BufferClose<cr>" },
    { "<A-Right>", "<cmd>BufferNext<cr>" },
  },
}
