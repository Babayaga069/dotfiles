#!/bin/bash
set -e
DOTFILES="$HOME/.dotfiles"

# Pakete
echo "-> Pakete installieren..."
sudo apt install -y git zsh neovim tmux
sudo apt install -y fzf zsh zsh-autosuggestions w3m xclip ddgr

echo "→ Lazygit installieren..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit -D -t /usr/local/bin/

# Alacritty nur wenn GUI vorhanden
if [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
  echo "→ Alacritty installieren..."
  sudo apt install -y alacritty
else
  echo "→ Kein Display gefunden, Alacritty wird übersprungen"
fi

# Symlinks
echo "→ Symlinks setzen..."
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES/alacritty" "$HOME/.config/alacritty"

echo "→ Shell auf zsh setzen..."
chsh -s $(which zsh)

echo "✓ Fertig!"
