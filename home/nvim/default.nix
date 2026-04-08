{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      catppuccin-nvim
    ];

    initLua = builtins.readFile ./init.lua;
  };
}
