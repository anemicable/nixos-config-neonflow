{ pkgs, config, lib, ... }:

{
  systemVars = {
    username = "mistflow";
    hostname = "bluebird";
    diskDevice = "/dev/nvme0n1";
    
    guiBuild = "gnome";
    aiIntegrationLevel = "off";

    containerization = "off";
    
  };
}