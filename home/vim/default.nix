{ pkgs, ... }:
let
  vimEpitech = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-epitech";
    version = "b97cab4";
    src = pkgs.fetchFromGitHub {
      owner = "Epitech";
      repo = "vim-epitech";
      rev = "b97cab4bd988dc2a8432664dd43b4656d9931ce3";
      sha256 = "sha256-jxW3/id7WVrLc0+2Z6g6lfD5wBcbxYyGHkigfsU2QPk=";
    };
  };
in
{
  home.file = {
    vimrc = {
      source = ./.vimrc;
      target = ".vimrc";
    };
  };

  programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      delimitMate
      vimEpitech
    ];
  };
}
