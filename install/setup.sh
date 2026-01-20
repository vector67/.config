#!/bin/zsh
#
# From this guide we extracted what seemed the most usefull stuff. 
# If you feel that this one ressonates with you, please uncomment them.
#
## take screenshots as jpg (usually smaller size) and not png
# defaults write com.apple.screencapture type jpg
#
## do not open previous previewed files (e.g. PDFs) when opening a new one
defaults write com.apple.Preview ApplePersistenceIgnoreState YES
#
# Here is the complete reference:
#       https://www.robinwieruch.de/mac-setup-web-development/
#
## Finder options
# show Library folder
chflags nohidden ~/Library
# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# show path bar
defaults write com.apple.finder ShowPathbar -bool true
# show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# key repeat rate and key repeat delay
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Don't rearrange spaces based on use
defaults write com.apple.dock workspaces-auto-swoosh -bool NO


killall Finder;

## ⚠️ ⚠️ NOTE! ⚠️ ⚠️ 
## x-code needs to be installed BEFORE trying to get brew (it needs the curlllll)
printf "\n"
printf "🧑🏻‍💻👩🏻‍💻 Setup x-code \n"
xcode-select --install

if ! type "brew" > /dev/null; then
	printf "\n"
	printf "🍻🍺 Install brew \n"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	printf "\n"
	printf "Add homebrew to the path"
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
	    eval "$(/opt/homebrew/bin/brew shellenv)" 

fi
printf "\n"

printf "⚙️ Installing (most used...) apps... \n" 
brew install --cask \
  google-chrome  \
  rectangle \


printf "\n" 
printf "🤓 💻 Installing developer stuff... \n" 

brew install --cask \
  iterm2 \
  docker \
  postman \
  spotify \

if ! type "pass" > /dev/null; then
	brew install \
	  wget \
	  git \
	  openssl \
	  pass \
    tmux \
    npm \
    neovim \
    ripgrep \
    pandoc \
    basictex \
    gh
fi


## OH MY ZSH
(RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
omz update
# shellcheck source=/dev/null
. "${HOME}/.zshrc"

brew install 'zsh-autosuggestions'
echo 'source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh'  >> ~/.zshrc

brew install 'zsh-syntax-highlighting'
echo 'source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'  >> ~/.zshrc

brew install 'zsh-history-substring-search'
echo 'source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh'  >> ~/.zshrc

brew install starship
# shellcheck disable=SC2016
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
brew install --cask font-hack-nerd-font
# shellcheck source=/dev/null
. "${HOME}/.zshrc"


## GIT
printf "\n" 
printf "🐙 Setting up Git config..."
printf "❓ Please enter your github name:"
read -r name
git config --global user.name "$name"
printf "❓ Please enter your github email:"
read -r email
git config --global user.email "$email"

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global init.defaultBranch main
cd ~
git clone git@github.com:vector67/vimwiki.git


## SSH
# in case the folder is not there yet
printf "\n"
printf "🔐 Setting up SSH keys..."

mkdir ~/.ssh
cd ~/.ssh || exit
ssh-keygen -t ed25519 -C "$email"

printf "❓🤨 In a new terminal, confirm whether passphrase is OK with following command: \n"
printf "$ ssh-keygen -y -f ~/.ssh/id_ed25519  \n"
printf " ⏎ Press enter to continue then..."
read -r

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

printf "🔑 Creating the SSH configuration file if it doesn't exist yet:"
touch ~/.ssh/config
echo "
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
" > ~/.ssh/config

# Adding your SSH key to your GitHub account
# https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
printf "☝🏻 Now, you need to do this: \n"
printf "run 'pbcopy < ~/.ssh/id_ed25519.pub' and paste that into GitHub, when you are ready press enter to continue!"
read -r


## note, we don't have this on our scripts atm
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
 
gh auth login
gh ssh-key add ~/.ssh/id_ed25519.pub -t $email

## NVM
echo "📦 Installing NVM..." 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.zshrc
# shellcheck source=/dev/null
. "${HOME}/.zshrc"
nvm install --lts

printf "❓🤨 Check if the installation was successful and whether the node package manager (npm) got installed along the way"
node -v && npm -v
npm install -g npm@latest
npm set init-author-name "$name"
npm set init-author-email "$email"
npm config set ignore-scripts true


printf " 🎆  🎊  🥳  🎉  🎇"
printf " All done. Enjoy." 
printf "\n"

git clone git@github.com:vector67/.config.git
chmod +x .config/install/install.sh
zsh .config/install/install.sh

brew install pyenv
brew install jenv

mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh

brew install llvm
brew install yarn

# Neovim dependencies
brew install debugpy
brew install tree-sitter-cli

# cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make && cd -

# brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
brew install ripgrep
brew tap homebrew/cask-fonts
brew install --cask alt-tab

# Install the latex stuff for the eisvogel template to work out of the box
eval "$(/usr/libexec/path_helper)"
sudo tlmgr update --self
sudo tlmgr install adjustbox babel-german background bidi collectbox csquotes everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor soul sourcecodepro sourcesanspro titling ucharcat ulem unicode-math upquote xecjk xurl zref
