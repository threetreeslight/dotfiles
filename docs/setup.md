# セットアップの仕組み

[mitamae](https://github.com/itamae-kitchen/mitamae) のレシピで、パッケージのインストールと設定ファイルのリンクを行います。レシピは何度実行しても同じ結果になります。

## 実行の流れ

```
bin/install
  ├─ ~/dotfiles がなければ clone
  ├─ bin/setup                     mitamae v1.14.4 を取得（SHA256 検証）し、bin/mitamae にリンク
  └─ bin/mitamae local lib/recipe.rb
       ├─ lib/recipe_helper.rb     include_cookbook / include_role を定義
       ├─ lib/cookbook_helper.rb   dotfile / dotconfig / ghq リソースを定義
       └─ roles/darwin/default.rb  macOS で適用する cookbook の一覧
            └─ cookbooks/*         各ツールのインストールと設定のリンク
```

macOS では sudo なしで実行します（Homebrew が sudo での実行を許可しないため）。

```bash
bin/mitamae local lib/recipe.rb      # 適用
bin/mitamae local -n lib/recipe.rb   # dry-run（変更内容の確認だけ）
```

## 独自リソース（`lib/cookbook_helper.rb`）

| リソース | 動作 |
|---|---|
| `dotfile '.zshrc'` | `~/.zshrc` から `config/.zshrc` へのシンボリックリンクを作る |
| `dotconfig 'nvim'` | `~/.config/nvim` から `config/.config/nvim` へのシンボリックリンクを作る |
| `ghq 'owner/repo'` | `ghq get` でリポジトリを `~/src/github.com/owner/repo` に取得する |
| `brew_tap` / `brew_cask` | `cookbooks/homebrew` で定義。tap と cask を冪等にインストールする |

## cookbook

`roles/darwin/default.rb` から次の順に適用します。

| cookbook | インストールするもの | リンク・生成する設定 |
|---|---|---|
| `homebrew` | `brew update && brew cleanup` | - |
| `git` | git, git-lfs, git-secrets | `~/.gitconfig`, `~/.git_template`, `~/.config/git/ignore`（生成） |
| `os` (darwin) | Finder で隠しファイルを表示 | - |
| `font` (darwin) | Source Code Pro | - |
| `go` | go, [ghq](https://github.com/x-motemen/ghq) v1.8.0 | - |
| `ssh` | `~/.ssh`（0700）, `~/.ssh/config`（0600） | 1Password の IdentityAgent を追記 |
| `tmux` | tmux | `~/.tmux.conf` |
| `vim` | neovim, node（mason の LSP 用） | `~/.config/nvim` |
| `zsh` | zsh, zsh-completions | `~/.zshrc`, `~/.zsh`, `~/.config/starship.toml` |
| `defaults` | `packages.yaml` と `apps.yaml` の内容 | `~/.tigrc` |

## パッケージ（`roles/darwin/files/packages.yaml`）

| パッケージ | 用途 |
|---|---|
| coreutils | GNU 版コマンド |
| fzf | ファジーファインダー（zsh の履歴検索やユーティリティで使用） |
| gh | GitHub CLI（`git pr`、Git の認証、tig から GitHub を開く） |
| git-delta | Git のページャー（シンタックスハイライト付き diff） |
| starship | シェルのプロンプト |
| tig | Git のテキスト UI |
| tree | ディレクトリツリー表示 |

## アプリ（`roles/darwin/files/apps.yaml`）

| アプリ | 用途 |
|---|---|
| 1password | パスワード管理・SSH エージェント |
| 1password-cli | 1Password の CLI（`op`） |
| cmux | ターミナル |
| ghostty | ターミナル |
| google-chrome | ブラウザ |
| google-gemini | Gemini のデスクトップアプリ |
| google-japanese-ime | 日本語入力 |
| hotkeyclash | ショートカットの衝突チェック |
| keepingyouawake | スリープ防止 |
| omniwm | タイル型ウィンドウマネージャー |
| slack | チャット |
| zoom | ビデオ会議 |
