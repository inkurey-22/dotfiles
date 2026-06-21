{ pkgs, inputs, ... }:
let
  vencordSettings = import ./vencord-settings.nix;
in
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;

    # Use Discord with Vencord and OpenASAR
    discord.vencord.enable = true;

    # Settings
    config = vencordSettings;
    quickCss = builtins.readFile ./quickCss.css;
  };
}
