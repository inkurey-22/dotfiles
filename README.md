# Curry's Dotfiles

Repos for my personal dotfiles, in case i reinstall a system
## IT'S NOT MADE FOR ANYONE ELSE THAN ME

## What's in there

- **Shell**: oh-my-zsh with [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme and custom prompt settings.
- **Neovim**: With [NvChad](https://nvchad.com/) as a base, with additional plugins like the one for Epitech header.
- **Kitty**: Terminal emulator, catppuccin theme + ligatures
- **Sway**: Tiling Wayland compositor, with matching configuration.
- **Waybar**: Custom status bar for Sway.
- **Rofi**: Application launcher for Sway.
- **Fastfetch**: System info tool with custom Catppuccin ASCII art.
- **Konsave**: To get back my KDE Plasma config.

## Installation

WARNING
You need several things that aren't installed automatically:
- yay (for Arch)
- KDE Plasma + SDDM
- Konsave (if on other distro than Arch)
- FiraCode **Nerd** Font

Clone this repository to your home directory:

```sh
git clone https://github.com/inkurey-22/dotfiles.git ~/dotfiles
cd ~/.dotfiles
./link.sh
```
The script will install packages (if on Fedora and Arch)
Set zsh as default shell
Symlink all configuration files to HOME and HOME/.config
Load konsave layout.

WARNING 2
It doesn't install oh-my-zsh and p10k, you'll have to do this yourself

## Credits
- [NvChad](https://nvchad.com)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [p10k](https://github.com/romkatv/powerlevel10k)
- [Konsave](https://github.com/Prayag2/konsave)
