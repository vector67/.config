#!/bin/sh

ln ~/.config/vim/.vimrc ~/.config/.vimrc
ln ~/.config/zsh/.zshenv_in_root ~/.zshenv
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +slient +VimEnter +PlugInstall +qall

