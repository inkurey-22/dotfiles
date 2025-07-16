#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

# === INSTALL REQUIREMENTS BASED ON OS === #
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
        yay -S --needed --noconfirm \
            zsh \
            kitty \
            neovim \
            fastfetch \
    elif [[ "$ID" == "fedora" || "$ID_LIKE" == *"fedora"* ]]; then
        sudo dnf install -y \
            zsh \
            kitty \
            neovim \
            fastfetch
    else
        echo "Unsupported OS: $ID"
        exit 1
    fi
else
    echo "/etc/os-release not found. Cannot detect OS."
    exit 1
fi

# === SET ZSH AS DEFAULT SHELL === #
chsh -s $(which zsh)

# === LINK DOTFILES === #

cp -f "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
cp -f "$DOTFILES_DIR/shell/zshenv" "$HOME/.zshenv"
cp -f "$DOTFILES_DIR/shell/p10k.graphical.zsh" "$HOME/.p10k.graphical.zsh"
cp -f "$DOTFILES_DIR/shell/p10k.tty.zsh" "$HOME/.p10k.tty.zsh"

rm -rf "$CONFIG_DIR/nvim" \
    "$CONFIG_DIR/kitty" \
    "$CONFIG_DIR/fastfetch"

cp -r "$DOTFILES_DIR/config/nvim" "$CONFIG_DIR/nvim"
cp -r "$DOTFILES_DIR/config/kitty" "$CONFIG_DIR/kitty"
cp -r "$DOTFILES_DIR/config/fastfetch" "$CONFIG_DIR/fastfetch"