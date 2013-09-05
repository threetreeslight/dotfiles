#!/bin/bash

#
# this script use for OS X only
#

## change readline for use japanese
#
CURRENT_READLINE=`otool -L $(find /opt/boxen/rbenv -name readline.bundle) | grep /opt/boxen/homebrew/Cellar/readline`

if [ ${#CURRENT_READLINE} > 0 ]; then
  echo "[notice] already updated readline.bundle"
else
  find /opt/boxen/rbenv -name readline.bundle -exec install_name_tool -change /usr/lib/libedit.3.dylib `find /opt/boxen -name libreadline.dylib` {} \;
  echo "update readline.bundle"
fi

## fotns
#
if [ ! -d $HOME/Dropbox/dev/fonts ]; then
  echo "[error] Fonts directory is not exist"
elif [ -f $HOME/Library/Fonts/Source\ Code\ Pro\ Regular\ for\ Powerline.otf ]; then
  echo "[notice] already copied fonts"
else
  echo "Copying fonts to local"
  cp $HOME/Dropbox/dev/fonts/* $HOME/Library/Fonts/
fi


## add git config local to $HOME
#
#
#
if [ ! -f $HOME/Dropbox/dev/.gitconfig.local ]; then
  echo "[error] .gitconfig.local is not exist in $HOME/Dropbox/dev"
elif [ -f $HOME/.gitconfig.local ]; then
  echo "[notice] already copeid .gitconfig.local"
else
  ln -s $HOME/Dropbox/dev/.gitconfig.local $HOME/
  echo "copying .gitconfig.local to local"
fi


## rsa keys
#
if [ -e $HOME/.ssh/id_rsa ]; then
  echo "[notice] already generated rsa key"
else
  cd ~/.ssh/
  ssh-keygen -t rsa
  echo "generating rsa key"
fi

## heroku setting
#
# add to pubkey
#
RSA_PUB_ARRY=(`echo $(cat ${HOME}/.ssh/id_rsa.pub)`)
HOST_PC_NAME=${RSA_PUB_ARRY[2]}
RSA_IN_HEROKU=`heroku keys | grep ${HOST_PC_NAME}`
if [ ${#RSA_IN_HEROKU} > 0 ]; then
  echo "[notice] already added this host rsa key to heroku"
else
  heroku keys:add
  echo "adding rsa key to heroku"
fi


## mysql setting
#
# $ unset TMPDIR
# $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
#
MYSQL_SERVER_STATUS=`mysql.server status | grep running`
if [ ${#MYSQL_SERVER_STATUS} > 0 ]; then
  echo "[notice] already started mysql server"
else
  mysql.server start
  echo "starting mysql"
fi

# mysql:auto load
# ln -sfv ${BOXEN_HOME}/homebrew/opt/mysql/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

## pow
#
# after registration application by powder
# $ cd ~/.pow
# $ ln -s ${rails application directory}
#
if [ -d $POW_HOST_ROOT ]; then
  echo "[notice] already pow initialized"
else
  eval $(pow --print-config)
  mkdir -p "`echo $POW_HOST_ROOT`"
  ln -s "`echo $POW_HOST_ROOT`" ~/.pow
  echo "initializing pow"
fi

## vagrant
#
VAGRANT_SAHARA=`vagrant plugin list | grep sahara`
if [ ${#VAGRANT_SAHARA} > 0 ]; then
  echo "[notice] already added sahara to vagrant plugin"
else
  vagrant plugin install sahara
  echo "adding vagrant plugin sahara"
fi

