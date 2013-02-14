## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors

PROMPT="%m:%n%% "
RPROMPT="[%~]"

case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%m:%n%%%%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="%{${fg[yellow]}%}%m:%n%%%{${reset_color}%} "
  PROMPT2="%{${fg[yellow]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[yellow]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

## Keybind configuration
#
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
 

## Completion configuration
#
autoload -U compinit
compinit

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' group-name ''


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

## homebrew
#
export PATH=$PATH:/usr/local/sbin

## git
# 
export GIT_EDITOR="/usr/bin/vim"

## rvm
#
if [[ -s $HOME/.rvm/bin ]] ; then
  export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm; fi

  rvm use 1.9.3@default
fi

## nvm
#
if [[ -f $HOME/.nvm/nvm.sh ]] ; then
  [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
  nvm use 0.8.16
  export NODE_PATH=${NVM_PATH}_modules${NODE_PATH:+:}${NODE_PATH}
fi

## phpenv
#
if [ -f $HOME/.phpenv/bin/phpenv ]; then
    export PATH=$PATH:$HOME/.phpenv/bin
    eval "$(phpenv init -)"
fi

## PostgresApp
#
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"


## Heroku Toolbelt
#
export PATH="/usr/local/heroku/bin:$PATH"

## Action Script
#
export PATH=$PATH:/Applications/flex_sdk_4.6/bin

## AWS
export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
export EC2_URL="http://ec2.us-west-1.amazonaws.com"


