{ pkgs, config, lib, ... }:

{
  systemVars = {
    username = "mistflow";
    hostname = "moonbox";
    diskDevice = "/dev/nvme0n1";

    guiBuild = "niri-dms";
    aiIntegrationLevel = "full";

    containerization = "podman";

    isLaptop = false;
    
  };
}
