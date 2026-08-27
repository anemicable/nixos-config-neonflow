
{ pkgs, config, ... } :
let
  containerization = config.systemVars.containerization;
in
{
virtualisation.docker = {
  enable = containerization == "docker";
  enableOnBoot = true;          # Start daemon on boot (default is true)
    # storageDriver = "btrfs";    # Or "overlay2", etc., if you have issues with default
  rootless = {
    enable = true;
    setSocketVariable = true; # Sets DOCKER_HOST for your user
  };
  };
}