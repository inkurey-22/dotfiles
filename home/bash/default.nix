{ ... }:
rec {
  programs.bash = {
    enable = true;

    initExtra = ''
      set +o history

      . ${home.file.bashrc.source}
      . ${home.file.aliases.source}
      . ${home.file.env.source}
      . ${home.file.epitech.source}
      . ${home.file.path.source}

      set -o history
    '';
  };

  home.file = {
    bashrc = {
      source = ./bashrc;
      target = ".config/bash/bashrc";
    };
    aliases = {
      source = ./aliases.sh;
      target = ".config/bash/aliases.sh";
    };
    env = {
      source = ./env.sh;
      target = ".config/bash/env.sh";
    };
    epitech = {
      source = ./epitech.sh;
      target = ".config/bash/epitech.sh";
    };
    path = {
      source = ./path.sh;
      target = ".config/bash/path.sh";
    };
  };
}
