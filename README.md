dotfiles
========

ae06710's dotfiles setting

Install global settings
----------------------

clone git submodules

```bash
$ git submodule init
$ git submodule update
```

Link any dot files to home

```bash
$ ./install.sh
```

NeoBundleInstall

```bash
$ vim
```

mysql setting

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

other task

1. add rsa keys to github.
2. after add to keys by impoted github


Install local settings
----------------------

require

* Boxen installed
* Dropbox contents loaded

installing

```bash
$ ./install_local.sh
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

other task

1. add rsa keys to github.
2. after add to keys by impoted github

Usage
-----

* AWS setting file located (`$HOME/Dropbox/dev/.ec2`) in Dropbox


Local Application Setting
-------------------------

```
## Priference
#
iPhoto : preference assign -> none
Finder : preference search target -> in this folder

## iterm2 preference
#
# download sole solarized
Change Therme Solarize
font: SourceCodePro 14px
draw blod text in blod font : false
draw bold text in bright colors : false
enable clipboard

## sublime text 2
#
# install package manager
#
https://sublime.wbond.net/

## virtualBox
#
# download from http://www.modern.ie
# access: 10.0.2.2   localhost
#
ie8 win7 or winXP
ie9 win7

# setting
NAT
Bridge network


## chrome
#
access to chrome://flags
Enable Developer Tools experimentsをenable

## skype
#
privacy setting : no histroy


## composer global install
#
# we cant install via boxen
# because mac default php has not php.ini
#
$ sudo mkdir -p /usr/local/bin
$ sudo curl -sS https://getcomposer.org/installer | sudo php
$ sudo chmod a+x composer.phar

```

