# Neovim設定ガイド

## 概要

この設定はNeovim専用で、モダンなプラグインとLSPサポートを活用した開発環境を提供します。

## セットアップ手順

> **注意**: Neovimのインストール、設定ファイルのデプロイ、vimコマンドのエイリアス設定は、mitamaeスクリプト（`bin/install` または `bin/mitamae local lib/recipe.rb`）で自動的に処理されます。

### 1. プラグインのインストール

#### lazy.nvimの自動インストール

Neovimを初めて起動すると、`lazy.nvim` が自動的に `~/.local/share/nvim/lazy/lazy.nvim` へクローンされます（ `init.vim` でブートストラップ済み）。インターネット接続が必要です。

#### プラグインの同期

Neovim起動後、以下のコマンドでプラグインを同期／更新できます：

```vim
:Lazy sync
```

#### インストール確認

```vim
:Lazy health
```

**トラブルシューティング**: lazy.nvim 自体がインストールされていない場合は、手動でクローンしてください。

```bash
git clone https://github.com/folke/lazy.nvim ~/.local/share/nvim/lazy/lazy.nvim
```

#### インストール確認

```vim
:checkhealth
```

### 2. LSPサーバーのインストール

各言語のLSPサーバーを個別にインストールする必要があります。

#### Python (pyright)

```bash
npm install -g pyright
```

または

```bash
pip install pyright
```

#### TypeScript/JavaScript (tsserver)

Node.jsに含まれています。Node.jsをインストールしてください：

```bash
# macOS
brew install node

# または nvm を使用
nvm install node
```

#### Ruby (ruby_lsp)

```bash
gem install ruby-lsp
```

#### Go (gopls)

```bash
go install golang.org/x/tools/gopls@latest
```

または

```bash
# macOS
brew install gopls
```

#### Terraform (terraform_ls)

```bash
# macOS
brew install hashicorp/tap/terraform-ls
```

または、[公式リリース](https://github.com/hashicorp/terraform-ls/releases)からダウンロード

#### HTML/CSS/JSON

これらのLSPサーバーはNode.jsに含まれています。Node.jsをインストールしてください。

### 3. Tree-sitterパーサーのインストール

Tree-sitterパーサーは自動的にインストールされますが、手動でインストールすることもできます：

```vim
:TSInstall <language>
```

例：
```vim
:TSInstall python
:TSInstall ruby
:TSInstall javascript
```

すべてのパーサーをインストール：

```vim
:TSInstall all
```

### 4. オプションツール（推奨）

Telescopeのパフォーマンス向上のため、以下のツールのインストールを推奨します：

#### ripgrep (高速grep)

```bash
# macOS
brew install ripgrep
```

#### fd (高速ファイル検索)

```bash
# macOS
brew install fd
```

#### bat (シンタックスハイライト付きcat)

```bash
# macOS
brew install bat
```

これらのツールがインストールされていると、Telescopeが自動的に使用します。

### 5. 動作確認

#### プラグインの確認

Neovim起動後：

```vim
:Lazy health
:checkhealth lsp
:checkhealth treesitter
```

#### LSPサーバーの確認

各LSPサーバーが正しくインストールされているか確認：

```bash
# Python
pyright --version

# TypeScript
tsc --version

# Ruby
ruby-lsp --version

# Go
gopls version

# Terraform
terraform-ls --version
```

#### 動作テスト

1. Neovimを起動（`vim` または `nvim`）
2. 任意のファイルを開く
3. LSPが動作しているか確認（`:LspInfo`）
4. 補完が動作しているか確認（`<C-Space>`）
5. Telescopeが動作しているか確認（`<C-u><C-u>`）

## 設定ファイル構成

```
~/.config/nvim/init.vim          # Neovimエントリーポイント（lazy.nvimブートストラップ + Vimscript読み込み）
  └─ lua/
      ├── plugins/
      │   └── init.lua           # プラグイン定義（lazy.nvimのspec）
      └── config/
          ├── lsp.lua            # LSP・補完設定
          ├── telescope.lua      # Telescope設定
          └── treesitter.lua     # Tree-sitter設定

~/.vim/config/                   # 既存のVimscript設定
  ├── options.vim                # 基本オプション設定
  ├── keymaps.vim                # キーマッピング
  └── autocmd.vim                # オートコマンド
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

`~/.config/nvim/lua/plugins/init.lua` にエントリを追加します。分割したい場合はサブモジュール（例: `lua/plugins/git.lua`）を用意し、`require` で読み込んでも構いません。

### キーマッピングの変更

- 基本キーマップ: `~/.vim/config/keymaps.vim`
- LSP/補完周り: `~/.config/nvim/lua/config/lsp.lua` 内で設定

### オプション設定の変更

`~/.vim/config/options.vim` を編集します。

## トラブルシューティング

### プラグインがインストールされない

```vim
:Lazy sync
```

プラグインのクリーンアップ：

```vim
:Lazy clean
```

プラグインの状態確認：

```vim
:Lazy log
```

### LSPサーバーが起動しない

#### 各LSPサーバーのインストール確認

```bash
# Python
which pyright
pyright --version

# TypeScript/JavaScript
which tsserver
node --version

# Ruby
which ruby-lsp
ruby-lsp --version

# Go
which gopls
gopls version

# Terraform
which terraform-ls
terraform-ls --version
```

#### LSPサーバーの手動インストール

各言語のセットアップ手順を参照してください。

#### LSPの状態確認

Neovim起動後：

```vim
:LspInfo    " 現在のバッファのLSP情報
:LspLog     " LSPログを確認
```

### Tree-sitterが動作しない

#### パーサーの再インストール

```vim
:TSInstall <language>
```

例: `:TSInstall python`

#### Tree-sitterの状態確認

```vim
:TSInstallInfo    " インストール済みパーサー一覧
:checkhealth treesitter
```

### Telescopeが動作しない

#### 依存ツールの確認

```bash
# ripgrep
which rg
rg --version

# fd
which fd
fd --version
```

これらのツールがインストールされていない場合、Telescopeは標準の検索機能を使用しますが、パフォーマンスが低下する可能性があります。

### 補完が動作しない

#### nvim-cmpの確認

```vim
:checkhealth cmp
```

#### LuaSnipの確認

スニペットが展開されない場合：

```vim
:lua require('luasnip.loaders.from_vscode').lazy_load()
```

### エラーメッセージの確認

Neovim起動時にエラーが表示される場合：

```vim
:messages    " エラーメッセージを確認
```

### 設定ファイルの再読み込み

設定を変更した後、再読み込み：

```vim
:source ~/.config/nvim/init.vim
```

または、Neovimを再起動してください。

### よくある問題

#### "LSPサーバーが見つからない"

各LSPサーバーがPATHに含まれているか確認：

```bash
echo $PATH
which <lsp-server-name>
```

#### "Tree-sitterパーサーがインストールされない"

Neovimのバージョンを確認（0.5以上が必要）：

```bash
nvim --version
```

#### パフォーマンスの問題

大量のプラグインが読み込まれている場合、起動が遅くなる可能性があります。`lazy: 1` オプションで遅延読み込みを有効にしてください。
