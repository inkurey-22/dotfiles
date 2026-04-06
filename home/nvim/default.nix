{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      catppuccin-nvim
    ];

    initLua = builtins.readFile ./init.lua;
  };
}
