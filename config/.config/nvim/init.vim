" Neovim設定ファイル
" Neovim専用の設定です

" 基本設定
if has('vim_starting')
  set nocompatible
endif

" Neovim固有の設定
if has('nvim')
  set termguicolors
endif

" 設定ファイルの読み込み (~/.config/nvim/vimscript 配下)
let s:config_dir = expand('~/.config/nvim/vimscript')
execute 'source ' . fnameescape(s:config_dir . '/options.vim')
execute 'source ' . fnameescape(s:config_dir . '/keymaps.vim')
execute 'source ' . fnameescape(s:config_dir . '/autocmd.vim')

lua <<EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- Bootstrap lazy.nvim at the commit pinned in lazy-lock.json so the lock is
  -- the single source of truth for every plugin, including lazy.nvim itself.
  local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
  local ok, lock = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(lockfile), "\n"))
  end)
  local commit = ok and lock["lazy.nvim"] and lock["lazy.nvim"].commit

  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  if commit then
    vim.fn.system({ "git", "-C", lazypath, "checkout", "--quiet", commit })
  end
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to bootstrap lazy.nvim", "ErrorMsg" } }, true, {})
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
EOF
