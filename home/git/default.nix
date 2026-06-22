{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = "8B40CD831C17DFBE8EC74FCDFDFB4C182419731B";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Théophile R.";
        email = "inkurey22.tr@proton.me";
      };
      init.defaultBranch = "main";
      commit.verbose = "yes";
    };
  };
}
