# zsh

設定ファイル: `config/.zshrc`, `config/.zsh/`

## プロンプト

[starship](https://starship.rs/) を使います（設定: `config/.config/starship.toml`）。

```
~/src/github.com/owner/repo main [!?]
%
```

- 1 行目: カレントディレクトリ（黄）、Git ブランチ（緑）、Git の状態（赤）、3 秒以上かかったコマンドの実行時間
- 2 行目: `%`。直前のコマンドが失敗すると赤、vi のノーマルモードでは `:`

starship が入っていない場合は、`vcs_info` を使った同じレイアウトの簡易プロンプトになります。

## fzf を使うコマンド

`fzf --zsh` のキーバインドと補完に加えて、次の関数を定義しています（`config/.zsh/utils/`）。

```bash
# ghq で管理しているリポジトリへ移動
$ gcd [query]

# GitHub org のリポジトリを選んで ghq get（Tab で複数選択）
$ gget <org> [query]

# ローカルブランチを選んで表示 / switch
$ pgb [query]
$ pgu [query]

# リモートブランチも含めて選んで switch（リモートのみのブランチは追跡ブランチを作る）
$ pgo [query]

# プロセスを選んで PID を表示 / kill（TAB で複数選択）
$ ppgrep [query]
$ ppkill [query] [-SIGNAL]
```

ブランチ選択では直近 20 件のログを、`gcd` ではディレクトリの中身をプレビュー表示します。

## キーバインド

| キー | 動作 |
|---|---|
| `Ctrl-r` | コマンド履歴を fzf で検索 |
| `Ctrl-t` | tmux セッションを fzf で選んで切り替え（fzf 標準のファイル選択を上書き） |
| `Alt-c` | サブディレクトリを fzf で選んで移動 |
| `**<TAB>` | パスやプロセスなどを fzf で補完（例: `vim **<TAB>`, `kill **<TAB>`） |
| `Ctrl-p` / `Ctrl-n` | 入力中の文字列で始まる履歴を前後に検索 |
| `cd -<TAB>` | ディレクトリ移動履歴から選択 |

キーバインドは vi モード（`bindkey -v`）です。

## エイリアス

```bash
$ g          # git
$ be         # bundle exec
$ ll         # ls -laG
$ vim / vi   # nvim
$ rm/cp/mv   # -i 付き（確認あり）
$ diff       # delta（なければ diff -u）
```

## 履歴

- 10000 件を保存し、セッション間で共有
- 先頭にスペースを付けたコマンドは履歴に残さない（トークンなどを含むコマンド向け）
