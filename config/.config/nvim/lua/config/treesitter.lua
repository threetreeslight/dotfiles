-- nvim-treesitter (main branch): parsers are compiled with tree-sitter CLI
-- (installed by cookbooks/vim). Highlight/indent are enabled per filetype.
local M = {}

local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "python",
  "ruby",
  "rust",
  "scss",
  "sql",
  "toml",
  "typescript",
  "vim",
  "yaml",
}

local function setup_textobjects()
  require("nvim-treesitter-textobjects").setup({
    select = { lookahead = true },
  })

  local select = require("nvim-treesitter-textobjects.select")
  local objects = {
    af = "@function.outer",
    ["if"] = "@function.inner",
    ac = "@class.outer",
    ic = "@class.inner",
  }
  for lhs, query in pairs(objects) do
    vim.keymap.set({ "x", "o" }, lhs, function()
      select.select_textobject(query, "textobjects")
    end, { desc = "Select " .. query })
  end
end

function M.setup()
  local ts = require("nvim-treesitter")
  ts.setup()
  if #vim.api.nvim_list_uis() > 0 then
    ts.install(parsers) -- async; no-op for parsers already installed
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if not lang or not pcall(vim.treesitter.start, args.buf, lang) then
        return -- no parser for this filetype: keep regex syntax
      end
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  setup_textobjects()
end

return M
