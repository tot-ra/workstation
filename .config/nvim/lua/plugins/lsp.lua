-- since this is just an example spec, don't actually load anything here and return an empty spec
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      border = "single", -- set border to single
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
    keys = { -- load the plugin only when using it's keybinding:
      -- note that `u` is still undo
      -- note that Ctrl-r is redo
      { "<C-e>", "<cmd>lua vim.lsp.rename()<cr>" },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  --  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  --  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
}
