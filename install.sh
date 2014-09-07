#!/bin/bash

DOT_FILES=(.vimrc .tmux.conf .zshrc .zshenv .gitconfig .gitignore_global .tigrc)
DOT_DIRECTORIES=(vim bundle)

for file in ${DOT_FILES[@]}
do
  if [ -e $HOME/$file ]; then
    echo "$file file is existed."
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
  fi
done

for directory in ${DOT_DIRECTORIES[@]}
do
  if [ -d $HOME/.$directory ]; then
    echo ".$directory directory is existed."
  else
    ln -s $HOME/dotfiles/$directory $HOME/.$directory
  fi
done


# install via antigen and neobundle
if [ -a $HOME/.vimrc ]; then
  source ~/.zshrc
  vim ~/.vimrc
fi

# # antigen plugin install
# if [ -d $HOME/zsh/antigen ]; then
#   antigen update
# fi
