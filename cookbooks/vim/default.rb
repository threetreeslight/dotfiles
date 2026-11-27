# Neovimパッケージ
package 'neovim'

# mason.nvim で LSP サーバーを入れるのに必要 (pyright, ts_ls, html, cssls, jsonls)
# gopls 用の go は cookbooks/go で入れる
package 'node'

# nvim-treesitter (main branch) が parser のビルドに使う
package 'tree-sitter-cli'

# Neovim設定ファイル
dotconfig 'nvim'
