dotfiles
========

ae06710's dotfiles setting

require
-------

* boxen
* rbenv (option)
* nodenv (option)
* phpenv (option)
* phantomenv (option)
* mysql (option)
* redis (option)

libraries

* z
* percol
* j
* resty
* mergepbx

Getting Started
---------------

Clone git submodules

```bash
$ ghq get ae06710/dotfiles
$ git submodule init
$ git submodule update
```

Symlink any dot files to own home directory

```bash
$ ./install
```

Install local settings
----------------------

require

* Boxen installed
* Dropbox contents loaded

Installing

```bash
$ ./install_local
```

vagrant

```
# vagrant
#
# http://www.vagrantbox.es/
#
# under both was setting by boxen
# but when there are some reason (network is slow), cut pupput on vagrant centos and ubuntu. and install by manual.
#
$ vagrant box add centos64 ...
$ vagrant box add ubuntu1210 ...)
```

Mysql setting

```bash
$ unset TMPDIR
# $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
$ mysql.server start
$ mysql -u root
> show databases;
> set password for root@localhost=password('root');
> exit
$ mysql -u root -p
```

Usage
-----

* AWS setting file located (`$HOME/Dropbox/dev/.ec2`) in Dropbox


Application Settings
--------------------

```
## Priference
#
iPhoto : preference assign -> none
Finder : preference search target -> in this folder
```

iterm2 preference

Key                                             | Attr
---                                             | ---
Colors                                          | Solarized Dark
Regular font                                    | Source Code Pro for powerline 14px
Text Rendering: draw blod text in blod font     | false
Text Rendering: draw bold text in bright colors | false

VirtualBox

- download from <http://www.modern.ie>
  - ie8 win7 or winXP
  - ie9 win7
- NAT
- Bridge network

Skype

Key             | Attr
---             | ---
privacy setting | no histroy

```
## sublime text 2
#
# install package manager
#
https://sublime.wbond.net/

## composer global install
#
# we cant install via boxen
# because mac default php has not php.ini
#
$ sudo mkdir -p /usr/local/bin
$ sudo curl -sS https://getcomposer.org/installer | sudo php
$ sudo chmod a+x composer.phar
```

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

VimShell

```
:VimShell : open shell window
Ctrl + l  : open vimshell history
```

Unite

* `<C-U><C-U>` : buffer file
* `<C-U><C-R>` : file
* `<C-U><C-D>` : dir
* `<C-U><C-F>` : exploer

git

* `<Space>gb`: git blame
* `<Space>gd`: git diff
* `<Space>gs`: git status
* `<C-C>`:     git commit
* `<Space>gb`: git blame

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

## Reference

- [脱初心者を目指すなら知っておきたい便利なVimコマンド25選](http://qiita.com/jnchito/items/57ffda5712636a9a1e62)
- [vimでキーマッピングする際に考えたほうがいいこと](http://deris.hatenablog.jp/entry/2013/05/02/192415)


