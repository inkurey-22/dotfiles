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
    ./obs
    ./fastfetch
    ./nvim
    ./plasma
    ./vscode
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXOS_OZONE_WL = "1";
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

      # Desktop applications
      gimp
      qpwgraph
      vlc
      libreoffice
      mediawriter
      protontricks
      element-desktop
      deezer-enhanced
      qalculate-qt
      kdePackages.kate
      kdePackages.partitionmanager
      nixos-artwork.wallpapers.catppuccin-latte
      pcmanfm-qt
    ];

  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    lutris = {
      enable = true;
      defaultWinePackage = pkgs.proton-ge-bin;
    };
  };
}
