# Neovim設定ガイド

## 概要

この設定はNeovim専用で、モダンなプラグインとLSPサポートを活用した開発環境を提供します。

## 設定ファイル構成

```
~/.config/nvim/init.vim          # Neovimエントリーポイント
  └─ ~/.vim/config/
      ├── options.vim            # 基本オプション設定
      ├── plugins.vim            # プラグイン管理（dein）
      ├── lsp.vim                # LSP・補完・Tree-sitter設定
      ├── keymaps.vim            # キーマッピング
      └── autocmd.vim            # オートコマンド

~/.vim/rc/                       # プラグイン設定ファイル（TOML）
  ├── lsp.toml                   # LSP・補完関連
  ├── treesitter.toml            # Tree-sitter
  ├── telescope.toml             # ファジーファインダー
  ├── luasnip.toml               # スニペット
  ├── powerline.toml             # ステータスライン
  ├── git.toml                   # Git関連
  ├── utility.toml               # ユーティリティ
  ├── ruby.toml                  # Ruby/RSpec
  ├── hashicorp.toml             # Terraform
  └── syntax.toml                # シンタックス（Tree-sitter未対応言語）
```

## 主要プラグイン

### コアプラグイン
- **nvim-lspconfig**: LSPクライアント
- **nvim-cmp**: 補完エンジン
- **nvim-treesitter**: 高度なシンタックスハイライト
- **Telescope.nvim**: ファジーファインダー
- **LuaSnip**: スニペットエンジン
- **lightline.vim**: ステータスライン

### その他のプラグイン
- **vim-fugitive**: Git操作
- **vim-rhubarb**: GitHub連携
- **vim-terraform**: Terraformサポート
- **vim-rspec**: RSpec実行
- **vim-surround**: 囲み文字操作
- **vim-easy-align**: テキスト整列
- **YankRing.vim**: ヤンク履歴

## 基本操作

### 起動
```bash
vim    # Neovimが起動（エイリアス設定済み）
vi     # Neovimが起動（エイリアス設定済み）
nvim   # 直接起動
```

### ペースト時の自動インデント無効化
```vim
:set paste
" ペースト後
:set nopaste
```

### コマンド履歴
```vim
q:  " コマンド履歴
q/  " 検索履歴（前方）
q?  " 検索履歴（後方）
```

## キーマッピング

### 基本操作

| キー | 機能 |
|------|------|
| `<Esc><Esc>` | 検索ハイライト解除 |
| `j` / `k` | 表示行単位で移動（折り返し対応） |
| `v` (Visual) | 行末まで選択 |

### タブ操作

| キー | 機能 |
|------|------|
| `tc` | 新しいタブを作成 |
| `tx` | 現在のタブを閉じる |
| `tn` | 次のタブへ移動 |
| `tp` | 前のタブへ移動 |
| `:tabonly` | 現在のタブ以外を閉じる |

### Telescope（ファジーファインダー）

| キー | 機能 |
|------|------|
| `<C-u><C-u>` | ファイル検索（再帰的） |
| `<C-u><C-d>` | 現在ディレクトリのファイル検索 |
| `<C-u><C-b>` | バッファ一覧 |
| `/` | ライブgrep検索 |
| `*` | カーソル下の単語でgrep |
| `ft` | ファイルタイプ一覧 |
| `<C-u><C-t>` | バッファ一覧（タブ切り替え） |

### LSP（Language Server Protocol）

| キー | 機能 |
|------|------|
| `gD` | 宣言へジャンプ |
| `gd` | 定義へジャンプ |
| `K` | ホバー情報表示 |
| `gi` | 実装へジャンプ |
| `<C-k>` | シグネチャヘルプ |
| `<space>rn` | リネーム |
| `<space>ca` | コードアクション |
| `gr` | 参照一覧 |
| `<space>D` | 型定義へジャンプ |
| `<space>e` | 診断情報をフロート表示 |
| `[d` | 前の診断へ |
| `]d` | 次の診断へ |
| `<space>q` | 診断をロケーションリストに表示 |

### 補完（nvim-cmp）

| キー | 機能 |
|------|------|
| `<C-Space>` | 補完開始 |
| `<Tab>` | 次の候補 / スニペット展開 |
| `<S-Tab>` | 前の候補 / スニペット戻る |
| `<C-b>` | ドキュメントを上にスクロール |
| `<C-f>` | ドキュメントを下にスクロール |
| `<CR>` | 選択して確定 |
| `<C-e>` | 補完を閉じる |

### LuaSnip（スニペット）

| キー | 機能 |
|------|------|
| `<C-k>` | スニペット展開 / 次のジャンプポイントへ |
| `<C-j>` | 前のジャンプポイントへ |

### Tree-sitter Textobjects

| キー | 機能 |
|------|------|
| `af` | 関数全体を選択（outer） |
| `if` | 関数内部を選択（inner） |
| `ac` | クラス全体を選択（outer） |
| `ic` | クラス内部を選択（inner） |

### Git操作（vim-fugitive）

| キー | 機能 |
|------|------|
| `<Space>gd` | git diff |
| `<Space>gs` | git status |
| `<Space>gc` | git commit |
| `<Space>gb` | git blame |
| `:Gbrowse` | GitHubで該当行を開く |

### ユーティリティ

| キー | 機能 |
|------|------|
| `<C-c>` | クリップボードにコピー（Mac OS X） |
| `<Enter>` (Visual) | EasyAlign開始 |
| `<Leader>a` | EasyAlign開始 |
| `cs'"` | 囲み文字を `'` から `"` に変更 |
| `ds'` | 囲み文字 `'` を削除 |
| `csw'` | 単語を `'` で囲む |
| `:FixWhitespace` | 末尾の空白を削除 |

### RSpec（vim-rspec）

| キー | 機能 |
|------|------|
| `<Leader>t` | 現在のspecファイルを実行 |
| `<Leader>s` | 最も近いspecを実行 |
| `<Leader>l` | 最後に実行したspecを実行 |
| `<Leader>a` | すべてのspecを実行 |

## LSPサーバー

以下の言語でLSPが有効です：

- **Python**: pyright
- **TypeScript/JavaScript**: tsserver
- **Ruby**: ruby_lsp
- **Go**: gopls
- **Terraform**: terraform_ls
- **HTML**: html
- **CSS**: cssls
- **JSON**: jsonls

各LSPサーバーは自動的にインストール・起動されます。

## Tree-sitter

以下の言語でTree-sitterが有効です：

- bash, c, cpp, css, dockerfile, go, html, javascript
- json, lua, make, markdown, python, ruby, rust, scss
- sql, toml, typescript, vim, yaml

Tree-sitterでカバーできない言語（haml、slim、dosini）は従来のシンタックスプラグインを使用します。

## 設定のカスタマイズ

### プラグインの追加

`~/.vim/rc/` 配下に新しい `.toml` ファイルを作成し、`~/.vim/config/plugins.vim` で読み込むように設定します。

### キーマッピングの変更

- 基本キーマップ: `~/.vim/config/keymaps.vim`
- LSPキーマップ: `~/.vim/config/lsp.vim` のLuaコード内

### オプション設定の変更

`~/.vim/config/options.vim` を編集します。

## トラブルシューティング

### プラグインがインストールされない

```vim
:call dein#install()
```

### LSPサーバーが起動しない

各LSPサーバーがインストールされているか確認してください：

```bash
# 例: pyright
npm install -g pyright

# 例: ruby_lsp
gem install ruby-lsp
```

### Tree-sitterが動作しない

```vim
:TSInstall <language>
```

例: `:TSInstall python`
