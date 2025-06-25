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
            sway \
            waybar \
            rofi \
            fastfetch \
            konsave
    elif [[ "$ID" == "fedora" || "$ID_LIKE" == *"fedora"* ]]; then
        sudo dnf install -y \
            zsh \
            kitty \
            neovim \
            sway \
            waybar \
            rofi \
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

ln -sf "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shell/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/shell/p10k.graphical.zsh" "$HOME/.p10k.graphical.zsh"
ln -sf "$DOTFILES_DIR/shell/p10k.tty.zsh" "$HOME/.p10k.tty.zsh"

ln -sf "$DOTFILES_DIR/config/nvim" "$CONFIG_DIR/nvim"
ln -sf "$DOTFILES_DIR/config/kitty" "$CONFIG_DIR/kitty"
ln -sf "$DOTFILES_DIR/config/sway" "$CONFIG_DIR/sway"
ln -sf "$DOTFILES_DIR/config/waybar" "$CONFIG_DIR/waybar"
ln -sf "$DOTFILES_DIR/config/fastfetch" "$CONFIG_DIR/fastfetch"
ln -sf "$DOTFILES_DIR/config/rofi" "$CONFIG_DIR/rofi"

konsave -i "$DOTFILES_DIR/curry-catppuccin.knsv"