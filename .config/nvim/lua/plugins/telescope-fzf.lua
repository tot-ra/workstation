return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      --      { "<A-S>o", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "File fuzzy find" },
      --      { "<A-S>f", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },

      --			{ "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
      --			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
      --			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      --			{ "<leader>w", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
      --			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      --			{ "<leader>c", "<cmd>Telescope resume<cr>", desc = "Resume search" },
      --			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you have trouble with this installation, refer to the README for telescope-fzf-native.
    build = "make",
  },
}
