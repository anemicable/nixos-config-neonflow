{ ... }:

{
  imports = [
    ../packages/default.nix
    ../containerization/default.nix
    ../backups/default.nix
    ../downloads/default.nix
    ../security/default.nix
    ../browsers/default.nix
    ../gui/default.nix
    ../ai-system/default.nix

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