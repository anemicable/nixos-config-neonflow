{ pkgs, ... }:
{
  imports = [
    ../packages/default.nix
    ../cli/default.nix
  ];
}