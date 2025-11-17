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

" 設定ファイルの読み込み
" ~/.vim/config から設定を読み込む
let s:config_dir = expand('~/.vim/config')

execute 'source ' . s:config_dir . '/options.vim'
execute 'source ' . s:config_dir . '/keymaps.vim'
execute 'source ' . s:config_dir . '/autocmd.vim'

lua <<'EOF'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
EOF
