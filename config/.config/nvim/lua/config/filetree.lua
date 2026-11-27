-- nvim-tree: file explorer in a side window.
-- Source Code Pro is not a Nerd Font, so file/folder icons are off and the
-- remaining glyphs are plain Unicode.
local M = {}

function M.setup()
  require("nvim-tree").setup({
    view = { width = 32 },
    renderer = {
      group_empty = true,
      icons = {
        show = { file = false, folder = false, folder_arrow = true, git = true },
        glyphs = {
          folder = { arrow_closed = "▸", arrow_open = "▾" },
          git = {
            unstaged = "M",
            staged = "S",
            unmerged = "U",
            renamed = "R",
            untracked = "?",
            deleted = "D",
            ignored = "!",
          },
        },
      },
    },
    filters = { git_ignored = false },
    diagnostics = { enable = false },
  })

  local api = require("nvim-tree.api")
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
  end
  map("<C-u><C-t>", function()
    api.tree.toggle({ find_file = false, focus = true })
  end, "File tree toggle")
  map("<C-u><C-f>", function()
    api.tree.find_file({ open = true, focus = true })
  end, "File tree: reveal current file")
end

return M
