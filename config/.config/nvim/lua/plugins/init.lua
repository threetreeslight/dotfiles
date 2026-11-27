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
    "hashivim/vim-terraform",
    config = function()
      vim.g.terraform_align = 1
    end,
  },
  {
    "thoughtbot/vim-rspec",
    dependencies = { "tpope/vim-dispatch" },
    config = function()
      vim.g.rspec_command = "Dispatch rspec {spec}"
      vim.keymap.set("n", "<Leader>t", ":call RunCurrentSpecFile()<CR>", { silent = true, desc = "RSpec file" })
      vim.keymap.set("n", "<Leader>s", ":call RunNearestSpec()<CR>", { silent = true, desc = "RSpec nearest" })
      vim.keymap.set("n", "<Leader>l", ":call RunLastSpec()<CR>", { silent = true, desc = "RSpec last" })
      vim.keymap.set("n", "<Leader>a", ":call RunAllSpecs()<CR>", { silent = true, desc = "RSpec all" })
    end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "<Enter>", "<Plug>(EasyAlign)", { silent = true })
      vim.keymap.set("n", "<Leader>a", "<Plug>(EasyAlign)", { silent = true })
    end,
  },
  { "vim-scripts/YankRing.vim" },
  { "vim-scripts/surround.vim" },
  { "bronson/vim-trailing-whitespace" },
}

return spec
