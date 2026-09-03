{ config, lib, inputs, pkgs, osConfig, ... }:
let
  shellGui = osConfig.systemVars.shellGui;
  isNoctalia = shellGui == "noctalia";
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  # 1. Keeps Noctalia installed 
  programs.noctalia = {
    enable = isNoctalia;
  };

  # 2. Force Hyprland to launch Noctalia on startup
  wayland.windowManager.hyprland = {
    enable = isNoctalia;
    settings = {
      # This is the line that actually runs it when your desktop logs in
      exec-once = [
        "noctalia"
      ];
    };
  };

  # ───────────────────────────────────────────────────────────────────────
  # NOCTALIA CONFIGURATION (Impermanent-friendly)
  # ───────────────────────────────────────────────────────────────────────
  #xdg.configFile."Noctalia" = {
  #  source = config.lib.file.mkOutOfStoreSymlink
  #    "${config.home.homeDirectory}/nixos-config/config/noctalia";  
  #  force = true;
  #};
}
