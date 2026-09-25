{ pkgs, config, lib, ... }:

{
  systemVars = {
    # Basic system variables
    username = "mistflow";
    hostname = "moonbox";
    diskDevice = "/dev/nvme0n1";

    # GUI 
    guiBuild = "niri-noctalia";
    windowTilingManager = "niri";
    shellGui = "dms";

    enabledDatabases = [ "postgresql" ];

    aiIntegrationLevel = "full";

    containerization = "podman";

    isLaptop = false;
    
  };
}
