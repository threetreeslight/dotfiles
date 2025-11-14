# dotfiles

threetreeslight's dotfiles setting

# Getting Started

Install Xcode and Accept licence & install command line tools

```bash
sudo xcodebuild -license
> press agree

xcode-select --install
```

Install

```bash
curl -o- https://raw.githubusercontent.com/threetreeslight/dotfiles/master/bin/install | bash
# OR
./bin/install
```

# Other Usage

install mitamae

```bash
bin/setup
```

cook

```bash
bin/mitamae local -y nodes/darwin.yml roles/darwin.rb
```

# Settings

common
- [tmux](docs/tmux.md)
- [tig](docs/tig.md)
- [vim](docs/vim.md)
- [zsh](docs/zsh.md)

osx
- [osx](docs/osx.md)

# TODO

- vim
  - [ ] automate dein installation
  - [ ] modify syntax highlight
  - [ ] Highlight FullWidthSpace cleary
  - [ ] complement setting
  - [ ] modify ctag setting
  - [ ] split vimrc setting
  - [ ] modify filetype detection
