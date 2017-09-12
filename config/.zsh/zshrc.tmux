#!/bin/bash

export EDITOR='vim'
# https://github.com/jonas/tig/issues/292
# https://github.com/ddollar/tmux/blob/master/FAQ
[ -n "$TMUX" ] && export TERM=screen-256color

# switch session
function ptmux_switch_session() {
  # listing session name and switch client
  tmux ls | cut -d: -f1 | peco | xargs tmux switch-client -t
  # refresh
  zle -R -c
}

function exists { which $1 &> /dev/null }

if exists peco; then
  # register shell function to zsh widget
  zle -N ptmux_switch_session
  bindkey '^T' ptmux_switch_session
fi

