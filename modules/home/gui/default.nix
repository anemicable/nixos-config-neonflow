
{ config, osConfig, lib, inputs, ... }:

{
  imports = [ 
    #./icons.nix
    ./gtk.nix
    #./nautilus.nix
    ./dms/default.nix
    ./niri/default.nix
    #./noctalia/default.nix
  ];
}
