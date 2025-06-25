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
            fastfetch \
            konsave
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

ln -sf "$HOME/.zshrc" "$DOTFILES_DIR/shell/zshrc"
ln -sf "$HOME/.zshenv" "$DOTFILES_DIR/shell/zshenv"
ln -sf "$HOME/.p10k.graphical.zsh" "$DOTFILES_DIR/shell/p10k.graphical.zsh"
ln -sf "$HOME/.p10k.tty.zsh" "$DOTFILES_DIR/shell/p10k.tty.zsh"

ln -sf "$CONFIG_DIR/nvim" "$DOTFILES_DIR/config/nvim"
ln -sf "$CONFIG_DIR/kitty" "$DOTFILES_DIR/config/kitty"
ln -sf "$CONFIG_DIR/sway" "$DOTFILES_DIR/config/sway"
ln -sf "$CONFIG_DIR/waybar" "$DOTFILES_DIR/config/waybar"
ln -sf "$CONFIG_DIR/fastfetch" "$DOTFILES_DIR/config/fastfetch"
ln -sf "$CONFIG_DIR/Code" "$DOTFILES_DIR/config/Code"
ln -sf "$CONFIG_DIR/rofi" "$DOTFILES_DIR/config/rofi"

konsave -i "$DOTFILES_DIR/curry-catppuccin.knsv"