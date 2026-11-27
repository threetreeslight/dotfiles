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
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = { colorscheme = "default" }
    end,
  },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
      end
      map("<Space>gb", ":Gblame<CR>", "Git blame")
      map("<Space>gd", ":Gdiff<CR>", "Git diff")
      map("<Space>gs", ":Gstatus<CR>", "Git status")
      map("<Space>gc", ":Gcommit<CR>", "Git commit")
    end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "<Enter>", "<Plug>(EasyAlign)", { silent = true })
      vim.keymap.set("n", "<Leader>a", "<Plug>(EasyAlign)", { silent = true })
    end,
  },
  { "echasnovski/mini.surround", version = false, config = true },
  { "echasnovski/mini.trailspace", version = false, config = true },
  {
    "echasnovski/mini.pick",
    version = false,
    config = function()
      require("mini.pick").setup()
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          local disable_ft = { "markdown" }
          return {
            timeout_ms = 500,
            lsp_fallback = not vim.tbl_contains(disable_ft, vim.bo[bufnr].filetype),
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          ruby = { "rubocop" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
        },
      })
    end,
  },
}

return spec
