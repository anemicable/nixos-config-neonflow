
{ config, osConfig, lib, inputs, ... }:

{
  imports = [ 
    #./icons.nix
    ./gtk.nix
    #./nautilus.nix
    ./niri/default.nix 
    ./dms/default.nix
  ]

  ++ lib.optionals (osConfig.systemVars.guiBuild == "niri-noctalia") [
    ./niri/default.nix 
    ./noctalia/default.nix 
    #./lock-screen.nix
  ]

  ++ lib.optionals (osConfig.systemVars.guiBuild == "niri-dms") [
    ./niri/default.nix 
    ./dms/default.nix
  ];

}