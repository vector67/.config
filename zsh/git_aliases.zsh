alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gpra='git pull --rebase --autostash'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'
alias gmt='git mergetool'

function gvwcp() {
  if read -q "choice?Press Y/y to continue with commit and push with date: "; then
    git add .;
    git commit -m "`date +%F`";
    gp;
  else
    echo "'$choice' not 'Y' or 'y'. Exiting..."
  fi
}

function cpr() {
  pr="$1"
  remote="${2:-origin}"
  source_dir="$(pwd)"
  branch=$(gh pr view "$pr" --json headRefName -q .headRefName)
  git fetch "$remote" "$branch"
  git worktree add "../$branch" "$branch"

  # Copy key files to new worktree
  for f in .env .env.local .envrc; do
    [[ -f "$source_dir/$f" ]] && cp "$source_dir/$f" "../$branch/$f"
  done

  cd "../$branch" || return
  [[ -f .envrc ]] && direnv allow

  # Warm up just preconditions in background
  if [[ -f justfile || -f Justfile ]]; then
    just prec &>/dev/null & disown
    echo "Background: just prec warming up"
  fi

  echo "Switched to new worktree for PR #$pr: $branch"
}

function cwt() {
  local source_dir="$(pwd)"
  local current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [[ -z "$current_branch" ]]; then
    echo "Not on a branch (detached HEAD)"
    return 1
  fi

  local name="${1:-}"
  if [[ -z "$name" ]]; then
    local i=1
    while [[ -d "../${current_branch}-${i}" ]]; do
      ((i++))
    done
    name="${current_branch}-${i}"
  fi

  git worktree add -b "$name" "../$name" HEAD || return 1

  # Copy key files to new worktree
  for f in .env .env.local .envrc; do
    [[ -f "$source_dir/$f" ]] && cp "$source_dir/$f" "../$name/$f"
  done

  cd "../$name" || return
  [[ -f .envrc ]] && direnv allow

  # Warm up just preconditions in background
  if [[ -f justfile || -f Justfile ]]; then
    just prec &>/dev/null & disown
    echo "Background: just prec warming up"
  fi

  echo "Created worktree clone: $name (from $current_branch)"
}

function dpr() {
  current=$(pwd)
  main_worktree=$(git worktree list | head -1 | awk '{print $1}')

  if [[ "$current" == "$main_worktree" ]]; then
    echo "Already in main worktree, nothing to remove"
    return 1
  fi

  if [[ -n $(git status --porcelain) ]]; then
    echo "Uncommitted changes:"
    git status --short
    echo
    if read -q "choice?Force delete worktree? (Y/n): "; then
      echo
      cd "$main_worktree" || return
      git worktree remove --force "$current"
    else
      echo "\nAborting."
      return 1
    fi
  else
    cd "$main_worktree" || return
    git worktree remove "$current"
  fi
  echo "Removed worktree and returned to $main_worktree"
}
