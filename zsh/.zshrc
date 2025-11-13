# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
zstyle ':omz:plugins:nvm' lazy yes
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
#plugins=(
#	git
#	)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"
export PATH="~/repositories/vws2-credentials-loader:$PATH"
alias cdmast="cd ~/repositories/masters-2021-paper/"
alias ct="rm *.stdout; rm *.stderr"
#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#iterm2_print_user_vars() {
   #extend this to add whatever
  # you want to have printed out in the status bar
#  iterm2_set_user_var nodeVersion $(node -v)
  #iterm2_set_user_var pwd $(pwd)
#}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias loadnpm20='export PATH="$PATH:~/.nvm/versions/node/v20.2.0/bin"'
alias loadnpm16='export PATH="$PATH:~/.nvm/versions/node/v16.14.2/bin"'
alias npm='unalias npm && loadnpm20 && npm '

# PATH variables
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH=`gem environment gemdir`/bin:$PATH

# LS
alias ll='ls -l'

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh
fpath=($ZDOTDIR/prompt $fpath)
autoload -Uz prompt.zsh; prompt.zsh

bindkey -v
bindkey '^R' history-incremental-search-backward


setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


export KEYTIMEOUT=1

source $ZDOTDIR/cursor_mode.zsh
source $ZDOTDIR/git_aliases.zsh

# Brew help
alias br='brew update && brew upgrade && brew doctor && brew cleanup'
# Python stuff
alias pv='source venv/bin/activate'
alias createVenv='python3 -m venv venv'


# Convenience aliases for rc files
alias reload='source ~/.config/zsh/.zshrc'
alias editconfig='nvim ~/.config/'
alias editrc='nvim ~/.config/zsh/.zshrc'
alias editvimrc='nvim ~/.vimrc'
alias nvimconfig='nvim ~/.config/nvim'
alias sync='cd ~/.config && gpra && cd ~/vimwiki && gpra && cd ~'

# Masters aliases
alias chpc='pass show -c lengau.chpc.ac.za; ssh jrussell@lengau.chpc.ac.za'
alias masters='nvim  ~/repositories/masters-2021-paper/'
alias masters2='source ~/repositories/masters-2021-paper/runenv/bin/activate;jupyter-lab ~/repositories/masters-2021-paper/'
alias mastersActivate='source ~/repositories/masters-2021-paper/runenv/bin/activate'

# More aliases
function nr {
  npm run $1;
}
alias ta='tmux attach-session -t'
alias tn='tmux new-session -t'

alias play='sudo mv ~/personal/important /Applications/Minecraft.app'
alias unplay='sudo mv /Applications/Minecraft.app/ ~/personal/important'

alias saveWiki='cd ~/vimwiki; gvwcp; 1'
alias floating='cd ~/vimwiki; echo "Gzzi" | nvim "For Later.wiki" -s -'

# Open the most recent file from downloads in nvim
alias oD='cd ~/Downloads/;ls -t | head -1 | xargs -o nvim'

# Paths
function jenv() {
  unset -f jenv

  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(command jenv init -)"
  jenv enable-plugin export > /dev/null
  jenv "$@"
}

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
function cdr() {
    if [[ $1 == "-l" ]]
    then
        ls ~/repositories/;
        return;
    fi
    cd ~/repositories/$1/ || return;
}
function cdl() {
	cd $1;
	ls;
}
function chpcCopy() {
  pass show -c lengau.chpc.ac.za;
  scp jrussell@scp.chpc.ac.za:/mnt/lustre/users/jrussell/masters-2021-paper/$1 .;
}
export SPARK_HOME=~/spark
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"  # commented out by conda initialize
export CC=/opt/homebrew/opt/llvm/bin/clang
export CXX=/opt/homebrew/opt/llvm/bin/clang++
export LDFLAGS="-L/opt/homebrew/opt/libomp/lib -L/opt/homebrew/opt/llvm/lib -L $(brew --prefix graphviz)/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libomp/include -I/opt/homebrew/opt/llvm/include -I $(brew --prefix graphviz)/include"

test -e ~/.config/zsh/.iterm2_shell_integration.zsh && source ~/.config/zsh/.iterm2_shell_integration.zsh || true
test -e $HOME/.config/zsh/.zsh_private && source $HOME/.config/zsh/.zsh_private || true

export PATH="$HOME/sam/aws-sam-cli:$PATH"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="$HOME/.config/bin:$PATH"
export PATH="$HOME/.config/local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH=~/.cache/rebar3/bin:$PATH


export ERL_AFLAGS="-kernel shell_history enabled"

if type conda > /dev/null; then
  conda deactivate
fi

export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig:/opt/homebrew/opt/openblas/lib/pkgconfig"

setopt HIST_IGNORE_SPACE

# Replace <IRACE_HOME> with the irace installation path
export IRACE_HOME=/opt/homebrew/lib/R/4.4/site-library/irace
export PATH=${IRACE_HOME}/bin/:$PATH
# Tell R where to find R_LIBS_USER
# Use the following line only if local installation was forced

export R_LIBS=${R_LIBS_USER}:${R_LIBS}

# zprof

# Created by `pipx` on 2025-07-23 08:21:51
export PATH="$PATH:~/.local/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/.google/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/.google/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/.google/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/.google/google-cloud-sdk/completion.zsh.inc'; fi
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
