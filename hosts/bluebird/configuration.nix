{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disk-partitioning.nix
      ./preservation.nix
      ./local-vars.nix

      ../../modules/nixos/core/default.nix
    
      inputs.niri.nixosModules.niri
    ];
  

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.${config.systemVars.username} = import ./home.nix;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; # Did you read the comment?

}
