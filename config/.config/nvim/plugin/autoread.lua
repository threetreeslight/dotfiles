-- Reload buffers changed on disk by other tools (e.g. Claude Code in another pane).
-- Unmodified buffers reload silently; buffers with unsaved edits get a warning instead.
vim.o.autoread = true

local function checktime()
  -- :checktime is not allowed in the command-line window or while typing a command
  if vim.fn.getcmdwintype() == "" and not vim.fn.mode():match("^[cr!t]") then
    vim.cmd("checktime")
  end
end

local group = vim.api.nvim_create_augroup("auto_reload", { clear = true })

-- immediately when coming back to nvim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
  group = group,
  callback = checktime,
})

-- and every second while idle, since CursorHold fires only once after a keypress
-- and focus does not change when another pane in the same window edits the file
local timer = vim.uv.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(checktime))

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    timer:stop()
    timer:close()
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = group,
  callback = function(args)
    vim.notify("Reloaded: " .. vim.fn.fnamemodify(args.file, ":~:."), vim.log.levels.INFO)
  end,
})
