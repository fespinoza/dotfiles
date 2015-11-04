#!/bin/sh

ln -s ~/Dropbox \(Personal\)/Home/Dotfiles Dotfiles
ln -s ~/Dropbox \(Personal\)/Home/Neovim Neovim
ln -s Neovim .nvim
ln -s Neovim/nvimrc .nvimrc
ln -s Dotfiles/rcrc .rcrc
rcup
