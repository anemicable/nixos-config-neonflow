
{ pkgs, config, lib, ... } :
let 
  isEnabled = lib.elem "mongodb" config.systemVars.enabledDatabases;
in
{
  services.mongodb = {
    enable = isEnabled;
    package = pkgs.mongodb-ce;  # community edition (pre-compiled); default may compile from source
    #bind_ip, dbPath, etc. as needed
  };
}
