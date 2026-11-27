local spec = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", config = true },
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    config = function()
      require("config.lsp").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- does not support lazy-loading
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function()
      require("config.treesitter").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.telescope").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "auto", icons_enabled = false },
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
      end
      map("<Space>gb", ":Git blame<CR>", "Git blame")
      map("<Space>gd", ":Gdiffsplit<CR>", "Git diff")
      map("<Space>gs", ":Git<CR>", "Git status")
      map("<Space>gc", ":Git commit<CR>", "Git commit")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false, -- needed to open the tree for `nvim <dir>`
    init = function()
      -- nvim-tree replaces netrw; disable it before it loads
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require("config.filetree").setup()
    end,
  },
  { "echasnovski/mini.surround", version = false, config = true },
  { "echasnovski/mini.trailspace", version = false, config = true },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      -- Formatters are installed by mason (see ensure_tools below).
      -- [Security] Avoid formatters that execute project-supplied code on save:
      --   - prettier: runs node_modules/.bin/prettier and loads .prettierrc.js
      --   - rubocop:  loads `require:` entries from .rubocop.yml
      -- Ruby falls back to LSP formatting instead.
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"
      local tools = { "biome", "yamlfmt", "stylua", "black" }

      local function ensure_tools()
        if #vim.api.nvim_list_uis() == 0 then
          return -- skip in headless mode (same as mason-lspconfig)
        end
        local registry = require("mason-registry")
        registry.refresh(function()
          for _, name in ipairs(tools) do
            local ok, pkg = pcall(registry.get_package, name)
            if ok and not pkg:is_installed() then
              pkg:install()
            end
          end
        end)
      end
      ensure_tools()

      require("conform").setup({
        format_on_save = function(bufnr)
          local disable_ft = { "markdown" }
          return {
            timeout_ms = 500,
            lsp_format = vim.tbl_contains(disable_ft, vim.bo[bufnr].filetype) and "never" or "fallback",
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
          json = { "biome" },
          jsonc = { "biome" },
          css = { "biome" },
          yaml = { "yamlfmt" },
        },
        formatters = {
          -- Pin to mason's binary; conform's default looks in the project's node_modules
          biome = { command = mason_bin .. "biome" },
          yamlfmt = { command = mason_bin .. "yamlfmt" },
          stylua = { command = mason_bin .. "stylua" },
          black = { command = mason_bin .. "black" },
        },
      })
    end,
  },
}

return spec
