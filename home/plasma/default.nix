{ lib, pkgs, ... }:
let
  catppuccinKdeLatteYellow = pkgs.catppuccin-kde.override {
    flavour = [ "latte" ];
    accents = [ "yellow" ];
    winDecStyles = [ "modern" ];
  };
in
{
  home.file = {
    ".local/share/konsole/catppuccin-latte.colorscheme".text = ''
[Background]
Color=239,241,245

[BackgroundFaint]
Color=239,241,245

[BackgroundIntense]
Color=239,241,245

[Color0]
Color=156,160,176

[Color0Faint]
Color=156,160,176

[Color0Intense]
Color=156,160,176

[Color1]
Color=210,15,57

[Color1Faint]
Color=210,15,57

[Color1Intense]
Color=210,15,57

[Color2]
Color=64,160,43

[Color2Faint]
Color=64,160,43

[Color2Intense]
Color=64,160,43

[Color3]
Color=223,142,29

[Color3Faint]
Color=223,142,29

[Color3Intense]
Color=223,142,29

[Color4]
Color=30,102,245

[Color4Faint]
Color=30,102,245

[Color4Intense]
Color=30,102,245

[Color5]
Color=136,57,239

[Color5Faint]
Color=136,57,239

[Color5Intense]
Color=136,57,239

[Color6]
Color=4,165,229

[Color6Faint]
Color=4,165,229

[Color6Intense]
Color=4,165,229

[Color7]
Color=76,79,105

[Color7Faint]
Color=76,79,105

[Color7Intense]
Color=76,79,105

[Foreground]
Color=76,79,105

[ForegroundFaint]
Color=76,79,105

[ForegroundIntense]
Color=76,79,105

[General]
Blur=false
ColorRandomization=false
Description=Catppuccin Latte
Opacity=1
Wallpaper=
'';

    ".local/share/konsole/catppuccin-latte.profile".text = ''
[Appearance]
ColorScheme=catppuccin-latte
Font=FiraCode Nerd Font,15,-1,5,50,0,0,0,0,0

[General]
Name=catppuccin-latte
Parent=FALLBACK/
'';
  };

  home.packages = [
    catppuccinKdeLatteYellow
    pkgs.catppuccin-cursors.latteYellow
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.latteYellow;
    name = "catppuccin-latte-yellow-cursors";
    size = 24;
  };

  # Apply KDE theme and cursor settings on activation without replacing the full config files.
  home.activation.setCatppuccinPlasma = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v kwriteconfig6 >/dev/null 2>&1; then
      kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage Catppuccin-Latte-Yellow
      kwriteconfig6 --file kdeglobals --group General --key ColorScheme CatppuccinLatteYellow
      kwriteconfig6 --file kdeglobals --group General --key font "Fira Sans,10,-1,5,50,0,0,0,0,0"
      kwriteconfig6 --file kdeglobals --group General --key menuFont "Fira Sans,10,-1,5,50,0,0,0,0,0"
      kwriteconfig6 --file kdeglobals --group General --key toolBarFont "Fira Sans,10,-1,5,50,0,0,0,0,0"
      kwriteconfig6 --file kdeglobals --group General --key fixed "FiraCode Nerd Font,10,-1,5,50,0,0,0,0,0"
      kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "Fira Sans,8,-1,5,50,0,0,0,0,0"
      kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme catppuccin-latte-yellow-cursors
      kwriteconfig6 --file kcminputrc --group Mouse --key cursorSize 24
      kwriteconfig6 --file konsolerc --group Desktop Entry --key DefaultProfile catppuccin-latte.profile
      kwriteconfig6 --file plasmashellrc --group PlasmaApplets --key shellCorona /usr/share/plasmoids/org.kde.plasma.analogclock
      kwriteconfig6 --file kdeglobals --group General --key menuButtonIcon nix-snowflake
    fi
  '';
}
