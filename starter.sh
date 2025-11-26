#!/bin/bash

export STARTER_DIR=$(pwd)

if [[ "$SHELL" == *"zsh"* ]]; then
    . ~/.zshrc
fi

echo "=== Installing apps through pacman ==="
sudo pacman -S base-devel git curl unzip bat vlc{,-plugins-all} tree tmux alacritty btop neovim fzf go lazygit zsh zed zoxide nvm pnpm php inter-font ttf-jetbrains-mono{,-nerd} docker docker-compose okular gwenview
sudo usermod -aG docker $USER

git config --global user.email "you@example.com"
git config --global user.name "Name"

echo "=== Installing ohmyz.sh ==="
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/mastr/tools/install.sh)"

echo "=== Installing ohmyzsh plugins ==="
mkdir -p $ZSH_CUSTOM_PLUGINS_DIR/plugins 2>/dev/null
ZSH_CUSTOM_PLUGINS_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins

if [[ ! -d $ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting
fi
if [[ ! -d $ZSH_CUSTOM_PLUGINS_DIR/zsh-autocomplete ]]; then
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM_PLUGINS_DIR/zsh-autocomplete
fi

echo "=== Copying zsh config ==="
mv ~/.zshrc ~/.zshrc.bak
ln -sf $STARTER_DIR/config/.zshrc ~/ &>/dev/null
. ~/.zshrc

echo "==- Installing rustup.rs ==="
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh &>/dev/null
    rustup toolchain install nightly
fi

echo "=== Installing bun.com ==="
if ! command -v bun &>/dev/null; then
    curl -fsSL https://bun.sh/install | bash &>/dev/null
fi

if ! command -v paru &>/dev/null; then
    echo "=== Installing aur packages ==="
    mkdir -p ~/applications/aur-ish
    git clone https://aur.archlinux.org/paru.git ~/applications/aur-ish/paru
    cd ~/applications/aur-ish/paru
    makepkg -si
fi

if ! command -v brave &>/dev/null || ! command -v tableplus &>/dev/null || ! command -v yaak-app &>/dev/null || ! command -v vncviewer &>/dev/null; then
    curl -fsS https://dl.brave.com/install.sh | sh
    paru -S zen-browser tableplus yaak realvnc-vnc-viewer
fi

if docker ps --format '{{.Names}}' | grep -q "mariadb" || docker ps --format '{{.Names}}' | grep -q "psql"; then
    echo "=== Setup docker containers ==="
    docker run -d --name mariadb --restart unless-stopped -e MARIADB_ROOT_PASSWORD=12345678 -e MARIADB_USER=user -e MARIADB_PASSWORD=12345678 -e MARIADB_DATABASE=mysql -p 3306:3306 -v mariadb:/var/lib/mysql mariadb:latest && docker run -d --name psql --restart unless-stopped -e POSTGRES_PASSWORD=12345678 -p 5432:5432 -v psql:/var/lib/postgresql/data postgres:latest
fi

chmod +x $STARTER_DIR/{starter,commit}.sh

if [[ ! -d ~/.config/alacritty/themes || ! -d ~/.tmux/plugins/tpm ]]; then
    echo "=== Clone alacritty-themes ==="
    mkdir -p ~/.config/alacritty/themes
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

    echo "=== Clone tpm ==="
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "=== Copying nvim config ==="
ln -sf $STARTER_DIR/config/nvim/ ~/.config/ &>/dev/null

echo "=== Copying alacritty config ==="
ln -sf $STARTER_DIR/config/.alacritty.toml ~/ &>/dev/null

echo "=== Copying tmux config ==="
ln -sf $STARTER_DIR/config/.tmux.conf ~/ &>/dev/null

. ~/.zshrc
echo "[✓] Done."
