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
execute 'source ' . s:config_dir . '/plugins.vim'
execute 'source ' . s:config_dir . '/lsp.vim'
execute 'source ' . s:config_dir . '/keymaps.vim'
execute 'source ' . s:config_dir . '/autocmd.vim'
