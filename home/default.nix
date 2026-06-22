{ pkgs, username, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    rocmSupport = true;
  };

  imports = [
    ./bash
    ./btop
    ./browser
    ./discord
    ./git
    ./obs
    ./fastfetch
    ./nvim
    ./plasma
    ./zen
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXOS_OZONE_WL = "1";
      SAL_USE_VCLPLUGIN = "qt6";
    };

    stateVersion = "25.11";

    packages = with pkgs; [
      # CLI and workflow tools
      ripgrep
      rclone
      file
      tree
      zoxide
      zip
      unzip
      ffmpeg
      gnupg
      flatpak
      distrobox
      gh
      ansible
      ansible-lint
      joycond

      # Desktop applications
      gimp
      qpwgraph
      vlc
      libreoffice-qt
      mediawriter
      protontricks
      element-desktop
      deezer-enhanced
      qalculate-qt
      kdePackages.kate
      kdePackages.partitionmanager
      kdePackages.kcolorpicker
      kdePackages.tokodon
      nixos-artwork.wallpapers.catppuccin-latte
      pcmanfm-qt
      zed-editor-fhs
      signal-desktop
      lmstudio
      prismlauncher
    ];

  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
