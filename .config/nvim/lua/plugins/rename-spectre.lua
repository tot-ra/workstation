return {
  "nvim-pack/nvim-spectre",
  config = function()
    require("spectre").setup()
  end,

  keys = {
    {
      "<F9>",
      mode = { "n" },
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search in current word",
    },
    {
      "<F9>",
      mode = { "v" },
      function()
        require("spectre").open_visual()
      end,
      desc = "Search in current word",
    },
  },
}
