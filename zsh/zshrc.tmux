#!/bin/bash

export EDITOR='vim'

# switch session
function ptmux_switch_session() {
  # listing session name and switch client
  tmux ls | cut -d: -f1 | peco | xargs tmux switch-client -t
  # refresh
  zle -R -c
}

if exists peco; then
  # register shell function to zsh widget
  zle -N ptmux_switch_session
  bindkey '^T' ptmux_switch_session
fi

