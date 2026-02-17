#/bin/bash

STARTER_DIR="$(pwd)"
AUR_DIR="$HOME/applications/aurs"
GIT_EMAIL="$1"
GIT_NAME="$2"

mkdir -p $AUR_DIR

echo "=== Installing apps through pacman ==="
sudo pacman -S --needed --noconfirm pacman-contrib base-devel git curl unzip bat vlc{,-plugins-all} tree tmux alacritty btop rsync neovim tree-sitter lua-rocks fzf zig go lazygit zsh zsh-completions zoxide nvm pnpm php inter-font ttf-jetbrains-mono{,-nerd} lua-language-server docker docker-compose docker-buildx okular gwenview ast-grep
sudo usermod -aG docker $USER || true

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

if [[ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]]; then
    echo "=== Installing oh-my-zsh ==="
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "=== Installing ohmyzsh plugins ==="
ZSH_CUSTOM_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p $ZSH_CUSTOM_PLUGINS_DIR 2>/dev/null
if [[ ! -d $ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting
fi
if [[ ! -d $ZSH_CUSTOM_PLUGINS_DIR/zsh-autocomplete ]]; then
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM_PLUGINS_DIR/zsh-autocomplete
fi

echo "=== Copying zsh config ==="
if [[ -f ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc.ori
fi
ln -sf $STARTER_DIR/config/.zshrc ~/ &>/dev/null

if ! command -v rustup &>/dev/null; then
    echo "==- Installing rustup.rs ==="
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh &>/dev/null
    rustup toolchain install nightly
fi

if ! command -v bun &>/dev/null; then
    echo "=== Installing bun.com ==="
    curl -fsSL https://bun.sh/install | bash &>/dev/null
fi

# aur-ish
echo "=== Installing aur packages ==="

if ! command -v paru &>/dev/null; then
    git clone https://aur.archlinux.org/paru.git $AUR_DIR/paru
    cd $AUR_DIR/paru
    makepkg -si --noconfirm
    cd $STARTER_DIR
fi

# if ! command -v zen-browser &>/dev/null; then
#     echo "=== Installing Zen-Browser ==="
#     paru -S --noconfirm zen-browser-bin
# fi

if ! command -v tableplus &>/dev/null; then
    echo "=== Installing TablePlus ==="
    paru -S --noconfirm tableplus
fi

if ! command -v yaak-app &>/dev/null; then
    echo "=== Installing Yaak ==="
    paru -S --noconfirm yaak-bin
fi

if ! command -v vncviewer &>/dev/null; then
    echo "=== Installing VNCviewer ==="
    paru -S --noconfirm realvnc-vnc-viewer
fi

if ! command -v brave &>/dev/null; then
    echo "=== Installing Brave ==="
    curl -fsS https://dl.brave.com/install.sh | sh
    mkdir -p ~/.config/BraveSoftware/Brave-Browser/Default
    cp $STARTER_DIR/config/brave-preferences ~/.config/BraveSoftware/Brave-Browser/Default/Preferences
fi

if ! command -v dbpro &>/dev/null; then
    echo "=== Installing DBPro ==="
    git clone https://github.com/imfairz/dbpro $AUR_DIR/dbpro
    cd $AUR_DIR/dbpro
    chmod +x install.sh
    ./install.sh
    cd $STARTER_DIR
fi

echo "=== Done with aurs. ==="
# end aur-ish

if ! docker ps --format '{{.Names}}' | grep -q "mariadb" && ! docker ps --format '{{.Names}}' | grep -q "psql"; then
    echo "=== Setup docker containers ==="
    docker compose -f $STARTER_DIR/config/compose.yaml up -d
fi

chmod +x $STARTER_DIR/{starter,commit}.sh

if [[ ! -d ~/.config/alacritty/themes || ! -d ~/.tmux/plugins/tpm ]]; then
    echo "=== Clone alacritty-themes ==="
    mkdir -p ~/.config/alacritty/themes
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

    echo "=== Clone tpm ==="
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "=== Copying config ==="
ln -sf $STARTER_DIR/config/nvim/ ~/.config/ &>/dev/null
ln -sf $STARTER_DIR/config/.alacritty.toml ~/ &>/dev/null
ln -sf $STARTER_DIR/config/.tmux.conf ~/ &>/dev/null
