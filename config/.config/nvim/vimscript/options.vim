"-------------------------
" 基本オプション設定
"-------------------------

" 表示設定
set colorcolumn=120
set cmdheight=2
set laststatus=2
set mouse=a
set nowrap
set number
set ruler
set showmode
set showcmd
set title
set visualbell
set vb t_vb=

" 不可視文字の表示
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

" タブ・インデント設定
set smartindent
set ts=2 sw=2 sts=0
set expandtab
set backspace=indent,eol,start

" カラースキーム
syntax enable
colorscheme desert

" バックアップ設定
set nobackup
set noswapfile
set nowritebackup

" 挿入モード設定
set hidden
set infercase
set matchpairs& matchpairs+=<:>
set nostartofline
set shiftround
set showmatch
set switchbuf=useopen

" 検索設定
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" 補完設定
set wildmenu

" クリップボード設定
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" ファイルタイプ設定
filetype plugin indent on

