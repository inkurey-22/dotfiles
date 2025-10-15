echo "Downloading epitech packages..."
sudo pacman -S --needed $(grep -vE '^\s*#|^\s*$' ./packages/epitech-packages.txt)
yay -S --needed teams-for-linux-bin
sudo systemctl enable docker.socket
sudo systemctl enable libvirtd.service
sudo usermod -aG docker $USER
sudo usermod -aG libvirt $USER

# Clang format
cp ./config/.clang-format ~/

# CONFIG EMACS
git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
./INSTALL.sh local
cd .. && rm -rf epitech-emacs

# CONFIG VIM
git clone https://github.com/Epitech/vim-epitech.git
cd vim-epitech
./install.sh local
cd .. && rm -rf vim-epitech

# Dev env
echo "Follow distrobox-epitech.md in order to setup the epitech dev container."
