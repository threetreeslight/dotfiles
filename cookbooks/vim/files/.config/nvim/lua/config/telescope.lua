local M = {}

function M.setup()
  local actions = require("telescope.actions")
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["q"] = actions.close,
        },
      },
    },
  })

  local builtin = require("telescope.builtin")
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
  end

  map("<C-u><C-u>", builtin.find_files, "Telescope find files")
  map("<C-u><C-d>", function()
    builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
  end, "Telescope find files (buffer dir)")
  map("<C-u><C-b>", builtin.buffers, "Telescope buffers")
  map("/", function()
    builtin.live_grep({})
  end, "Telescope live grep")
  map("*", builtin.grep_string, "Telescope grep word")
  map("ft", ":Telescope filetypes<CR>", "Telescope filetypes")
  map("<C-u><C-t>", builtin.buffers, "Telescope buffers (tab)")
end

return M
