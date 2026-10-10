# starter

A personal workstation bootstrap for **Fedora**. It installs the packages, tooling, and dotfiles needed for a terminal-first development environment, then switches your default shell to **fish** with [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish).

> Run it on a **fresh** Fedora machine. It is not idempotent-safe for every step (it changes your login shell and writes to `~/.config`) and it calls `sudo` several times, so keep your password handy.

## Quick start

```bash
chmod +x starter.sh install.sh commit.sh

./starter.sh <gitEmail> <gitName>
```

Example:

```bash
./starter.sh you@example.com "Your Name"
```

`starter.sh` validates the two arguments (and supports `--help`), then hands off to `install.sh`. When it finishes, **restart your shell or log out and back in** so the new login shell and PATH changes take effect.

## Scripts

| Script        | Purpose                                                                          |
| ------------- | -------------------------------------------------------------------------------- |
| `starter.sh` | Entry point. Validates `<gitEmail>` `<gitName>`, then runs `install.sh`.          |
| `install.sh` | The actual bootstrap: packages, runtimes, dotfiles, and `git config`.            |
| `commit.sh`  | Convenience wrapper: `git add .` → `git commit -m "automated commit"` → `git push`. |

## What gets installed

**System packages** (via `dnf`)

- Essentials: `git`, `curl`, `unzip`, `rsync`, `tree-sitter-cli`
- Terminal & shell: `alacritty`, `foot`, `fish`, `tmux`, `zoxide`, `btop`, `rsms-inter-fonts`
- Languages: `golang`, `luarocks`, `development-tools` group
- Containers: `podman`, `podman-compose`
- Media & docs: `vlc`, `okular`, `gwenview`

**RPM Fusion** repos are enabled first so media/codec packages can resolve.

**Languages & runtimes** (installed only if missing)

- [Rust](https://rustup.rs) via `rustup`
- [Bun](https://bun.sh) via the install script
- Node.js LTS via **NVM**, installed as an Oh My Fish plugin (`omf install nvm && nvm install --lts`)
- [ast-grep](https://ast-grep.github.io) via `cargo install`

**Browsers & fonts**

- [Brave](https://brave.com) (skipped if already installed), seeded with `config/brave-preferences`
- JetBrains Mono Nerd Font into `~/.local/share/fonts/JetBrainsMonoNerd`, then `fc-cache`

**Terminal tooling**

- [alacritty-theme](https://github.com/alacritty/alacritty-theme) cloned to `~/.config/alacritty/themes`
- [tpm](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager) cloned to `~/.tmux/plugins/tpm`
- [lazygit](https://github.com/jesseduffield/lazygit) from the `dejan/lazygit` COPR
- [Flatpak](https://flatpak.org) with the Flathub remote added if not present

## Shell setup

The script registers `fish` in `/etc/shells`, detects your current login shell via `getent passwd`, and runs `chsh -s "$(command -v fish)"` if it isn't already the default. Oh My Fish is then installed (if `~/.local/share/omf` is missing) and updated.

## Dotfiles

After installation, these files are **symlinked** from `config/` into your home directory:

| Source                   | Target                             |
| ------------------------ | ---------------------------------- |
| `config/.alacritty.toml` | `~/.alacritty.toml`                |
| `config/.tmux.conf`      | `~/.tmux.conf`                     |
| `config/personal.fish`   | `~/.config/fish/conf.d/personal.fish` |
| `config/nvim`            | `~/.config/nvim` (LazyVim)         |

Any target that already exists is left untouched and reported as `[SKIP]`, so your own dotfiles are never overwritten.

Neovim uses [LazyVim](https://www.lazyvim.org) as a base — see `config/nvim/lazyvim.json` and `config/nvim/lua/plugins` for the plugin set.

## Git identity

The two arguments you pass to `starter.sh` are applied globally:

```bash
git config --global user.email "<gitEmail>"
git config --global user.name  "<gitName>"
```

## Not linked

Some files in `config/` are kept for reference or manual setup and are **not** symlinked automatically: `.zshrc`, `config.ghostty`, `kdefullshortcut.kksrc`, `containers/`, and `compose.yaml`.

## Repo layout

```
starter.sh              # entry point
install.sh              # bootstrap logic
commit.sh               # add / commit / push helper
config/                 # dotfiles and reference configs
  .alacritty.toml
  .tmux.conf
  personal.fish
  brave-preferences
  nvim/                 # LazyVim config
  containers/           # podman config (manual)
```

## Notes / caveats

- Requires `sudo` and an internet connection.
- **one-shot**; re-running re-installs packages and re-runs `chsh`.
- `cargo install ast-grep` happens inside the install flow, so Rust must already be on `PATH`.
