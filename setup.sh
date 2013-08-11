#!/bin/bash

DOT_FILES=(.vimrc .tmux.conf .zshrc .gitconfig .gitignore_global)
DOT_DIRECTORIES=(.vim .zsh-completions)

for file in ${DOT_FILES[@]}
do
  if [ -a $HOME/$file ]; then
    echo "$file file is existed."
  else
    ln -s $HOME/my/dotfiles/$file $HOME/$file
  fi
done

for directory in ${DOT_DIRECTORIES[@]}
do
  if [ -d $HOME/$directory ]; then
    echo "$directory directory is existed."
  else
    ln -s $HOME/my/dotfiles/$directory $HOME/$directory
  fi
done
