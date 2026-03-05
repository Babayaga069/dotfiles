#!/bin/bash
set -e
DOTFILES="$HOME/.dotfiles"

echo "-> Pakete installieren..."
sudo apt install -y git zsh neovim tmux

echo "-> Lazygit installieren... "
curl -Lo /tmp/lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_Linux_x86_64.tar.gz
tar -xzf /tmp/lazygit.tar.gz -C /tmp
sudo mv /tmp/lazygit /usr/local/bin/

echo "→ Symlinks setzen..."
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES/alacritty" "$HOME/.config/alacritty"

echo "→ Shell auf zsh setzen..."
chsh -s $(which zsh)

echo "✓ Fertig!"
