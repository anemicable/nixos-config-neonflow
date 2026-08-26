{ ... }:

{
  imports = [
    ../packages/default.nix
    ../downloads/default.nix
    ../security/default.nix
    ../gui/default.nix

    ./audio.nix
    ./boot.nix
    ./networking.nix
    ./system-vars.nix
    ./locale.nix
    ./nix.nix
    ./users.nix
    ./terminal.nix
  ];
}