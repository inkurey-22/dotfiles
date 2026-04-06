{ pkgs, username, ... }:
let
  vencordSettings = import ./vencord-settings.nix;
in
{
  home.packages = [
    pkgs.vesktop
  ];

  home.file.".config/vesktop/settings/settings.json".text =
    builtins.toJSON vencordSettings;

  home.file.".config/vesktop/settings/quickCss.css".source = ./quickCss.css;
}
