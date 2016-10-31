#!/bin/bash

if [ "$#" == 0 ] || [ "$1" == "BASH" ]; then
  echo "Initialize the bashrc"
  if [ -f $HOME/.bashrc  ]; then
    mv $HOME/.bashrc $HOME/.bashrc_bak
  fi
  if [ -f $HOME/.bash_aliases  ]; then
    mv $HOME/.bash_aliases $HOME/.bashrc_bak
  fi
  ln -s "$HOME/me212bashrc/.bashrc" "$HOME/.bashrc"
  ln -s "$HOME/me212bashrc/.bash_aliases" "$HOME/.bash_aliases"
  cp -r $HOME/me212bashrc/.config $HOME/.config
  cp -r $HOME/me212bashrc/.local $HOME/.local
fi
