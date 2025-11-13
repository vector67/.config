#!/bin/sh

ln ~/.config/vim/.vimrc ~/.config/.vimrc
ln ~/.config/zsh/.zshenv_in_root ~/.zshenv
curl -fLo ~/.vim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +slient +VimEnter +PlugInstall +qall

(crontab -l 2>/dev/null; cat ~/.config/cron/autosave.cron) | crontab -

touch $HOME/.config/zsh/.zsh_private
