# Async tmux window title: folder (worktree) - TICKET - cmd | ...
# Runs in a forked subprocess on each precmd to avoid blocking the prompt.

_tmux_window_title_update() {
  [[ -z "$TMUX" ]] && return

  (
    # Git info
    local folder=""
    local worktree_label=""
    local ticket=""
    if git rev-parse --git-dir &>/dev/null; then
      local git_dir=$(git rev-parse --git-dir 2>/dev/null)
      local common_dir=$(git rev-parse --git-common-dir 2>/dev/null)

      [[ "$git_dir" != "$common_dir" ]] && worktree_label=" (worktree)"
      # common-dir is absolute for worktrees, relative (.git) otherwise
      local common_abs="${common_dir:A}"
      folder="${common_abs:h:t}"

      # Extract ticket number from branch name (e.g., AR-1252)
      local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
      if [[ "$branch" =~ ([A-Za-z]+-[0-9]+) ]]; then
        ticket="${(U)match[1]}"
      fi
    else
      # Not a git repo — use current directory name
      folder="${PWD##*/}"
      [[ "$PWD" == "$HOME" ]] && folder="~"
    fi

    # Truncate long folder names
    (( ${#folder} > 20 )) && folder="${folder:0:17}..."

    # Command: use passed-in name if available, otherwise ask tmux
    local cmd="${1:-$(tmux display-message -p '#{pane_current_command}')}"

    # Split indicator
    local panes=$(tmux display-message -p '#{window_panes}')
    local split=""
    (( panes > 1 )) && split=" | ..."

    # Assemble: folder [TICKET] (worktree) - cmd | ...
    local title="${folder}"
    [[ -n "$ticket" ]] && title="${title} [${ticket}]"
    title="${title}${worktree_label} - ${cmd}${split}"

    tmux rename-window "$title"
  ) &!
}

_tmux_window_title_preexec() {
  [[ -z "$TMUX" ]] && return
  # Extract the first word (command name) from the command line
  local cmd="${1%% *}"
  _tmux_window_title_update "$cmd"
}

autoload -U add-zsh-hook
add-zsh-hook precmd _tmux_window_title_update
add-zsh-hook preexec _tmux_window_title_preexec
