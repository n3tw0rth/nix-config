''
  -- Custom vim options
  vim.opt.relativenumber = true
  vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
  vim.opt.list = false
  vim.opt.wrap = true
  vim.opt.linebreak = true

  -- Custom keymaps
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Plugin Open parent directory" })
  vim.keymap.set(
    "n",
    "<leader>l",
    ":let @+ = expand('%') . ':' . line('.')<cr>",
    { desc = "Shortcut Copy filepath and line number" }
  )

  require("nvim-tree").setup {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      cursorline = true,
      width = 50,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    update_focused_file = {
      enable = true,
      update_root = {
        enable = false,
        ignore_list = {},
      },
      exclude = false,
    },
  }

  local lspconfig = vim.lsp.config
  local servers = {
    html = {},
    cssls = {},
    phpactor = {},
    ts_ls = {},
    pyright = {},
    clangd = {},
    terraformls = {},
    gopls = {},
    astro = {},
    asm_ls = {},
    tailwindcss = {},
    yamlls = {},
    marksman = {},
    rust_analyzer = {
      filetypes = { "rust" },
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            allFeatures = true,
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
    nixd= {}
  }

  for name, opts in pairs(servers) do
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
  end

  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
      vim.lsp.buf.format()
    end,
  })

  require("conform").setup({
    formatters_by_ft = {
      nix = { "nixfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
''
