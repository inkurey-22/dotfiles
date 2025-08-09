#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

cp -f "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
cp -f "$DOTFILES_DIR/shell/p10k.graphical.zsh" "$HOME/.p10k.graphical.zsh"
cp -f "$DOTFILES_DIR/shell/p10k.tty.zsh" "$HOME/.p10k.tty.zsh"

rm -rf "$CONFIG_DIR/nvim" \
    "$CONFIG_DIR/kitty" \
    "$CONFIG_DIR/fastfetch"

cp -r "$DOTFILES_DIR/config/nvim" "$CONFIG_DIR/nvim"
cp -r "$DOTFILES_DIR/config/kitty" "$CONFIG_DIR/kitty"
cp -r "$DOTFILES_DIR/config/fastfetch" "$CONFIG_DIR/fastfetch"
