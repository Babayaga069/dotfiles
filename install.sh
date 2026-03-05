#!/bin/bash
set -e
DOTFILES="$HOME/.dotfiles"

echo "→ Symlinks setzen..."

ln -sf "$DOTFILES/zsh/.zshrc"         "$HOME/.zshrc"
ln -sf "$DOTFILES/tmux/.tmux.conf"    "$HOME/.tmux.conf"
ln -sf "$DOTFILES/nvim"               "$HOME/.config/nvim"
ln -sf "$DOTFILES/alacritty"          "$HOME/.config/alacritty"

echo "→ Shell auf zsh setzen..."
chsh -s $(which zsh)

echo "✓ Fertig!"
