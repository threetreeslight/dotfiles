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

# set prompt
source $HOME/.zsh/zshrc.prompt

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
    source $HOME/.zsh/zshrc.mac
    source $HOME/.zsh/zshrc.brew
    ;;
  linux*)
    source $HOME/.zsh/zshrc.linux
  ;;
esac
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload colors; colors

# develop
source ~/.zsh/zshrc.alias
source ~/.zsh/zshrc.direnv
source ~/.zsh/zshrc.editor
[ -f ~/.fzf.zsh ] && source ~/.zsh/zshrc.fzf
source ~/.zsh/zshrc.git
source ~/.zsh/zshrc.go
source ~/.zsh/zshrc.google
source ~/.zsh/zshrc.hubot
source ~/.zsh/zshrc.k8s
source ~/.zsh/zshrc.peco
source ~/.zsh/zshrc.rbenv
source ~/.zsh/zshrc.tmux
# source ~/.zsh.env
