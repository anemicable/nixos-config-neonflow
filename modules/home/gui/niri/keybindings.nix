{ config, pkgs, osConfig, lib, ... }:

let
  configPathCryonic = "${config.home.homeDirectory}/.config/vivaldi-cryonic";

  isNoctalia = osConfig.systemVars.guiBuild == "niri-noctalia";
  isDMS      = osConfig.systemVars.guiBuild == "niri-dms";

  ipcCmd = if isDMS then "dms" else "noctalia-shell";
in
{
  programs.niri.settings.binds = lib.mkMerge [
    {
      # ==================== ОСНОВНЫЕ ====================
      "Mod+Q" = { action.spawn = ["ghostty"]; };
      "Mod+C" = { action.close-window = {}; };
      #"Mod+Esc" = { action.quit = {}; };
      "Mod+E" = { action.spawn = ["nautilus"]; };
      "Mod+F" = { action.toggle-window-floating = {}; };

      "Mod+Z" = { action.spawn = ["vivaldi-cryonic" "--user-data-dir=${configPathCryonic}" "%U"]; };
      "Mod+V" = { action.spawn = ["codium" "--ozone-platform=wayland"]; };
      "Mod+N" = { action.spawn = ["codium" "--new-window" "~/nixos-config" "--ozone-platform=wayland"]; };
      
      "Mod+Shift+P" = { action.spawn = ["pycharm"]; };

      # ==================== ФОКУС ====================
      "Mod+Left"  = { action.focus-column-left = {}; };
      "Mod+Right" = { action.focus-column-right = {}; };
      "Mod+Up"    = { action.focus-window-up-or-column-left = {}; };
      "Mod+Down"  = { action.focus-window-down-or-column-right = {}; };

      # ==================== WORKSPACES ====================
      "Mod+1" = { action.focus-workspace = 1; };
      "Mod+2" = { action.focus-workspace = 2; };
      "Mod+3" = { action.focus-workspace = 3; };
      "Mod+4" = { action.focus-workspace = 4; };
      "Mod+5" = { action.focus-workspace = 5; };
      "Mod+6" = { action.focus-workspace = 6; };
      "Mod+7" = { action.focus-workspace = 7; };
      "Mod+8" = { action.focus-workspace = 8; };
      "Mod+9" = { action.focus-workspace = 9; };
      "Mod+0" = { action.focus-workspace = 10; };

      "Mod+Shift+1" = { action.move-column-to-workspace = 1; };
      "Mod+Shift+2" = { action.move-column-to-workspace = 2; };
      "Mod+Shift+3" = { action.move-column-to-workspace = 3; };
      "Mod+Shift+4" = { action.move-column-to-workspace = 4; };
      "Mod+Shift+5" = { action.move-column-to-workspace = 5; };
      "Mod+Shift+6" = { action.move-column-to-workspace = 6; };
      "Mod+Shift+7" = { action.move-column-to-workspace = 7; };
      "Mod+Shift+8" = { action.move-column-to-workspace = 8; };
      "Mod+Shift+9" = { action.move-column-to-workspace = 9; };
      "Mod+Shift+0" = { action.move-column-to-workspace = 10; };

      # Колёсико
      "Mod+WheelScrollDown" = { action.focus-window-down-or-column-right = {}; };
      "Mod+WheelScrollUp"   = { action.focus-window-up-or-column-left = {}; };

      # ==================== Общие для DMS и Noctalia ====================
      "Mod+R" = { action.spawn = [ipcCmd "ipc" "call" "launcher" "toggle"]; };
      "Mod+A" = { action.spawn = [ipcCmd "ipc" "call" "controlCenter" "toggle"]; };
      "Mod+Ctrl+Comma" = { action.spawn = [ipcCmd "ipc" "call" "settings" "toggle"]; };
    }

    # ==================== Только для DMS ====================
    #(lib.mkIf isDMS {
    #  "Mod+S" = { action.spawn = ["dms" "ipc" "call" "notifications" "toggle"]; };
    #  "Mod+W" = { action.spawn = ["toggle-vpn-dms"]; };
    #  "Mod+M" = { action.spawn = ["dms" "ipc" "call" "media" "toogle"]; };
      # Добавляй сюда другие бинды, специфичные только для DMS
      # "Mod+P" = { action.spawn = ["dms" "ipc" "call" "powerMenu" "toggle"]; };
    #})

    # ==================== Только для Noctalia (если нужно) ====================
    #(lib.mkIf isNoctalia {
    #  "Mod+W" = { action.spawn = ["toggle-vpn-noctalia"]; };
    #  # Пример:
      # "Mod+S" = { action.spawn = ["noctalia-shell" "ipc" "call" "something" "toggle"]; };
    #})
  ];
}