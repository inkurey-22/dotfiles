ask_yes_no() {
    while true; do
        read -p "$1 (Yy/Nn): " response
        case $response in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer with y or n.";;
        esac
    done
}

enable_multilib() {
    local conf="/etc/pacman.conf"
    local backup="/etc/pacman.conf.bak"

    # Backup configuration
    sudo cp "$conf" "$backup"

    # Check if multilib is already enabled
    if grep -Eq "^\[multilib\]" "$conf"; then
        echo "Multilib is already enabled."
        return 0
    fi

    # Uncomment [multilib] section and the Include line
    sudo sed -i '/^\s*#\[multilib\]/,/^\s*#Include = \/etc\/pacman.d\/mirrorlist/{
        s/^\s*#//
    }' "$conf"

    # Double-check it succeeded
    if ! grep -Eq "^\[multilib\]" "$conf"; then
        echo "Failed to enable multilib. Please edit $conf manually."
        return 1
    fi

    # Update package database
    sudo pacman -Sy
    echo "Multilib enabled."
}

install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "Installing yay..."
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd .. && rm -rf yay
        export PATH="$PATH:$HOME/.local/bin"
    else
        echo "yay is already installed."
    fi
}

modify_grub_config() {
    local grubfile="/etc/default/grub"
    local backup="/etc/default/grub.bak"
    sudo cp "$grubfile" "$backup"
    sudo cp config/celeste-grub /boot/grub/themes/

    # Array of lines to ensure are set
    local lines=(
        "GRUB_DEFAULT=saved"
        "GRUB_SAVEDEFAULT=true"
        "GRUB_DISABLE_OS_PROBER=false"
        "GRUB_THEME=\"/boot/grub/themes/celeste-grub/theme.txt\""
    )

    for entry in "${lines[@]}"; do
        local key="${entry%%=*}"
        local val="${entry#*=}"
        if grep -Eq "^\s*#\s*${key}=" "$grubfile"; then
            # Uncomment and set the correct value
            sudo sed -i "s|^\s*#\s*${key}=.*|${key}=${val}|" "$grubfile"
        elif grep -Eq "^\s*${key}=" "$grubfile"; then
            # Change value if different
            sudo sed -i "s|^\s*${key}=.*|${key}=${val}|" "$grubfile"
        else
            # Add line if not present
            echo "${key}=${val}" | sudo tee -a "$grubfile" > /dev/null
        fi
    done

    params=("quiet" "splash" "loglevel=3" "systemd.show_status=auto" "rd.udev.log_level=3" "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166 vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173 vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200")

    # Extract the current value of GRUB_CMDLINE_LINUX_DEFAULT
    current=$(grep '^GRUB_CMDLINE_LINUX_DEFAULT=' "$grubfile" | sed 's/^GRUB_CMDLINE_LINUX_DEFAULT="\([^"]*\)".*$/\1/')

    # Initialize variable to track if changes were made
    modified=0

    for param in "${params[@]}"; do
        # Check if parameter is already present
        if [[ ! "$current" =~ (^|[[:space:]])$param($|[[:space:]]) ]]; then
            current="$current $param"
            modified=1
            echo "Appending $param to GRUB_CMDLINE_LINUX_DEFAULT."
        else
            echo "$param is already present in GRUB_CMDLINE_LINUX_DEFAULT."
        fi
    done

    if [ $modified -eq 1 ]; then
        # Trim leading/trailing spaces
        current=$(echo "$current" | xargs)
        sudo sed -i -E "s@^(GRUB_CMDLINE_LINUX_DEFAULT=\")[^\"]*(\".*)@\1$current\2@" "$grubfile"
        echo "Updated GRUB_CMDLINE_LINUX_DEFAULT in $grubfile."
    else
        echo "No changes needed in $grubfile."
    fi

    # Regenerate the GRUB config
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "GRUB configuration updated."
}

