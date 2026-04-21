{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        github.copilot-chat
        bbenoist.nix
        catppuccin.catppuccin-vsc-icons
        llvm-vs-code-extensions.vscode-clangd
        rust-lang.rust-analyzer
      ];
      userSettings = {
        "extensions.ignoreRecommendations" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
        "workbench.colorTheme" = "Catppuccin Latte";
        "workbench.iconTheme" = "catppuccin-latte";
        "catppuccin.accentColor" = "yellow";
        "catppuccin.customUIColors" = {
          latte = {
            "statusBar.foreground" = "crust";
            "statusBar.background" = "yellow";
            "activityBar.activeBorder" = "yellow";
          };
        };
        "workbench.colorCustomizations" = {
          "[Catppuccin Latte]" = {
            "activityBarBadge.background" = "#df8e1d";
            "statusBarItem.remoteBackground" = "#df8e1d";
            "statusBarItem.prominentBackground" = "#df8e1d";
            "editorCursor.foreground" = "#df8e1d";
          };
        };
      };
    };
  };
}
