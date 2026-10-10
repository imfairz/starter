#/bin/bash

STARTER_DIR="$(pwd)"
GIT_EMAIL="$1"
GIT_NAME="$2"

echo "=== Installing Packages ==="
sudo dnf install \
  git \
  curl \
  foot \
  fish \
  zoxide \
  unzip \
  tmux \
  alacritty \
  btop \
  rsync \
  tree-sitter-cli \
  luarocks \
  golang \
  rsms-inter-fonts \
  podman{,-compose} \
  okular \
  gwenview # lua-language-server \

### Development Tools ###
sudo dnf group install development-tools

### Rustup ###
if ! command -v rustup &>/dev/null; then
  echo "=== Installing Rust ==="
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

### Bun ###
if ! command -v bun &>/dev/null; then
  echo "=== Installing bun.com ==="
  curl -fsSL https://bun.sh/install | bash &>/dev/null
fi

### NVM & Node ###
# if ! -d ~/.nvm; then
#   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
# fi
# if ! command -v node &>/dev/null; then
#   echo "=== Installing nodejs ==="
#   nvm install --lts | bash &>/dev/null
# fi

### Brave ###
if ! command -v brave-browser &>/dev/null; then
  echo "=== Installing Brave ==="
  curl -fsS https://dl.brave.com/install.sh | sh
  mkdir -p ~/.config/BraveSoftware/Brave-Browser/Default
  cp $STARTER_DIR/config/brave-preferences ~/.config/BraveSoftware/Brave-Browser/Default/Preferences
fi

### Alacritty Themes ###
if [[ ! -d ~/.config/alacritty/themes ]]; then
  echo "=== Clone alacritty-themes ==="
  mkdir -p ~/.config/alacritty/themes
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

### Tmux Plugin Manager ###
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "=== Clone tpm ==="
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

### START Post Depedencies-Install ###
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# ISSUES
# sudo dnf swap kmime kf6-kmime --allowerasing

sudo dnf install \
  neovim \
  fzf \
  vlc{,-plugins-all}

### Oh My Fish ###
command -v fish | sudo tee -a /etc/shells

current_shell="$(getent passwd "$USER" | cut -d: -f7)"
fish_path="$(command -v fish)"
if [[ "$current_shell" != "$fish_path" ]]; then
  chsh -s "$fish_path"
fi

if [ ! -d ~/.local/share/omf ]; then
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi
fish -c "omf update && omf install nvm && nvm install --lts"

# Flatpak
if ! command -v flatpak &>/dev/null; then
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# Jetbrains Fonts (Mono & Nerd)
if [[ ! -d ~/.local/share/fonts/JetBrainsMonoNerd ]]; then
  mkdir -p ~/.local/share/fonts/JetBrainsMonoNerd
  cd ~/.local/share/fonts/JetBrainsMonoNerd
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip JetBrainsMono.zip
  fc-cache -f
fi

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

### Handled by omf
# if [ "$SHELL" == "/usr/bin/fish" ]; then
#   chsh -s /usr/bin/fish
# fi

# Ast-grep
if ! command -v ast-grep &>/dev/null; then
  cargo install ast-grep --locked
fi

# Lazygit
if ! command -v lazygit &>/dev/null; then
  sudo dnf copr enable dejan/lazygit
  sudo dnf install lazygit
fi
### END Post Depedencies-Install ###

### Linking Config Files ###
declare -A config_files=(
  [".alacritty.toml"]="$HOME/"
  [".tmux.conf"]="$HOME/"
  ["personal.fish"]="$HOME/.config/fish/conf.d/"
  ["nvim"]="$HOME/.config/"
)
echo "=== Copying config ==="
for file in "${!config_targets[@]}"; do
  source="$STARTER_DIR/config/$file"
  target="${config_targets[$file]}$file"

  if [[ -e "$target" || -L "$target" ]]; then
    echo "[SKIP] $target already exists"
    continue
  fi

  ln -s "$source" "$target" &&
    echo "[OK] $target linked" ||
    echo "[ERROR] Failed to link $target"
done

# if ! podman ps --format '{{.Names}}' | grep -q "mariadb" && ! podman ps --format '{{.Names}}' | grep -q "postgres"; then
#     echo "=== Setup podman containers ==="
#     cd $STARTER_DIR/config
#     podman-compose up -d
# fi
