return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-vim-test",

    {
      "echasnovski/mini.indentscope",
      opts = function()
        -- disable indentation scope for the neotest-summary buffer
        vim.cmd([[
        autocmd Filetype neotest-summary lua vim.b.miniindentscope_disable = true
      ]])
      end,
    },
  },
  opts = {
    -- See all config options with :h neotest.Config
    discovery = {
      -- Drastically improve performance in ginormous projects by
      -- only AST-parsing the currently opened buffer.
      enabled = true,
      -- Number of workers to parse files concurrently.
      -- A value of 0 automatically assigns number based on CPU.
      -- Set to 1 if experiencing lag.
      concurrent = 0,
    },
    running = {
      -- Run tests concurrently when an adapter provides multiple commands to run.
      concurrent = true,
    },
    summary = {
      -- Enable/disable animation of icons.
      animated = true,
    },
  },
  config = function(_, opts)
    require("neotest").setup(opts)
  end,
  keys = {
    { "<leader>t", mode = { "n", "v" }, "", desc = "+test" },
    {
      "<leader>tt",
      mode = { "n", "v" },
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run File",
    },
    {
      "<leader>tr",
      mode = { "n", "v" },
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest",
    },

    {
      "<leader>ta",
      function()
        require("neotest").run.attach()
      end,
      desc = "[t]est [a]ttach",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "[t]est run [f]ile",
    },
    {
      "<leader>tA",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "[t]est [A]ll files",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.run({ suite = true })
      end,
      desc = "[t]est [S]uite",
    },
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "[t]est [n]earest",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "[t]est [l]ast",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "[t]est [s]ummary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "[t]est [o]utput",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "[t]est [O]utput panel",
    },
    {
      "<leader>tt",
      function()
        require("neotest").run.stop()
      end,
      desc = "[t]est [t]erminate",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ suite = false, strategy = "dap" })
      end,
      desc = "Debug nearest test",
    },
  },
}
