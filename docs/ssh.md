# SSH

SSH 鍵は 1Password の SSH エージェントから使います。`cookbooks/ssh` が次の処理を行います。

- `~/.ssh` を 0700、`~/.ssh/config` を 0600 で作成（既存のファイルは残す）
- `~/.ssh/config` に次の設定を追記（すでにあれば何もしない）

```
Host *
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

1Password アプリの「設定 → 開発者 → SSH エージェント」を有効にしてください。接続できるかは `ssh -T git@github.com` で確認できます。
