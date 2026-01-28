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
  branch=$(gh pr view "$pr" --json headRefName -q .headRefName)
  git fetch "$remote" "$branch"
  git worktree add "../$branch" "$branch"
#
  # Copy key files to new worktree
  for f in .env .env.local; do
    [[ -f "$source_dir/$f" ]] && cp "$source_dir/$f" "../$branch/$f"
  done

  cd "../$branch" || return
  echo "Switched to new worktree for PR #$pr: $branch"
}

function dpr() {
  current=$(pwd)
  main_worktree=$(git worktree list | head -1 | awk '{print $1}')

  if [[ "$current" == "$main_worktree" ]]; then
    echo "Already in main worktree, nothing to remove"
    return 1
  fi

  cd "$main_worktree" || return
  git worktree remove "$current"
  echo "Removed worktree and returned to $main_worktree"
}