modify_pacman_options() {
    local pacman_conf="/etc/pacman.conf"
    local backup="/etc/pacman.conf.bak"
    sudo cp "$pacman_conf" "$backup"

    # Array of desired options (as literal strings, no key/value)
    local options=("Color" "ILoveCandy" "VerbosePkgLists")

    for opt in "${options[@]}"; do
        if grep -Eq "^\s*#\s*${opt}\b" "$pacman_conf"; then
            # Uncomment the line if commented
            sudo sed -i "s|^\s*#\s*${opt}|${opt}|" "$pacman_conf"
        elif ! grep -Eq "^\s*${opt}\b" "$pacman_conf"; then
            # Add the option if not present, after "[options]"
            sudo sed -i "/^\[options\]/a ${opt}" "$pacman_conf"
        fi
    done

    echo "Pacman visual options updated."
}

echo "Installing Reyshyram's dotfiles..."

enable_multilib
modify_pacman_options
install_yay

# Install required packages
sudo pacman -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/packages.txt)
yay -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/aur-packages.txt)

# Install headers for kernels
for pkg in $(pacman -Qq | grep '^linux' | grep -v 'headers'); do
    if [[ "$pkg" == linux-firmware* ]]; then
        continue
    fi
    yay -S --needed "${pkg}-headers"
done

sudo os-prober
modify_grub_config

# SDDM
sudo systemctl enable sddm.service
sudo sed -i.bak 's|^ConfigFile=.*$|ConfigFile=configs/rei.conf|' "/usr/share/sddm/themes/silent/metadata.desktop"

