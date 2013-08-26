## Environment variable configuration
#
# Boxen
#
source /opt/boxen/env.sh

# LANG
#
export LANG=ja_JP.UTF-8

## antigen
#
source ~/dotfiles/.zshrc.antigen

## Default shell configuration
#
# set prompt
#
source ~/dotfiles/.zshrc.prompt

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

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                               /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                                                            /usr/local/git/bin
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' group-name ''

# zsh-completions
fpath=(~/.zsh-completions $fpath)

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
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

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

## Action Script
#
export PATH=$PATH:/Applications/flex_sdk_4.6/bin

# ## AWS
# export JAVA_HOME="$(/usr/libexec/java_home)"
# export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
# export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
# export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
# export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
# export EC2_URL="http://ec2.us-west-1.amazonaws.com"

