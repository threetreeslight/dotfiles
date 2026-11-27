# Git

設定ファイル: `config/.gitconfig`, `config/.git_template/`

## 基本設定

- ユーザー名・メールアドレスなどマシン固有の設定は `~/.gitconfig.local` に書く（`[include]` で読み込み、リポジトリには含めない）

  ```ini
  [user]
    name = Your Name
    email = you@example.com
  ```

- `user.useConfigOnly = true`：名前・メールアドレスが未設定ならコミットをエラーにする（OS のアカウント名とホスト名から勝手に作らせない。SSH 署名を GitHub で Verified にするにはメールアドレスの一致が必要）
- `init.defaultBranch = main`
- `branch.autosetuprebase = always`（pull は rebase）
- `merge.ff = false`（merge 時は常にマージコミットを作る）、`merge.conflictstyle = zdiff3`
- `origin` の fetch で GitHub の PR を `origin/pr/<番号>` として取得
- GitHub の認証は `gh auth git-credential`
- ghq のルートは `~/src`
- グローバル ignore: [github/gitignore](https://github.com/github/gitignore) の `Global/*.gitignore` を結合して `~/.config/git/ignore` を生成

## ページャー（delta）

[delta](https://github.com/dandavison/delta) で `git diff` / `log -p` / `show` / `add -p` をシンタックスハイライト付きで表示します。

- 行番号を表示（`line-numbers`）
- `n` / `N` で次 / 前のファイルへ移動（`navigate`）
- 移動した行を別の色で表示（`diff.colorMoved`）

## エイリアス

| エイリアス | 内容 |
|---|---|
| `git st` | `status --short --branch` |
| `git co` / `ci` / `br` | checkout / commit / branch |
| `git lo` | グラフ付きの 1 行ログ |
| `git g` | 見出し付きの `git grep` |
| `git pr` | `gh pr create --fill` |
| `git review` | デフォルトブランチから分岐した後のコミットを tig で確認 |
| `git default-branch` | リモートのデフォルトブランチ（`origin/main` など。リモートがなければ `main` か `master`） |
| `git branch-root` | デフォルトブランチとの merge-base |
| `git delete-merged-branches` | マージ済みのローカルブランチを削除（`main` / `master` と現在のブランチは残す） |

## フック

`init.templatedir` により、新しく clone / init したリポジトリに入ります。既存のリポジトリに入れるには、そのリポジトリで `git init` を再実行してください。

| フック | 内容 |
|---|---|
| `pre-commit` / `commit-msg` / `prepare-commit-msg` | git-secrets で AWS の認証情報などのコミットを防ぐ |
| `pre-push` | `main` / `master` への force push と削除を防ぐ（`--no-verify` で回避可能） |
