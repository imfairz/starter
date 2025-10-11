#!/bin/bash

export STARTER_DIR=$(pwd)

chmod +x $STARTER_DIR/{starter,commit}.sh

echo "=== Clone alacritty-themes ==="
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

echo "=== Clone tpm ==="
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "=== Copying nvim config ==="
ln -sf $STARTER_DIR/config/nvim/ ~/.config/

echo "=== Copying alacritty config ==="
ln -sf $STARTER_DIR/config/.alacritty.toml ~/

echo "=== Copying tmux config ==="
ln -sf $STARTER_DIR/config/.tmux.conf ~/

echo "[✓] Done."
