{ config, pkgs, ... }:
{
    users.users.mistflow = {
     hashedPasswordFile = config.sops.secrets."mistflow_password".path;

     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };
}