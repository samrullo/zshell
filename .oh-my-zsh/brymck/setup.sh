#!/bin/sh
echo "\033[0;34mLooking for an existing zsh config...\033[0m"
if [ -f $HOME/.zshrc ] || [ -h $HOME/.zshrc ]
then
  echo "\033[0;33mFound $HOME/.zshrc.\033[0m \033[0;32]Backing up to $HOME/.zshrc.pre-oh-my-zsh\033[0m";
  cp $HOME/.zshrc $HOME/.zshrc.pre-oh-my-zsh;
  rm $HOME/.zshrc;
fi

echo "\033[0;34mUsing the Oh My Zsh template file and adding it to $HOME/.zshrc\033[0m"
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc

echo "\033[0;34mCopying your current PATH and adding it to the end of $HOME/.zshrc for you.\033[0m"
echo "export PATH=$PATH" >> $HOME/.zshrc

echo "\033[0;32m"'         __                                     __   '"\033[0m"
echo "\033[0;32m"'  ____  / /_     ____ ___  __  __   ____  _____/ /_  '"\033[0m"
echo "\033[0;32m"' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '"\033[0m"
echo "\033[0;32m"'/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '"\033[0m"
echo "\033[0;32m"'\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '"\033[0m"
echo "\033[0;32m"'                        /____/                       '"\033[0m"

echo "\n\n \033[0;32m....is now installed.\033[0m"
/usr/bin/env zsh
