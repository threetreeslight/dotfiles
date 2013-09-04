#!/bin/bash

## change readline for use japanese
find /opt/boxen/rbenv -name readline.bundle -exec install_name_tool -change /usr/lib/libedit.3.dylib `find /opt/boxen -name libreadline.dylib` {} \;

## fotns
#
cp $HOME/Dropbox/dev/fonts/* $HOME/Library/Fonts/


## add git config local to $HOME
#
#
#
ln -s $HOME/Dropbox/dev/.gitconfig.local $HOME/


## rsa keys
#
if [ -a $HOME/.ssh/id_rsa ]; then
  cd ~/.ssh/
  ssh-keygen -t rsa
fi

## heroku setting
#
# add to pubkey
#
heroku login
heroku keys:add


## mysql setting
#
unset TMPDIR
# $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
mysql.server start

# mysql:auto load
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

## pow
#
eval $(pow --print-config)
mkdir -p "`echo $POW_HOST_ROOT`"
ln -s "`echo $POW_HOST_ROOT`" ~/.pow
cd ~/.pow
# do `ln -s ` application by powder


## vagrant
#
vagrant plugin install sahara

