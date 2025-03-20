#!/bin/zsh

export PATH=/opt/homebrew/bin:$PATH

source ~/.config/zsh/.zshrc

number=$(ps aux | grep -v grep | grep -c tmux)

if pgrep -x tmux >/dev/null; then
  tmux-session save
else
  if [[ -s ~/.tmux-session ]]; then  # Check if the file exists and is not empty
    echo "Restoring";
    tmux-session restore
  fi
fi
