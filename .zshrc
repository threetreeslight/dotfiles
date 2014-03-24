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
GLOBAL_VERSION="2.0.0-p353"
if [[ -s $BOXEN_HOME/rbenv/bin ]];then
  if [ $GLOBAL_VERSION != `rbenv global` ];then
    rbenv global $GLOBAL_VERSION
  fi
  echo "ruby: " $GLOBAL_VERSION
fi

## nodenv
#
GLOBAL_VERSION="v0.10.21"
if [[ -s $BOXEN_HOME/nodenv/bin ]] ; then
  if [ $GLOBAL_VERSION != `nodenv version` ];then
    nodenv global $GLOBAL_VERSION
  fi
  echo "node: " $GLOBAL_VERSION
fi

## pyenv
#
GLOBAL_VERSION="2.7.6"
if [[ -s $BOXEN_HOME/pyenv/bin ]] ; then
  if [ $GLOBAL_VERSION != `pyenv global` ];then
    pyenv global 2.7.6
  fi
  # source $BOXEN_HOME/pyenv/shims/virtualenvwrapper.sh
  echo "python: " $GLOBAL_VERSION
fi

## phpenv
#
GLOBAL_VERSION="5.4.17"
if [[ -s $BOXEN_HOME/phpenv/bin ]] ; then
  if [ $GLOBAL_VERSION != `phpenv version | awk '{print $1}'` ];then
    phpenv global 5.4.17
  fi
  echo "php: " $GLOBAL_VERSION
fi

## phantomenv
#
GLOBAL_VERSION="1.9.1"
if [[ -s $BOXEN_HOME/phantomenv/bin ]] ; then
  if [ $GLOBAL_VERSION != `phantomenv version` ];then
    phantomenv global 1.9.1
  fi
  echo "phantomjs: " $GLOBAL_VERSION
fi

## redis for hubot
#
export REDISTOGO_URL=$BOXEN_REDIS_URL


## Action Script
#
export PATH=$PATH:/Applications/flex_sdk_4.6/bin

