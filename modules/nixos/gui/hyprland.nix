{ pkgs, config, ... }:
let
  windowTilingManager = config.systemVars.windowTilingManager;
  isHyprland = windowTilingManager == "hyprland";
in
{
  # Enable the Hyprland compositor
  programs.hyprland = {
    enable = isHyprland;
    # XWayland is usually needed for older apps/games
    xwayland.enable = true; 
  };
}