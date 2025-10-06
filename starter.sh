#!/bin/bash

export STARTER_DIR=$(pwd)

chmod +x $STARTER_DIR/{starter,commit}.sh
source $STARTER_DIR/starter.sh


echo "Clone alacritty-themes"
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

echo "Clone tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "copying nvim config"
ln -s $STARTER_DIR/config/nvim/ ~/.config/

echo "copying alacritty config"
ln -s $STARTER_DIR/config/.alacritty.toml ~/

echo "copying tmux config"
ln -s $STARTER_DIR/config/.tmux.conf ~/
