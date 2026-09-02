
{ config, osConfig, lib, inputs, ... }:

{
  imports = [ 
    #./icons.nix
    ./gtk.nix
    #./nautilus.nix
    ./dms/default.nix
    ./niri/default.nix
  ]

  ++ lib.optionals (osConfig.systemVars.guiBuild == "niri-noctalia") [
    ./niri/default.nix 
  ]

  ++ lib.optionals (osConfig.systemVars.guiBuild == "niri-dms") [
    ./niri/default.nix 
    ./dms/default.nix
  ];

}
