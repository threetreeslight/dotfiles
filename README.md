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

Application Settings
--------------------

Keyboard

Trackpad

Finder

Key           | Attr
---           | ---
search target | in this folder

iPhoto

Key    | Attr
---    | ---
assign | none

Xcode

- install <http://alcatraz.io/>
  - XVim
  - DerivedData Exterminator
  - VVDDocumentor-Xcode
  - XAlign
  - XToDo

iterm2 preference

Key                                             | Attr
---                                             | ---
Colors                                          | Solarized Dark
Regular font                                    | Source Code Pro for powerline 14px
Text Rendering: draw blod text in blod font     | false
Text Rendering: draw bold text in bright colors | false

VirtualBox

- download from <http://www.modern.ie>
  - ie9 win7
- NAT
- Bridge network

Skype

Key             | Attr
---             | ---
privacy setting | no histroy

## tmux

ctrl + b + ] : scroll mode

copy mode

```
ctrl + b + [ : change mode to copy
Space        : start
Enter        : end
```

## tig

- <shift>+b : browse commit on github

## Vim Frequency Usage

When you want Insert Mode Paste, cancel auto Indent

```
:set paste
:set nopaste
```

History

```
q:
q\
q?
```

Tab

```
tc : create new tab
tx : close current tab
tn : move to next tab
tp : move to previous tab
```

Unite

* `<C-U><C-U>` : buffer file
* `<C-U><C-R>` : file
* `<C-U><C-D>` : dir
* `<C-U><C-F>` : exploer
* `<C-]>`      : ctags jump
* `<C-t>`      : jump history


git

* `<Space>gd`: git diff
* `<Space>gs`: git status
* `<C-C>`:     git commit
* `<Space>gb`: git blame
* `:Gbrowse` : Open github with target line

complement

* `tab`

sunippet

html

* <http://emmet.io/>

ruby

* `,r` : RuboCop

rails

* `<C-H><C-H>` : show controllers list
* `<C-H><C-V>` : show views list
* `<C-H><C-M>` : show models list
* `<C-H>j` : show javascripts list
* `<C-H>s` : show stylesheets list
* `<C-H>c` : show config list
* `<C-H>d` : show db list
* `<C-H>l` : show lib list

rspec

```
,t : run current spec file
,s : run nearest spec
,l : run last spec
,a : run all spec
```

other usage

* `<C-J>` : escape insert mode
* `<Esc><Esc>` : escape highlight
* `<C-t>` : trim white space
* `:Codic <args>` saerch variable words
* `<C-c>` : yank clipbord (mac osx only)
* `<C-P>` : Yank Ring
* `cs'"` : srround `'` to `"`
* `ds'` : delete srround `'`
* `csw'` : srround `'`
* `:ag` : grep
* `:FixWhitespace` : Trim white space


## zsh frequency Usage

```bash
# Kill process with percol
$ ppkill

# Get PID with percol
$ ppgrep

# Git checkout
$ git-use

# Git checkout ( list include remote repo branches)
$ git-all-use
```

* `ctrl + r` : search history with percol
* `ctrl + u` : Reset Command
* `cd -` : back to old current directory
* `cd -<TAB>` : select back directory on histroy

