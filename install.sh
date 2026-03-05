#!/usr/bin/env bash
set -e
DOTFILES="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"

function syncFile() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
}

function doSync() {
  echo "→ Symlinks setzen..."
  syncFile "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
  syncFile "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
  syncFile "$DOTFILES/nvim" "$HOME/.config/nvim"
  syncFile "$DOTFILES/alacritty" "$HOME/.config/alacritty"
}

echo "→ Pakete installieren..."
sudo apt install -y git zsh neovim tmux fzf zsh-autosuggestions w3m xclip ddgr lazygit

if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
  sudo apt install -y alacritty
fi

read -p "Symlinks setzen? Überschreibt bestehende Dateien. (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  doSync
fi

echo "→ Shell auf zsh setzen..."
chsh -s $(which zsh)

echo "✓ Fertig!"
