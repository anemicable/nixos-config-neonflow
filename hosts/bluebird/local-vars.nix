{ pkgs, config, lib, ... }:

{
  systemVars = {
    username = "mistflow";
    hostname = "bluebird";
    diskDevice = "/dev/nvme0n1";

    personalEmail = "";
    personalGithubName = "";

    professionalEmail = "";
    professionalGithubName = "";
    
    guiBuild = "niri-dms";
    aiIntegrationLevel = "off";

    containerization = "off";
    
  };
}
