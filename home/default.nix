{ pkgs, username, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    rocmSupport = true;
  };

  imports = [
    ./bash
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
      ripgrep # Move?
      rclone # Move?
      file
      zoxide
      zip
      unzip
      ffmpeg
      gnupg # Move
      steam
      flatpak
      gimp
      qpwgraph
      vlc
      libreoffice
      mediawriter
      protontricks
      nerd-fonts.fira-code
      pcmanfm-qt
    ];

  };

  programs = {
    direnv = {
      # Move
      enable = true;
      nix-direnv.enable = true;
    };
    btop.enable = true; # Move
    lutris = {
      enable = true;
      defaultWinePackage = pkgs.proton-ge-bin;
    };
  };
}
