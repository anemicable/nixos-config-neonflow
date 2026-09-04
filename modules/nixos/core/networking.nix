{ config, ... }:
{
  networking = {
    hostName = config.systemVars.hostname;

    networkmanager.enable = true;

    # proxy.default = "...";
    # proxy.noProxy = "...";
  };

  hardware.enableRedistributableFirmware = true;

  security.sudo.extraRules = [{
    users = [ config.systemVars.username ];
    commands = [{
      command = "/run/current-system/sw/bin/wg-quick";
      options = [ "NOPASSWD" ];
    }];
  }];
}