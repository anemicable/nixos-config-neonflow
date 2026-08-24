{
  inputs = {
    # Official NixOS package sources
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Disko - Declarative partitioning and formatting
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Preservation - impermanence build 
    preservation.url = "github:nix-community/preservation";
    
    # Sops Nix - secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations.bluebird = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.default
        ./hosts/bluebird/default.nix
      ];
    };
  };
}
