# dotfiles

threetreeslight's dotfiles setting

# Getting Started

Install Xcode and Accept licence & install command line tools

```bash
sudo xcodebuild -license
xcode-select --install
```

Install

```bash
curl -o- https://raw.githubusercontent.com/threetreeslight/dotfiles/install | bash
```

# Othre usage

```bash
# install mitamae
bin/setup

# cook
bin/mitamae local -y nodes/darwin.yml roles/darwin.rb
```

Load local settings

- Dropbox contents loaded

```bash
$HOME/dotfiles/bin/install_local
```

# Application Settings

common
- [tmux](docs/tmux.md)
- [tig](docs/tig.md)
- [vim](docs/vim.md)
- [zsh](docs/zsh.md)

osx
- [osx](docs/osx.md)
- [iterm2](docs/iterm2.md)

VirtualBox

- download from <http://www.modern.ie>
  - ie9 win7
- NAT
- Bridge network

