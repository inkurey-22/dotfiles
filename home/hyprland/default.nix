{ lib, ... }:
{
  programs.hyprshot.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  home.activation.ensureHyprMonitorsConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e "$HOME/.config/hypr/monitors.conf" ]; then
      mkdir -p "$HOME/.config/hypr"
      cat > "$HOME/.config/hypr/monitors.conf" <<'EOF'
# Managed by nwg-displays.
# This file is intentionally mutable and not managed by Home Manager.
EOF
    fi
  '';
}
