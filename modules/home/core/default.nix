{ pkgs, ... }:
{
  imports = [
    ../packages/default.nix
    ../cli/default.nix
    ../gui/default.nix
    ../code/default.nix

    ./file-structure.nix
  ];
}