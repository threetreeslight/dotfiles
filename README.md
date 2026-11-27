# dotfiles

threetreeslight's dotfiles setting

[mitamae](https://github.com/itamae-kitchen/mitamae) で macOS の開発環境（パッケージ・アプリ・設定ファイル）を構築します。

## 前提条件

- macOS（Apple Silicon / Intel）
- Xcode の利用規約同意と Command Line Tools

  ```bash
  sudo xcodebuild -license   # agree を入力
  xcode-select --install
  ```

- [Homebrew](https://brew.sh/)（レシピでは自動インストールしないので、事前に入れてください）

## インストール

```bash
curl -o- https://raw.githubusercontent.com/threetreeslight/dotfiles/master/bin/install | bash
# または、clone 済みなら
./bin/install
```

設定を変えたあとに再適用するときは次を実行します。

```bash
bin/mitamae local lib/recipe.rb      # 適用
bin/mitamae local -n lib/recipe.rb   # dry-run
```

インストール後に必要な手動作業:

1. `~/.gitconfig.local` に Git のユーザー名とメールアドレスを書く（[docs/git.md](docs/git.md)）
2. 1Password の SSH エージェントを有効にする（[docs/ssh.md](docs/ssh.md)）

## 構成

| ツール | 概要 | ドキュメント |
|---|---|---|
| セットアップ | mitamae の流れ、cookbook、インストールするパッケージとアプリ | [docs/setup.md](docs/setup.md) |
| zsh | vi モード、starship のプロンプト、fzf の関数とキーバインド | [docs/zsh.md](docs/zsh.md) |
| Git | delta、エイリアス、git-secrets と force push 防止のフック | [docs/git.md](docs/git.md) |
| SSH | 1Password の SSH エージェント | [docs/ssh.md](docs/ssh.md) |
| tmux | vim 風のペイン操作、vi のコピーモード | [docs/tmux.md](docs/tmux.md) |
| Neovim | lazy.nvim、LSP（mason）、Telescope、保存時のフォーマット | [docs/vim.md](docs/vim.md) |
| tig | GitHub で開く、インタラクティブ rebase | [docs/tig.md](docs/tig.md) |
| macOS | Finder の設定など | [docs/osx.md](docs/osx.md) |

## ディレクトリ構成

```
.
├── bin/          install（エントリーポイント）、setup（mitamae の取得）
├── lib/          mitamae のエントリーレシピとヘルパー
├── roles/darwin/ macOS で適用する cookbook の一覧と、パッケージ・アプリのリスト
├── cookbooks/    ツールごとのレシピ
├── config/       ホームディレクトリにリンクされる設定ファイル本体
└── docs/         ドキュメント
```

`config/` 以下はシンボリックリンクなので、編集するとすぐに反映されます（zsh は `exec $SHELL -l`、tmux は `prefix + r` で再読み込み）。

## カスタマイズ

| やりたいこと | 編集する場所 |
|---|---|
| brew パッケージを追加する | `roles/darwin/files/packages.yaml` |
| GUI アプリを追加する | `roles/darwin/files/apps.yaml` |
| dotfile を追加する | `config/` に置き、cookbook で `dotfile '<名前>'` を呼ぶ |
| `~/.config` 配下の設定を追加する | `config/.config/` に置き、`dotconfig '<名前>'` を呼ぶ |
| 新しいツールの cookbook を作る | `cookbooks/<名前>/default.rb` を作り、`roles/darwin/default.rb` に `include_cookbook '<名前>'` を追加 |

## TODO

- vim
  - [x] automate plugin installation (lazy.nvim)
  - [ ] modify syntax highlight
  - [ ] Highlight FullWidthSpace cleary
  - [ ] complement setting
  - [ ] split vimrc setting
  - [ ] modify filetype detection
