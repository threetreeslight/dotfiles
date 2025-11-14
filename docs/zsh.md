# zsh

## コマンド

### プロセス管理

```bash
# プロセスをpecoで選択してkill
$ ppkill [query]

# プロセスのPIDをpecoで選択して取得
$ ppgrep [query]
```

### Git操作

```bash
# ローカルブランチをpecoで選択してcheckout
$ pgu [query]

# リモートブランチも含めてpecoで選択してcheckout
$ pgo [query]

# ローカルブランチ一覧をpecoで表示
$ pgb [query]
```

### ディレクトリ移動

```bash
# ghqで管理されているリポジトリに移動
$ gcd [query]
```

### エイリアス

```bash
$ g          # git
$ be         # bundle exec
$ ll         # ls -laG
$ vi         # /usr/bin/vim
```

## キーバインド

* `ctrl + r` : コマンド履歴をpecoで検索
* `ctrl + u` : コマンドラインをリセット
* `cd -` : 前のディレクトリに戻る
* `cd -<TAB>` : 履歴からディレクトリを選択

