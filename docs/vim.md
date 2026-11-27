# Neovim

設定ファイル: `config/.config/nvim/`（`~/.config/nvim` にリンク）。Neovim 0.11 以降が前提です。

## セットアップ

Neovim 本体、node（mason で LSP を入れるのに必要）、go（gopls 用）、設定ファイルのリンクは `bin/mitamae local lib/recipe.rb` で用意されます。その後は Neovim を起動するだけです。

1. 初回起動時に [lazy.nvim](https://github.com/folke/lazy.nvim) が `~/.local/share/nvim/lazy/` にクローンされ、プラグインが `lazy-lock.json` のコミットでインストールされます
2. [mason.nvim](https://github.com/mason-org/mason.nvim) が LSP サーバーとフォーマッタを自動でインストールします（`:Mason` で状態を確認）
3. Tree-sitter パーサーも自動でインストールされます（nvim-treesitter の main ブランチを使用。パーサーのビルドに tree-sitter CLI が必要で、これも cookbook で入ります）

Telescope を速くするために、`ripgrep` と `fd` を入れておくのがおすすめです（`brew install ripgrep fd`）。

## ファイル構成

```
~/.config/nvim/
├── init.vim               エントリーポイント（Vimscript 読み込み + lazy.nvim の起動）
├── lazy-lock.json         プラグインのバージョン固定
├── lua/
│   ├── plugins/init.lua   プラグイン定義
│   └── config/
│       ├── lsp.lua        LSP・補完・ワークスペーストラスト
│       ├── telescope.lua  Telescope
│       └── treesitter.lua Tree-sitter
├── vimscript/
│   ├── options.vim        基本オプション
│   ├── keymaps.vim        キーマップ・タブライン
│   └── autocmd.vim        オートコマンド
└── ftplugin/              ファイルタイプ別のインデント設定（html, python, ruby）
```

## プラグイン

| プラグイン | 役割 |
|---|---|
| nvim-lspconfig + mason.nvim + mason-lspconfig.nvim | LSP の設定とサーバーのインストール |
| nvim-cmp（+ cmp-nvim-lsp / buffer / path / cmdline） | 補完 |
| LuaSnip + friendly-snippets | スニペット |
| nvim-treesitter + nvim-treesitter-textobjects | シンタックスハイライト、インデント、テキストオブジェクト |
| telescope.nvim | ファジーファインダー |
| conform.nvim | 保存時のフォーマット |
| lualine.nvim | ステータスライン |
| vim-fugitive | Git 操作 |
| mini.surround | 囲み文字の操作 |
| mini.trailspace | 行末の空白をハイライト |

## LSP

| 言語 | サーバー |
|---|---|
| Python | pyright |
| TypeScript / JavaScript | ts_ls |
| Ruby | ruby_lsp |
| Go | gopls |
| Terraform | terraformls |
| HTML / CSS / JSON | html / cssls / jsonls |

### ワークスペーストラスト

ruby_lsp、ts_ls、gopls はプロジェクト内のコード（Gemfile、`node_modules/typescript`、go ツールチェーン）を実行するため、信頼したディレクトリでだけ起動します。

- 最初から信頼済み: `~/dotfiles`、`~/src/github.com/threetreeslight`
- それ以外のプロジェクトでは `:LspTrust` を実行すると信頼リストに追加されます（`~/.local/state/nvim/lsp_trusted_dirs`）

## フォーマット

保存時に conform.nvim でフォーマットします。フォーマッタは mason がインストールします。

| ファイルタイプ | フォーマッタ |
|---|---|
| Lua | stylua |
| Python | black |
| JS / TS / JSON / CSS | biome |
| YAML | yamlfmt |
| その他 | LSP のフォーマット（Markdown は無効） |

prettier と rubocop は、プロジェクトの設定ファイル経由で任意のコードを実行できるので使っていません。

## キーマップ

### 基本

| キー | 動作 |
|---|---|
| `<Esc><Esc>` | 検索ハイライトを消す |
| `j` / `k` | 表示行単位で移動 |
| `v`（ビジュアル） | 行末まで選択 |

括弧（`{` `[` `(`）は入力すると自動で閉じます。ヤンクは `clipboard=unnamedplus` でそのまま macOS のクリップボードに入ります。

### タブ

| キー | 動作 |
|---|---|
| `tc` | 新しいタブ |
| `tx` | タブを閉じる |
| `tn` / `tp` | 次 / 前のタブ |

### Telescope

| キー | 動作 |
|---|---|
| `<C-u><C-u>` | ファイル検索 |
| `<C-u><C-d>` | 現在のファイルのディレクトリでファイル検索 |
| `<C-u><C-b>` | バッファ一覧 |
| `/` | ライブ grep |
| `*` | カーソル下の単語で grep |
| `ft` | ファイルタイプ一覧 |
| `<C-j>` / `<C-k>`（Telescope 内） | 候補を移動 |

> `/` と `*` を Telescope に割り当てているため、Vim 標準のバッファ内検索は `?` か `:/pattern` を使ってください。

### LSP

| キー | 動作 |
|---|---|
| `gd` / `gD` | 定義 / 宣言へジャンプ |
| `gi` | 実装へジャンプ |
| `gr` | 参照一覧 |
| `<space>D` | 型定義へジャンプ |
| `K` | ホバー |
| `<C-k>`（ノーマル） | シグネチャヘルプ |
| `<space>rn` | リネーム |
| `<space>ca` | コードアクション |
| `<space>e` | 診断をフロートで表示 |
| `[d` / `]d` | 前 / 次の診断へ |
| `<space>q` | 診断をロケーションリストへ |
| `<space>wa` / `wr` / `wl` | ワークスペースフォルダの追加 / 削除 / 一覧 |

### 補完とスニペット

| キー | 動作 |
|---|---|
| `<C-Space>` | 補完を開く |
| `<Tab>` / `<S-Tab>` | 次 / 前の候補、またはスニペットのジャンプ |
| `<CR>` | 確定 |
| `<C-e>` | 閉じる |
| `<C-b>` / `<C-f>` | ドキュメントをスクロール |
| `<C-k>` / `<C-j>`（挿入） | スニペットの次 / 前のジャンプポイント |

### テキストオブジェクト（Tree-sitter）

| キー | 対象 |
|---|---|
| `af` / `if` | 関数（全体 / 内部） |
| `ac` / `ic` | クラス（全体 / 内部） |

### Git（vim-fugitive）

| キー / コマンド | 動作 |
|---|---|
| `<Space>gs` | `:Git`（ステータス） |
| `<Space>gd` | `:Gdiffsplit` |
| `<Space>gc` | `:Git commit` |
| `<Space>gb` | `:Git blame` |

### 編集

| キー | 動作 |
|---|---|
| `sa{motion}{char}` | 囲み文字を追加（例: `saiw"`） |
| `sd{char}` | 囲み文字を削除 |
| `sr{old}{new}` | 囲み文字を置換（例: `sr'"`） |
| `:lua MiniTrailspace.trim()` | 行末の空白を削除 |

## カスタマイズ

| 変更したいもの | ファイル |
|---|---|
| プラグイン | `lua/plugins/init.lua` |
| 基本キーマップ | `vimscript/keymaps.vim` |
| LSP / 補完のキーマップ、LSP サーバー | `lua/config/lsp.lua` |
| オプション | `vimscript/options.vim` |

プラグインを追加・更新したら、`:Lazy sync` で `lazy-lock.json` を更新してコミットします。

## トラブルシューティング

| 症状 | 確認方法 |
|---|---|
| プラグインが入らない / 壊れた | `:Lazy`、`:Lazy restore`（lock どおりに戻す）、`:Lazy clean` |
| LSP が起動しない | `:checkhealth vim.lsp`、`:Mason`、信頼済みディレクトリか確認（`:LspTrust`） |
| Tree-sitter のハイライトがおかしい | `:TSUpdate`、`:checkhealth nvim-treesitter` |
| 起動時にエラーが出る | `:messages`、`:checkhealth` |
