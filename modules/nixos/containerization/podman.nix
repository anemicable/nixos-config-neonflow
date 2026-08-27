{ pkgs, config, ... }:

let
  username = config.systemVars.username;
  containerization = config.systemVars.containerization;
in
{
  virtualisation.podman = {
    enable = containerization == "podman";
    dockerCompat = true;           # для совместимости
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.${username}.extraGroups = [ "podman" ];
}