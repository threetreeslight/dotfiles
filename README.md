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
```

# Othre Usage

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
- [iterm2](docs/iterm2.md)

VirtualBox

- download from <http://www.modern.ie>
  - ie9 win7
- NAT
- Bridge network

# TODO

- vim
  - [ ] automate dein installation
  - [ ] modify syntax highlight
  - [ ] Highlight FullWidthSpace cleary
  - [ ] complement setting
  - [ ] modify ctag setting
  - [ ] split vimrc setting
  - [ ] modify filetype detection
- ruby
  - [ ] automate install latest ruby and install global gems
