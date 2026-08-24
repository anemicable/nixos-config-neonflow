{ ... }:

{
  imports = [
    ../packages/default.nix
    ../security/default.nix

    ./boot.nix
    ./system-vars.nix
    ./nix.nix
    ./users.nix
  ];
}