# UWSM config
mkdir -p ~/.config/uwsm/
cp ./config/uwsm/* ~/.config/uwsm/

# Reflector
sudo mkdir -p /etc/xdg/reflector/reflector.conf
sudo cp ./config/reflector.conf /etc/xdg/reflector/reflector.conf
sudo systemctl start reflector.timer
sudo systemctl enable reflector.timer

# Plymouth
echo "Editing /etc/mkinitcpio.conf to add plymouth modules..."
sudo mkdir -p /usr/share/plymouth/themes/
sudo sed -i '/^HOOKS=/ s/)$/ plymouth)/' /etc/mkinitcpio.conf
sudo cp -r ./config/plymouth/black_hud /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R black_hud
sudo mkinitcpio -P

# Kitty
echo "Configuring kitty..."
mkdir -p ~/.config/kitty
cp ./config/kitty/kitty.conf ~/.config/kitty/
mkdir -p ~/.local/bin
cp ./config/xdg-terminal-exec ~/.local/bin/xdg-terminal-exec
chmod +x ~/.local/bin/xdg-terminal-exec

# Pcmanfm-qt
echo "Configuring pcmanfm-qt..."
mkdir -p ~/.config/pcmanfm-qt/default/
cp ./config/pcmanfm-qt/settings.conf ~/.config/pcmanfm-qt/default/

# Set application associations
xdg-settings set default-web-browser firefox.desktop
xdg-mime default pcmanfm-qt.desktop inode/directory

# Configure Zsh
echo "Configuring Zsh..."
chsh -s "$(which zsh)"
sudo chsh -s "$(which zsh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp ./config/.zshrc ~/.zshrc
cp ./config/.zprofile ~/.zprofile
cp ./config/.p10k.zsh ~/.p10k.zsh
cp ./config/.p10k.tty.zsh ~/.p10k.tty.zsh

# Configure Fastfetch
echo "Configuring Fastfetch..."
cp -r ./config/fastfetch ~/.config/

# Configure Micro theme
echo "Configuring Micro theme..."
mkdir -p ~/.config/micro/
cp -r ./config/micro/* ~/.config/micro/

# Configure Btop
echo "Configuring Btop..."
mkdir -p ~/.config/btop/
cp -r ./config/btop/* ~/.config/btop/

# Configure NeoVim
echo "Configuring NeoVim..."
mkdir -p ~/.config/nvim/
cp -r ./config/nvim/* ~/.config/nvim/

# Papirus icon theme
sudo hardcode-fixer
sudo -E hardcode-tray --conversion-tool RSVGConvert --size 22 --theme Papirus

# Cursor theme
wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz
tar xf Bibata-Modern-Classic.tar.xz
mv Bibata-Modern-Classic ~/.local/share/icons/
rm Bibata-Modern-Classic.tar.xz

# Configure Hyprland
echo "Configuring Hyprland..."
mkdir -p ~/.config/hypr
cp -r ./config/hypr/* ~/.config/hypr/
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/hypr/scripts/reyshell/*.sh

# Profile picture
cp ./config/.face ~/.face
ln -s -f ~/.face ~/.face.icon
sudo chmod +x /usr/share/sddm/themes/silent/change_avatar.sh
/usr/share/sddm/themes/silent/change_avatar.sh $USER ~/.face

# Reyshell
sudo ln -s -f ~/.config/hypr/scripts/reyshell/run.sh /usr/local/bin/reyshell
sudo chmod +x /usr/local/bin/reyshell

# Add user to input group
echo "Adding user to input group..."
sudo usermod -a -G input "$USER"

# Add user to video group
echo "Adding user to video group..."
sudo usermod -a -G video "$USER"

# Apply GTK theme
echo "Applying GTK theme..."
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
cp -r ./config/gtk-* ~/.config/
cp -r ./config/nwg-look ~/.config/
cp -r ./config/xsettingsd ~/.config/
cp ./config/.gtkrc-2.0 ~/
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
sudo chown $USER ~/.config/gtk-4.0/gtk.css

# Vscode color scheme
code -install-extension ./config/reyshell-vscode-integration-1.2.0.vsix

# Copy wallpapers
echo "Copying wallpapers..."
mkdir -p ~/Pictures
cp ./Wallpapers ~/Pictures/*

# Quickshell config
mkdir -p ~/.config/quickshell/
cp -r ./config/quickshell/reyshell ~/.config/quickshell/

install_dir=$(pwd)
cd ~/.config/quickshell/reyshell/

cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/
cmake --build build
sudo cmake --install build

cd $install_dir

# Generate color scheme
/usr/local/bin/reyshell scheme set -n shadotheme

# Enable Bluetooth
echo "Enabling Bluetooth..."
sudo systemctl enable bluetooth.service

# GPU Specific install
if ask_yes_no "Do you want to install Nvidia GPU drivers?"; then
    sudo pacman -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/nvidia-packages.txt)
    
    if [ ! -f /etc/modprobe.d/nvidia.conf ]; then
        echo "options nvidia_drm modeset=1" | sudo tee /etc/modprobe.d/nvidia.conf
    else
        echo "/etc/modprobe.d/nvidia.conf already exists. Skipping."
    fi

    echo "Editing /etc/mkinitcpio.conf to add Nvidia modules..."
    sudo sed -i 's/^MODULES=(/&nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
    sudo mkinitcpio -P

    echo "Enabling required services..."
    sudo systemctl enable nvidia-suspend.service
    sudo systemctl enable nvidia-hibernate.service
    sudo systemctl enable nvidia-resume.service

    conf="/etc/default/grub"
    param="nvidia.NVreg_PreserveVideoMemoryAllocations=1"

    # Only modify if the parameter is not present.
    if ! grep -q "${param}" "$conf"; then
        sudo sed -i -E "s@^(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*)\"@\1 ${param}\"@" "$conf"
        echo "Appended ${param} to GRUB_CMDLINE_LINUX_DEFAULT."
    else
        echo "${param} is already present in GRUB_CMDLINE_LINUX_DEFAULT."
    fi

    envfile="$HOME/.config/uwsm/env"
    mkdir -p "$(dirname "$envfile")"

    vars=(
    'export GBM_BACKEND=nvidia-drm'
    'export __GLX_VENDOR_LIBRARY_NAME=nvidia'
    'export LIBVA_DRIVER_NAME=nvidia'
    'export NVD_BACKEND=direct'
    )

    touch "$envfile"

    for var in "${vars[@]}"; do
        if ! grep -qxF "$var" "$envfile"; then
            echo "$var" >> "$envfile"
        fi
    done
else
    echo "Nvidia GPU installation skipped."
fi

if ask_yes_no "Do you want to install AMD GPU drivers?"; then
    sudo pacman -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/amd-packages.txt)
else
    echo "AMD GPU installation skipped."
fi

# Gaming packages
if ask_yes_no "Would you like to download additional gaming packages?"; then
    echo "Downloading gaming packages..."
    sudo pacman -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/gaming-packages.txt)
    yay -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/aur-gaming-packages.txt)
else
    echo "Skipping gaming packages."
fi

echo "Installation finished."
