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

function gvwcp() {
  if read -q "choice?Press Y/y to continue with commit and push with date: "; then
    git add .;
    git commit -m "`date +%F`";
    gp;
  else
    echo "'$choice' not 'Y' or 'y'. Exiting..."
  fi
}
