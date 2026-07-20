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
    { "n3tw0rth/keeper.nvim", opts = {} },
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    }
  }
''
