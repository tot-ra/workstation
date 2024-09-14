return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = { -- load the plugin only when using it's keybinding:
    -- note that `u` is still undo
    -- note that Ctrl-r is redo
    { "<leader>uu", "<cmd>lua require('undotree').toggle()<cr>" },
  },
}
