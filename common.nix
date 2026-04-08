# Shared configuration across all machines
{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable Plasma desktop and use the Plasma login manager.
  services.xserver.enable = false;

  # Use the native Plasma login manager for Plasma sessions.
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Desktop portals are required by many Wayland applications.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Catppuccin Latte palette for Linux virtual consoles (TTY).
  boot.kernelParams = [
    "vt.default_red=239,210,64,223,30,234,23,108,172,210,64,223,30,234,23,76"
    "vt.default_grn=241,15,160,142,102,118,146,111,176,15,160,142,102,118,146,79"
    "vt.default_blu=245,57,43,29,245,203,153,133,190,57,43,29,245,203,153,105"
  ];

  fonts = {
    packages = with pkgs; [
      fira
      fira-code
      nerd-fonts.fira-code
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Fira Sans" ];
        serif = [ "Fira Sans" ];
        monospace = [ "FiraCode Nerd Font" "Fira Code" ];
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  virtualisation.docker.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.steam = {
    enable = true;
  };

  # Define a user account.
  users.users.curry = {
    isNormalUser = true;
    description = "Curry";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.partitionmanager
      element-desktop
      tree
      zip
      unzip
      nixos-artwork.wallpapers.catppuccin-latte
      deezer-enhanced
      qalculate-qt
      distrobox
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    docker
  ];

  environment.sessionVariables = { };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.11";
}
