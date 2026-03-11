#!/bin/sh
# Detect macOS appearance and apply matching Solarized theme to tmux

appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

if [ "$appearance" = "Dark" ]; then
    bg="#002b36"
    bg_hl="#073642"
    fg="#839496"
    fg_dim="#586e75"
    accent="#268bd2"
else
    bg="#fdf6e3"
    bg_hl="#eee8d5"
    fg="#657b83"
    fg_dim="#93a1a1"
    accent="#268bd2"
fi

tmux set -g status-style "bg=$bg,fg=$fg"
tmux set -g window-status-style "bg=$bg,fg=$fg_dim"
tmux set -g window-status-current-style "bg=$bg_hl,fg=$accent,bold"
tmux set -g pane-border-style "fg=$bg_hl"
tmux set -g pane-active-border-style "fg=$accent"
tmux set -g message-style "bg=$bg_hl,fg=$fg"
tmux set -g mode-style "bg=$bg_hl,fg=$fg"
tmux set -g status-left-style "bg=$bg,fg=$fg_dim"
tmux set -g status-right-style "bg=$bg,fg=$fg_dim"
