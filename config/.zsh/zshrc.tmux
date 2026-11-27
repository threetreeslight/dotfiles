# Ctrl-T: switch tmux session via fzf (overrides fzf's file widget)
ptmux_switch_session() {
  local session
  session=$(tmux list-sessions -F '#S' 2>/dev/null | fzf --height 40% --reverse)
  [[ -n $session ]] && tmux switch-client -t "$session"
  zle reset-prompt
}

if command -v fzf >/dev/null 2>&1; then
  zle -N ptmux_switch_session
  bindkey '^T' ptmux_switch_session
fi
