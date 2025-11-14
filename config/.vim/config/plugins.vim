"-------------------------
" プラグイン管理 (dein)
"-------------------------

" dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" Required:
let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim が存在しない場合は自動インストール
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

execute 'set runtimepath+=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  " プラグイン設定ファイルの読み込み
  let g:rc_dir = expand('~/.vim/rc')
  
  " コアプラグイン（LSP、補完、Tree-sitter）
  call dein#load_toml(g:rc_dir . '/lsp.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/treesitter.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/luasnip.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/telescope.toml', {'lazy': 0})
  
  " その他のプラグイン
  call dein#load_toml(g:rc_dir . '/powerline.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/git.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/hashicorp.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/syntax.toml', {'lazy': 1})
  call dein#load_toml(g:rc_dir . '/utility.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/ruby.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

