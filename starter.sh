#!/bin/bash

export STARTER_DIR=$(pwd)

echo "=== Installing apps through pacman ==="
sudo pacman -S base-devel git curl unzip bat vlc{,-plugins-all} tree tmux alacritty btop neovim fzf go lazygit zsh zed zoxide nvm pnpm php ttf-jetbrains-mono{,-nerd} docker docker-compose okular gwenview
sudo usermod -aG docker $USER

git config --global user.email "you@example.com"
git config --global user.name "Name"

echo "==- Installing rustup.rs ==="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "=== Installing brave.com ==="
curl -fsS https://dl.brave.com/install.sh | sh

echo "=== Installing bun.com ==="
curl -fsSL https://bun.sh/install | bash

echo "=== Installing ohmyz.sh ==="
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "=== Installing ohmyzsh plugins ==="
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && % git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

echo "=== Copying zsh config ==="
mv ~/.zshrc ~/.zshrc.bak
ln -sf $STARTER_DIR/config/.zshrc ~/
. ~/.zshrc

echo "=== Installing aur packages ==="
mkdir ~/applications
git clone https://aur.archlinux.org/paru.git ~/applications
cd ~/applications/paru
makepkg -si

paru -S zen-browser tableplus yaak realvnc-vnc-viewer

echo "=== Making docker containers ==="
docker pull {mariadb,postgres} && docker run -d --name mariadb --restart unless-stopped -e MARIADB_ROOT_PASSWORD=12345678 -e MARIADB_USER=user -e MARIADB_PASSWORD=12345678 -e MARIADB_DATABASE=mysql -p 3306:3306 -v mariadb:/var/lib/mysql mariadb:latest && docker run -d --name psql --restart unless-stopped -e POSTGRES_PASSWORD=12345678 -e POSTGRES_USER=user -p 5432:5432 -v psql:/var/lib/postgresql/data postgres:latest

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
