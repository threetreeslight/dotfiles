#
# Color definition
#
typeset -g DEFAULT=$'%{^[[m%}'$
typeset -g RED=$'%{^[[1;31m%}'$
typeset -g GREEN=$'%{^[[1;32m%}'$
typeset -g YELLOW=$'%{^[[1;33m%}'$
typeset -g BLUE=$'%{^[[1;34m%}'$
typeset -g PURPLE=$'%{^[[1;35m%}'$
typeset -g LIGHT_BLUE=$'%{^[[1;36m%}'$
typeset -g WHITE=$'%{^[[1;37m%}'$

#
# Helpers
#
zsh_source_if_exists() {
  local file=$1
  [[ -r $file ]] && source $file
}

zsh_source_if_command() {
  local cmd=$1
  local file=$2
  command -v $cmd >/dev/null 2>&1 && zsh_source_if_exists $file
}

#
# Default shell configuration
#
# LANG
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# set prompt
zsh_source_if_exists $HOME/.zsh/zshrc.prompt

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
if command -v brew >/dev/null 2>&1; then
  fpath=($(brew --prefix)/share/zsh-completions $fpath)
fi

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
    zsh_source_if_exists $HOME/.zsh/zshrc.mac
    zsh_source_if_exists $HOME/.zsh/zshrc.brew
    ;;
  linux*)
    zsh_source_if_exists $HOME/.zsh/zshrc.linux
  ;;
esac
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload colors; colors

# develop
zsh_source_if_exists $HOME/.zsh/zshrc.alias
zsh_source_if_exists $HOME/.zsh/zshrc.editor
[ -f $HOME/.fzf.zsh ] && zsh_source_if_exists $HOME/.zsh/zshrc.fzf
zsh_source_if_exists $HOME/.zsh/zshrc.git
zsh_source_if_exists $HOME/.zsh/zshrc.go
zsh_source_if_command peco $HOME/.zsh/zshrc.peco
zsh_source_if_command tmux $HOME/.zsh/zshrc.tmux
zsh_source_if_exists $HOME/.config/op/plugins.sh
