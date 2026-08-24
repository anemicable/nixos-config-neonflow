{ pkgs, ... }:
{
    users.users.mistflow = {
     initialPassword = "12345";
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };
}