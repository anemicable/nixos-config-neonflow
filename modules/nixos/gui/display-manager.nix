{ config, lib, ... }:
let
  inherit (lib) mkIf mkMerge;
  username = config.systemVars.username;
  dm = config.systemVars.displayManager;
in
{
  services.accounts-daemon.enable = true;
  services.xserver.enable = dm == "gdm";

  services.displayManager = {
    autoLogin = {
      enable = false;
      user = username;
    };
  };

  services.displayManager.gdm.enable = dm == "gdm";

  services.displayManager.dms-greeter = mkIf (dm == "dms-greeter") {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };

}