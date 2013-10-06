## Environment variable configuration
#
# Boxen
#
source /opt/boxen/env.sh

## color definition
#
local DEFAULT=$'%{^[[m%}'$
local RED=$'%{^[[1;31m%}'$
local GREEN=$'%{^[[1;32m%}'$
local YELLOW=$'%{^[[1;33m%}'$
local BLUE=$'%{^[[1;34m%}'$
local PURPLE=$'%{^[[1;35m%}'$
local LIGHT_BLUE=$'%{^[[1;36m%}'$
local WHITE=$'%{^[[1;37m%}'$

## LANG
#
export LANG=ja_JP.UTF-8

## antigen
#
source $HOME/dotfiles/.zshrc.antigen

## Default shell configuration
#
# set prompt
#
source $HOME/dotfiles/.zshrc.prompt

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# Keybind configuration
bindkey -v


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


## Completion
#
# zsh-completions( have to write compinit before )
fpath=($HOME/dotfiles/.zsh/zsh-completions/src $fpath)

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                               /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                               /usr/local/git/bin

# hilight selected option
zstyle ':completion:*:default' menu select=2

# grouping options
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

autoload -U compinit; compinit

# coloring
case "${OSTYPE}" in
  freebsd*|darwin*)
    if [ -f ~/dotfiles/.zshrc.mac ]; then
      source ~/dotfiles/.zshrc.mac
    fi
    ;;
  linux*)
    if [ -f ~/dotfiles/.zshrc.linux ]; then
      source ~/dotfiles/.zshrc.linux
    fi
  ;;
esac
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload colors; colors

# command
setopt auto_param_slash # add autometicaly "/", when comple directory name
setopt mark_dirs # add autometicaly "/", deploying dir
setopt list_types # add file type mark like `ls -F`
setopt interactive_comments # In command line cognition "#" as comment



## other settings
#
# common alias
#
alias ll='ls -laG'
alias rm='rm -i'
alias cp="cp -i"
alias mv="mv -i"
alias du="du -h"
alias df="df -h"
alias vi='/usr/bin/vim'
alias g='git'
alias gg="git grep -H --heading --break"
alias be='bundle exec'

## git
#
export GIT_EDITOR="/usr/bin/vim"

## z
#
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

## rbenv
#
if [[ -s $BOXEN_HOME/rbenv/bin ]] ; then
  rbenv global 2.0.0-p247
  echo "ruby is "`rbenv version | sed -e 's/ .*//'`
fi

## nodenv
#
if [[ -s $BOXEN_HOME/nodenv/bin ]] ; then
  nodenv global v0.10.13
  echo "node is "`nodenv version | sed -e 's/ .*//'`
fi

## phpenv
#
if [[ -s $BOXEN_HOME/phpenv/bin ]] ; then
  echo "php is "`phpenv global 5.4.17`
fi

## phantomenv
#
if [[ -s $BOXEN_HOME/phantomenv/bin ]] ; then
  phantomenv global 1.9.1
  echo "phantomjs is "`phantomenv version | sed -e 's/ .*//'`
fi

## redis for hubot
#
export REDISTOGO_URL=$BOXEN_REDIS_URL

## Action Script
#
export PATH=$PATH:/Applications/flex_sdk_4.6/bin

## AWS
#
if [[ -s $HOME/Dropbox/dev/.ec2 ]] ; then
  export AWS_ACCESS_KEY_ID=`cat $HOME/Dropbox/dev/.ec2/ae06710_access_key_id`
  export AWS_SECRET_ACCESS_KEY=`cat $HOME/Dropbox/dev/.ec2/ae06710_secret_access_key`
fi

# export JAVA_HOME="$(/usr/libexec/java_home)"
# export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
# export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
# export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
# export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
# export EC2_URL="http://ec2.us-west-1.amazonaws.com"

