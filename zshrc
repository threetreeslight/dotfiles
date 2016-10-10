#
# zshrc
#

# Boxen
source /opt/boxen/env.sh

#
# Color definition
#
local DEFAULT=$'%{^[[m%}'$
local RED=$'%{^[[1;31m%}'$
local GREEN=$'%{^[[1;32m%}'$
local YELLOW=$'%{^[[1;33m%}'$
local BLUE=$'%{^[[1;34m%}'$
local PURPLE=$'%{^[[1;35m%}'$
local LIGHT_BLUE=$'%{^[[1;36m%}'$
local WHITE=$'%{^[[1;37m%}'$

#
# Default shell configuration
#
# LANG
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# antigen
source $HOME/dotfiles/zsh/zshrc.antigen

# set prompt
source $HOME/dotfiles/zsh/zshrc.prompt

setopt nobeep     # no beep sound
setopt auto_cd    # auto change directory
setopt auto_pushd # auto directory pushd that you can get dirs list by cd -[tab]
setopt correct    # command correct edition before each completion attempt
bindkey -v        # vim keybind

setopt auto_param_slash     # add autometicaly "/", when comple directory name
setopt mark_dirs            # add autometicaly "/", deploying dir
setopt list_types           # add file type mark like `ls -F`
setopt interactive_comments # In command line cognition "#" as comment

#
# Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history    # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#
# Completion
#

# zsh-completions( have to write compinit before )
fpath=(`brew --prefix`/share/zsh-completions $fpath)

autoload -U compinit && compinit
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                               /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                               /usr/local/git/bin

# hilight selected option
zstyle ':completion:*:default' menu select=2

# grouping options
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

# coloring
case "${OSTYPE}" in
  freebsd*|darwin*)
    if [ -f $HOME/dotfiles/zsh/zshrc.mac ]; then
      source $HOME/dotfiles/zsh/zshrc.mac
    fi
    ;;
  linux*)
    if [ -f $HOME/dotfiles/zsh/zshrc.linux ]; then
      source $HOME/dotfiles/zsh/zshrc.linux
    fi
  ;;
esac
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload colors; colors

# tmux
export EDITOR='vim'
# source ~/.bin/tmuxinator.zsh

# git
export GIT_EDITOR="/usr/bin/vim"
eval "$(hub alias -s)"

# z
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

# redis for hubot
export REDISTOGO_URL=$BOXEN_REDIS_URL

# Action Script
export PATH=$PATH:/Applications/flex_sdk_4.6/bin

#
# develop
#
eval "$(direnv hook zsh)"
source ~/dotfiles/zsh/zshrc.alias
source ~/dotfiles/zsh/zshrc.language
source ~/dotfiles/zsh/zshrc.percol
source ~/.zsh.env


export NVM_DIR="/Users/ae06710/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
source $HOME/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
source $HOME/google-cloud-sdk/completion.zsh.inc

# docker
export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_CERT_PATH=/Users/ae06710/.docker/machine/machines/dinghy
export DOCKER_TLS_VERIFY=1
export DOCKER_MACHINE_NAME=dinghy
