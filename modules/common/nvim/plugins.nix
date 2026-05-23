''
  return {
    {
      "stevearc/oil.nvim",
      lazy = false,
      opts = {
        columns = { "permissions", "size" },
        default_file_explorer = false,
        view_options = { show_hidden = true },
      },
      keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
      },
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    { "folke/zen-mode.nvim", opts = {}, },
  }
''
